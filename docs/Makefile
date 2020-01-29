# Which jekyll binary to use. Default '$(JEKYLL)'
JEKYLL = jekyll

# Where to build site. Default '$(BUILDDIR)'
BUILDDIR = docs

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    build-modules     Build module information"
	@echo "    build-processors  Build processor information"
	@echo "    build-site        build the site"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    JEKYLL    Which jekyll binary to use. Default '$(JEKYLL)'"
	@echo "    BUILDDIR  Where to build site. Default '$(BUILDDIR)'"

# END-EVAL

ocrd-kwalitee/repos.json:
	cd $(dir $@); make -B repos.json

# Build module information
build-modules: ocrd-kwalitee.json
	@echo NIH

# Build processor information
build-processors:
	@echo NIH

# build the site
build-site:
	jekyll build -d $(BUILDDIR)

deploy: build
	git add .
	git commit -m 'Update `date`'
	git push
