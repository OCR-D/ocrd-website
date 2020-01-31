SHELL = bash

# Which jekyll binary to use. Default '$(JEKYLL)'
JEKYLL = jekyll

# Where to build site. Default '$(BUILDDIR)'
BUILDDIR = docs

# Where site is stored. Default '$(SRCDIR)'
SRCDIR = site

# Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)
KWALITEE_CONFIG = kwalitee.yml

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    bootstrap                Set up the repos, site and tools"
	@echo "    data                     Build data"
	@echo "    gt-guidelines            Build gt-guidelines"
	@echo "    build-modules            Build module information"
	@echo "    build-processors         Build processor information"
	@echo "    serve-site               serve the site"
	@echo "    build-site               build the site"
	@echo "    build-site-continuously  build the site"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    JEKYLL           Which jekyll binary to use. Default '$(JEKYLL)'"
	@echo "    BUILDDIR         Where to build site. Default '$(BUILDDIR)'"
	@echo "    SRCDIR           Where site is stored. Default '$(SRCDIR)'"
	@echo "    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)"

# END-EVAL

# Set up the repos, site and tools
bootstrap:
	git submodule sync
	git submodule update
	java --version || echo "apt install openjdk-jre"
	pip3 --version || echo "apt install python3-pip"
	jekyll --version || echo "gem install jekyll"
	cd repo/ocrd-kwalitee && pip install -e .
	cd repo/gt-guidelines && make deps

# Build gt-guidelines
gt-guidelines: repo/gt-guidelines
	rm -rf $(SRCDIR)/{de,en}/gt-guidelines
	for lang in en de;do \
		make -C repo/gt-guidelines \
		GT_DOC_OUT=$(PWD)/$(SRCDIR)/$$lang/gt-guidelines \
		DITA_PROPERTY_FILE=<(sed 's, site,$(PWD)/site,' dita-ot-html5.properties) \
		ANT_OPTS="" \
		build; \
		(cd site/$$lang/gt-guidelines; find -name '*.html' -exec sed -i "1 i ---\nlayout: page\nlang: de\nlang-ref: {}\n---\n" {} \;) ; \
	done

# Build data
data: $(SRCDIR)/_data/ocrd-repo.json

$(SRCDIR)/_data/ocrd-repo.json: $(KWALITEE_CONFIG)
	mkdir -p $(dir $@)
	ocrd-kwalitee -c "$(KWALITEE_CONFIG)" json > "$@"

# Build module information
build-modules: ocrd-kwalitee.json
	@echo NIH

# Build processor information
build-processors:
	@echo NIH

# serve the site
serve-site:
	jekyll serve -s $(SRCDIR)

# build the site
build-site:
	jekyll build -s $(SRCDIR) -d $(BUILDDIR)

# build the site
build-site-continuously:
	jekyll build --watch -s $(SRCDIR) -d $(BUILDDIR)

deploy:
	git add .
	git commit -m "Update `date`"
	git push

core-docs:
	rm -rf site/core
	mkdir -p repo/ocrd_all/core/docs/_templates
	shinclude layout.html > repo/ocrd_all/core/docs/_templates/layout.html
	cd repo/ocrd_all/core && make docs
	cp -r repo/ocrd_all/core/docs/build/html site/core

