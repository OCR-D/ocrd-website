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

# Repositories mit dne DITA Quelltexten. Default: $(GTDIR)
GTDIR := $(REPODIR)/repo/gt-guidelines

# host to serve from. Default: $(JEKYLL_HOST)
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
	@echo "    bootstrap         Set up the repos, site and tools"
	@echo "    gt                Build gt-guidelines. This takes a few minutes. Be patient."
	@echo "    build-modules     TODO Build module information"
	@echo "    build-processors  TODO Build processor information"
	@echo "    serve             serve the site dynamically"
	@echo "    build-site        build the site"
	@echo "    core-docs         Build sphinx documentation for core"
	@echo "    spec              Build the spec documents TODO translate"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    REPODIR          Directory containing this Makefile. Don't change it. Default '$(REPODIR)'"
	@echo "    JEKYLL           Which jekyll binary to use. Default '$(JEKYLL)'"
	@echo "    DSTDIR           Where to build site. Default '$(DSTDIR)'"
	@echo "    SRCDIR           Where site is stored. Default '$(SRCDIR)'"
	@echo "    GTDIR            Repositories mit dne DITA Quelltexten. Default: $(GTDIR)"
	@echo "    JEKYLL_HOST      host to serve from. Default: $(JEKYLL_HOST)"
	@echo "    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)"
	@echo "    LANGS            Languages to build. Default: '$(LANGS)'"
	@echo "    LANGS_DST        Guideline langs to build. Default: $(GT_LANGS)"

# END-EVAL


# ubuntu deps
deps-ubuntu:
	sudo apt-get install ruby-dev ruby-bundler

# Install jekyll dependencies
jekyll:
	bundle install --path vendor/bundle

# Set up the repos, site and tools
bootstrap:
	git submodule sync
	git submodule update --init
	java --version || echo "apt install openjdk-jre"
	pip3 --version || echo "apt install python3-pip"
	jekyll --version || echo "gem install jekyll"
	cd repo/ocrd-kwalitee && pip install -e .
	cd $(GTDIR) && make deps


# Guideline langs to build. Default: $(GT_LANGS)
LANGS_DST = $(LANGS:%=$(GTDIR)/%)

# Build gt-guidelines. This takes a few minutes. Be patient.
gt: $(LANGS_DST)
.PHONY: $(LANGS_DST)

$(LANGS_DST): $(GTDIR)/% : $(SRCDIR)/%/gt-guidelines
	make -C "$(GTDIR)" \
	ANT_OPTS="" \
	LANG="$(subst $(SRCDIR)/,,$(subst /gt-guidelines,,$<))" \
	GT_DOC_OUT="$<" \
	build;
	cd "$<" ; find -name '*.html' | while read html;do \
		grep --max-count 1 --line-regexp '^---' -q "$$html" || \
		sed -i "1 i ---\nlayout: page\nlang: $(subst $(SRCDIR)/,,$(subst /gt-guidelines,,$<))\nlang-ref: $$html\n---\n" $$html ; \
	done

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
		--watch \
		--strict_front_matter \
		-s '$(SRCDIR)' -d '$(DSTDIR)'

# build the site
build-site:
	bundle exec jekyll build \
		--strict_front_matter \
		-s '$(SRCDIR)' -d '$(DSTDIR)'

deploy:
	git add .
	git commit -m "Update `date`"
	git push

# Build sphinx documentation for core
core-docs:
	rm -rf site/core ; \
	tempdir=`tempfile -d /tmp/core. -s XXXXX`;  \
	rm -f "$$tempdir" ; \
	git clone --depth 1 https://github.com/OCR-D/core "$$tempdir"; \
	make -C "$$tempdir" docs; \
	mv "$$tempdir/docs/build/html" site/core; \
	find site/core -name '*.html' | while read html;do \
		grep --max-count 1 --line-regexp '^---' -q "$$html" || \
		sed -i "1 i ---\nlayout: page\nlang: en\n---\n" $$html ; \
	done; \
	rm -rf "$$tempdir"

# Build the spec documents TODO translate
spec:
	cd repo/spec; traf -o json ocrd_tool.schema.yml
	cd repo/spec; traf -o json bagit-profile.yml
	# -cd repo/spec; traf -o json gt-profile.yml
	# -cd repo/spec; traf -o json single-line.yml
	# -cd repo/spec; traf -o json training-schema.yml
	# -cd repo/spec; traf -o json model-evaluation-schema.yml
	cd repo/spec; shinclude -c xml -i cli.md 2>/dev/null
	cd repo/spec; shinclude -c xml -i ocrd_tool.md 2>/dev/null
	cd repo/spec; shinclude -c xml -i ocrd_zip.md 2>/dev/null
	for lang in en de;do \
		mkdir -p $(SRCDIR)/$$lang/spec; \
		find repo/spec -name '*.md'|while read md;do \
			basename=$$(basename $$md); \
			grep --max-count 1 --line-regexp '^---' "$$md" \
			|| sed  "1 i ---\nlayout: page\nlang: $$lang\nlang-ref: $$basename\ntoc: true\n---\n" $$md \
			> $(SRCDIR)/$$lang/spec/$$basename; \
		done; \
	done

site/en/workflows.md: site/en/workflows.src.md $(wildcard repo/ocrd-website.wiki/Workflow-Guide-*.md)
	SHLOG_TERM=info shinclude -c xml site/en/workflows.src.md > $@
	@echo "!!!"
	@echo "!!! Manually edit site/en/workflows.md before comitting!"
	@echo "!!!"

