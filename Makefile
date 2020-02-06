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
	@echo "    bootstrap         Set up the repos, site and tools"
	@echo "    gt                Build gt-guidelines. This takes a few minutes. Be patient."
	@echo "    build-modules     TODO Build module information"
	@echo "    build-processors  TODO Build processor information"
	@echo "    serve-site        serve the site"
	@echo "    serve-from-sbb    serve the site so at least @cneud and @kba can see it"
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
	@echo "    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)"
	@echo "    LANGS            Languages to build. Default: '$(LANGS)'"
	@echo "    LANGS_DST        Guideline langs to build. Default: $(GT_LANGS)"

# END-EVAL

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

$(LANGS_DST): $(GTDIR)/% : $(SRCDIR)/%/gt-guidelines
	make -C "$(GTDIR)" \
	ANT_OPTS="" \
	GT_DOC_OUT="$<" \
	build;
#     (
#         cd "$<";
#         find -name '*.html' | while read html;do \
#             grep --max-count 1 --line-regexp '^---' "$$html" || \
#             sed -i "1 i ---\nlayout: page\nlang: de\nlang-ref: {}\n---\n" {} \;) ; \
#         done
#     )

# Build ocrd-kwalitee data
# data: $(SRCDIR/_data/ocrd-repo.json

$(SRCDIR)/_data/ocrd-repo.json: $(KWALITEE_CONFIG)
	mkdir -p $(dir $@)
	ocrd-kwalitee -c "$(KWALITEE_CONFIG)" json > "$@"

# TODO Build module information
build-modules: ocrd-kwalitee.json
	@echo NIH

# TODO Build processor information
build-processors:
	@echo NIH

# serve the site
serve-site:
	jekyll serve -s $(SRCDIR)

# serve the site so at least @cneud and @kba can see it
serve-from-sbb:
	jekyll serve \
		--baseurl '' \
		--host 10.46.3.57 \
		--port 4040 \
		--watch \
		--strict_front_matter \
		-s '$(SRCDIR)' -d '$(DSTDIR)'

# build the site
build-site:
	jekyll build -s $(SRCDIR) -d $(DSTDIR)

deploy:
	git add .
	git commit -m "Update `date`"
	git push

# Build sphinx documentation for core
core-docs:
	rm -rf site/core ; \
	tempdir=`tempfile -d /tmp/core. -s XXXXX`;  \
	rm -f "$$tempdir" ; \
	git clone repo/ocrd_all/core "$$tempdir"; \
	mkdir -p "$$tempdir"/_templates; \
	shinclude layout.html > "$$tempdir"/_templates; \
	cd "$$tempdir" && make docs; \
	mv "$$tempdr/docs/build/html" site/core; \
	rm -rf "$$tempdir"

# Build the spec documents TODO translate
spec:
	for lang in en de;do \
		mkdir -p $(SRCDIR)/$$lang/spec; \
		find repo/spec -name '*.md'|while read md;do \
			grep --max-count 1 --line-regexp '^---' "$$md" && \
			basename=$$(basename $$md); \
			|| sed  "1 i ---\nlayout: page\nlang: $$lang\nlang-ref: $$basename\ntoc: true\n---\n" $$md \
			> $(SRCDIR)/$$lang/spec/$$basename; \
		done; \
	done
