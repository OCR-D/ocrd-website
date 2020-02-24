# webfont-dl is a tool to download web fonts from the Google Fonts API
FONT_URLS = https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic

DOWNLOAD_FIGURE = cd figure && wget -nc


# Port to run server on. Default: $(PORT)
PORT=8082

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    css/fonts.css  Download fonts"
	@echo "    slides.pdf     build the PDF"
	@echo "    build          Build HTML files"
	@echo "    serve          Run server on localhost:$(PORT)"
	@echo "    figures        Download and rename figures"
	@echo ""
	@echo "  Variables"
	@echo ""
	@echo "    FONT_URLS  webfont-dl is a tool to download web fonts from the Google Fonts API"
	@echo "    PORT       Port to run server on. Default: $(PORT)"

# END-EVAL

# Download fonts
css/fonts.css:
	webfont-dl  --eot=omit -o $@ --font-out=fonts $(FONT_URLS)

# build the PDF
slides.pdf: index.html
	docker run --rm -v `pwd`:/slides astefanutti/decktape index.html slides.pdf

# Build HTML files
build: index.html setup-time.html praxis-gt.html

index.html: index.md
	grip --export $< $@

setup-time.html: setup-time.md
	grip --export $< $@

praxis-gt.html: praxis-gt.md
	grip --export $< $@


# Run server on localhost:$(PORT)
serve: index.html
	python3 -m http.server $(PORT)

# Download and rename figures
.PHONY: figures
figures:
	$(DOWNLOAD_FIGURE) 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Heaps_of_books_%28Unsplash%29.jpg/1024px-Heaps_of_books_%28Unsplash%29.jpg'
	$(DOWNLOAD_FIGURE) 'https://www.getpostman.com/img/v2/postman/Postman-most-complete-toolchain.png'
	$(DOWNLOAD_FIGURE) 'https://dig-hum.de/sites/dig-hum.de/files/styles/large/public/ocrd_0.jpg'
	$(DOWNLOAD_FIGURE) 'https://orig00.deviantart.net/1723/f/2010/235/9/9/black_box_by_hemmamann.png'
	$(DOWNLOAD_FIGURE) 'http://asv.informatik.uni-leipzig.de/images/asv/asv-logo.png'
	$(DOWNLOAD_FIGURE) 'http://www.dh.uni-leipzig.de/wo/wp-content/uploads/2014/03/logo_dh_wid-300x57.png'
	$(DOWNLOAD_FIGURE) 'http://iui.dfki.de/wp-content/themes/dfki_2018_theme/img/DFKI_Logo_d_schrift.jpg'
	$(DOWNLOAD_FIGURE) 'http://www.is.informatik.uni-wuerzburg.de/fileadmin/_migrated/pics/ls6logo.gif'
	$(DOWNLOAD_FIGURE) 'https://www5.cs.fau.de/images/lme.jpg'
	$(DOWNLOAD_FIGURE) 'https://www.buchwissenschaft.uni-mainz.de/wp-content/uploads/2017/01/Logo_Buchwissenschaft_Mainz.png'
	$(DOWNLOAD_FIGURE) 'https://listserv.gwdg.de/images/GWDG_Logo_invert.png'
	$(DOWNLOAD_FIGURE) 'https://cdn.pixabay.com/photo/2018/01/12/16/16/growth-3078543_1280.png'
	$(DOWNLOAD_FIGURE) 'https://farm1.staticflickr.com/76/196079076_ef3d5172dc_o_d.jpg'
	$(DOWNLOAD_FIGURE) 'https://cdn.pixabay.com/photo/2015/10/15/04/19/community-988898_1280.png'
	$(DOWNLOAD_FIGURE) 'https://static01.nyt.com/images/2007/10/22/technology/22library.600.jpg'
	$(DOWNLOAD_FIGURE) 'https://c.pxhere.com/photos/4c/91/hammer_nails_wood_board_tool_work_construction_builder-518257.jpg!d'
	cd figure ; rename -v -f 's,[^A-Za-z0-9\.-]+,_,g' *; rename -v -f 's/.jpg_d$$/.jpg/' *

