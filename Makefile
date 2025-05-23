SHELL = bash
RM = rm -rvf

# Directory containing this Makefile. Don't change it. Default '$(REPODIR)'
REPODIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Which jekyll binary to use. Default '$(JEKYLL)'
JEKYLL = jekyll

# Where to build site. Default '$(DSTDIR)'
DSTDIR := $(REPODIR)/docs

# Where site is stored. Default '$(SRCDIR)'
SRCDIR := $(REPODIR)/site

# Repository with DITA source texts. Default: $(GTDIR)
GTDIR := $(REPODIR)/repo/gt-guidelines

# Host to serve from. Default: $(JEKYLL_HOST)
JEKYLL_HOST = 10.46.3.57

# Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)
KWALITEE_CONFIG := $(REPODIR)/kwalitee.yml

# Languages to build. Default: '$(LANGS)'
LANGS = de en
.PHONY: LANGS

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    deps-ubuntu       ubuntu deps"
	@echo "    jekyll            Install jekyll dependencies"
	@echo "    shinclude         Install shinclude"
	@echo "    bootstrap         Set up the repos, site and tools"
	@echo "    gt                Build gt-guidelines. This takes a few minutes. Be patient."
	@echo "    build-modules     TODO Build module information"
	@echo "    build-processors  TODO Build processor information"
	@echo "    serve             serve the site dynamically"
	@echo "    build-site        build the site"
	@echo "    core-docs         Build sphinx documentation for core"
	@echo "    spec              Build the spec documents TODO translate"
	@echo "    workflows         Rebuild the workflow document from wiki fragments"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    REPODIR          Directory containing this Makefile. Don't change it. Default '$(REPODIR)'"
	@echo "    JEKYLL           Which jekyll binary to use. Default '$(JEKYLL)'"
	@echo "    DSTDIR           Where to build site. Default '$(DSTDIR)'"
	@echo "    SRCDIR           Where site is stored. Default '$(SRCDIR)'"
	@echo "    GTDIR            Repository with DITA source texts. Default: $(GTDIR)"
	@echo "    JEKYLL_HOST      Host to serve from. Default: $(JEKYLL_HOST)"
	@echo "    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)"
	@echo "    LANGS            Languages to build. Default: '$(LANGS)'"
	@echo "    LANGS_DST        Guideline langs to build. Default: $(GT_LANGS)"

# END-EVAL


# ubuntu deps
deps-ubuntu:
	sudo apt-get install ruby-dev ruby-bundler

# Install jekyll dependencies
jekyll:
	bundle config set --local path 'vendor/bundle'
	bundle install

# Install shinclude
shinclude:
	cd repo/shinclude; \
		make install PREFIX=$(HOME)/.local

# Set up the repos, site and tools
bootstrap:
	git submodule sync
	git submodule update --init
	bundle --version || "bundle is not available, try 'make deps-ubuntu'"
	java -version || echo "java not available, needed for the GT guidelines. try 'sudo apt install openjdk-8-jre'"
	pip3 --version || echo "pip3 not available, needed for kwalitee. try 'sudo apt install python3-pip' or activating a venv"
	jekyll --version || echo "jekyll not available, try 'make jekyll'"
	shinclude --help || echo "shinclude ist not available, try 'make shinclude'"
	cd repo/ocrd-kwalitee && pip install -e .
	cd $(GTDIR) && make deps


LANGS_DST = $(LANGS:%=$(SRCDIR)/%/gt-guidelines)

# Build gt-guidelines. This takes a few minutes. Be patient.
gt: $(LANGS_DST)
.PHONY: $(LANGS_DST)

$(LANGS_DST): $(SRCDIR)/%/gt-guidelines : $(GTDIR)/%
	make -C "$(GTDIR)" ANT_OPTS="" LANG="$*" GT_DOC_OUT="$@" build; \

# Build ocrd-kwalitee data
# data: $(SRCDIR/_data/ocrd-repo.json

$(SRCDIR)/_data/ocrd-repo.json: $(KWALITEE_CONFIG)
	mkdir -p $(dir $@)
	ocrd-kwalitee -c "$(KWALITEE_CONFIG)" json > "$@"

.PHONY: ocrd-all-tool
ocrd-all-tool: $(SRCDIR)/js/ocrd-all-tool.json
$(SRCDIR)/js/ocrd-all-tool.json: $(KWALITEE_CONFIG)
	mkdir -p $(dir $@)
	ocrd-kwalitee -c "$(KWALITEE_CONFIG)" ocrd-tool > "$@"

