# Which jekyll binary to use. Default '$(JEKYLL)'
JEKYLL = jekyll

# Where to build site. Default '$(BUILDDIR)'
BUILDDIR = docs

# Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)
KWALITEE_CONFIG = kwalitee.yml

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    bootstrap                Set up the repos, site and tools"
	@echo "    data                     Build data"
	@echo "    build-modules            Build module information"
	@echo "    build-processors         Build processor information"
	@echo "    build-site               build the site"
	@echo "    build-site-continuously  build the site"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    JEKYLL           Which jekyll binary to use. Default '$(JEKYLL)'"
	@echo "    BUILDDIR         Where to build site. Default '$(BUILDDIR)'"
	@echo "    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: $(KWALITEE_CONFIG)"

# END-EVAL

# Set up the repos, site and tools
bootstrap:
	git submodule sync
	git submodule update
	cd repo/ocrd-kwalitee ; pip install .

# Build data
data: _data/ocrd-repo.json

# Build gt-guidelines
gt-guidelines: repo/gt-guidelines
	cd $<  && make markdown GT_DOC_OUT=$(PWD)/gt-guidelines ANT_OPTS=""

_data/ocrd-repo.json: $(KWALITEE_CONFIG)
	mkdir -p $(dir $@)
	ocrd-kwalitee -c "$(KWALITEE_CONFIG)" json > "$@"

# Build module information
build-modules: ocrd-kwalitee.json
	@echo NIH

# Build processor information
build-processors:
	@echo NIH

# build the site
build-site:
	jekyll build -d $(BUILDDIR)

# build the site
build-site-continuously:
	jekyll build --watch -d $(BUILDDIR)

deploy:
	git add .
	git commit -m "Update `date`"
	git push