# TODO Build module information
build-modules: ocrd-kwalitee.json
	@echo NIH

# TODO Build processor information
build-processors:
	@echo NIH

# serve the site dynamically
serve:
	bundle exec jekyll serve \
		--baseurl '' \
		--host $(JEKYLL_HOST) \
		--port 4040 \
		--trace \
		--watch \
		--strict_front_matter \
		-s '$(SRCDIR)' -d '$(DSTDIR)'

# build the site
build-site:
	bundle exec jekyll build \
		--strict_front_matter \
		-s '$(SRCDIR)' -d '$(DSTDIR)'

deploy:
	cd repo/ocr-d.github.io; \
		git clean -df; \
		git checkout .; \
		git checkout master; \
		git pull
	cp -r docs/* repo/ocr-d.github.io
	cd repo/ocr-d.github.io; \
		git add .; \
		git commit -m "Update `date`" ;\
		git push;
	git add .
	git commit -m "Update `date`" ;\
	git push

# Build sphinx documentation for core
core-docs:
	make -C repo/core docs
	rm -rf site/core
	mkdir site/core
	mv repo/core/docs/build/html/* site/core

# Build the spec documents TODO translate
spec:
	python3 yaml-to-json.py --indent 0 repo/spec/ocrd_tool.schema.yml repo/spec/ocrd_tool.schema.json
	python3 yaml-to-json.py --indent 0 repo/spec/bagit-profile.yml repo/spec/bagit-profile.json
	# -cd repo/spec; traf -o json gt-profile.yml
	# -cd repo/spec; traf -o json single-line.yml
	# -cd repo/spec; traf -o json training-schema.yml
	# -cd repo/spec; traf -o json model-evaluation-schema.yml
	cd repo/spec; shinclude -c xml -i cli.md 2>/dev/null
	cd repo/spec; shinclude -c xml -i ocrd_tool.md 2>/dev/null
	cd repo/spec; shinclude -c xml -i ocrd_zip.md 2>/dev/null
	mkdir -p $(SRCDIR)/en/spec $(SRCDIR)/de/spec; \
	find repo/spec -name '*.md'|while read md;do \
		basename=$$(basename $$md); \
		title=$$(grep --max-count 1 '^# ' $$md|sed 's,# ,,'); \
		lang="en"; \
		if [[ "$$md" = *.de.md ]];then \
			basename=$$(basename $$md|sed 's,\.de\.md,.md,'); \
			lang="de"; \
		fi; \
		sed  "1 i ---\nlayout: page\nlang: $$lang\nlang-ref: $$basename\ntoc: true\ntitle: $$title\n---\n" $$md \
		> $(SRCDIR)/$$lang/spec/$$basename; \
	done;
	cp -t $(SRCDIR)/en/spec repo/spec/bagit-profile.json
	cp -t $(SRCDIR)/en/spec repo/spec/ocrd_tool.schema.json
	cp -t $(SRCDIR)/en/spec repo/spec/openapi.yml
	cp -t $(SRCDIR)/de/spec repo/spec/bagit-profile.json
	cp -t $(SRCDIR)/de/spec repo/spec/ocrd_tool.schema.json
	cp -t $(SRCDIR)/de/spec repo/spec/openapi.yml
	cp -t $(SRCDIR)/assets repo/spec/assets/*


.PHONY: workflows

# Rebuild the workflow document from wiki fragments
workflows: site/en/workflows.md

site/en/workflows.md: site/en/workflows.src.md $(wildcard repo/ocrd-website.wiki/Workflow-Guide-*.md)
	SHLOG_TERM=info shinclude -c xml site/en/workflows.src.md > $@
	@echo "!!!"
	@echo "!!! Manually edit site/en/workflows.md before comitting!"
	@echo "!!!"

shortcuts:
	mkdir -p site/goto
	while read line;do \
		slug_and_url=($${line}); \
		slug=$${slug_and_url[0]}; \
		url=$${slug_and_url[1]}; \
		dir=site/goto/$$slug; \
		index_html=$$dir/index.html; \
		mkdir -p $$dir; \
		sed "s,{{ url }},$$url,g" shortcuts.template.html > $$index_html; \
	done < shortcuts.txt
