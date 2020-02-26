TEXMASTER = ocr-perspektiven.tex
TEXOTHER = \
	mooColors.sty \
	Makefile

TARGETS=$(TEXMASTER:.tex=.pdf)



ARCNAME = $(shell basename $(PWD))
STAMPSUFFIX = $(shell date -I)-$(shell hostname -s)
ARCTARGETS = \
	$(TEXMASTER) \
	$(TEXOTHER) \
	$(ARCOTHER)


##--------------------------------------------------------------
## RULES
##--------------------------------------------------------------
all: $(TARGETS)

##--------------------------------------------------------------
## Patterns
##--------------------------------------------------------------

##-- PDF
#XDF = acroread
#XPDF = xpdf
#XPDF = xpdf -z width
XPDF = xpdf -z page
XPDF_FS = xpdf -z page -fullscreen -bg black

PS2PDF ?= ps2pdf -sPAPERSIZE=a4 -dPDFsettings=/prepress -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode

%.pdf: %.ps
	$(PS2PDF) $<

pdf: $(TEXMASTER:.tex=.pdf)

xpdf: $(TEXMASTER:.tex=.pdf)
	$(XPDF) $< &

xpdf-fs: $(TEXMASTER:.tex=.pdf)
	$(XPDF_FS) $< &

##-- ACROREAD
ACRO = acroread

acro: acroread

acroread: $(TEXMASTER:.tex=.pdf)
	$(ACRO) $< &

## -- PS
DVIPS ?= dvips -t landscape
ps: $(TEXMASTER:.tex=.ps)

%.ps: %.dvi
	$(DVIPS) $<

xps: $(TEXMASTER:.tex=.ps)
	gv -spartan -orientation=seascape $< &

xps-fs: pspresent
pspresent: $(TEXMASTER:.tex=.ps)
	pspresent -o -O Landscape $< &

## -- PS{2,4}
ps2: $(TEXMASTER:.tex=.ps2)
%.ps2: %.ps
	psnup -2 -b 12 -d0.5 -l "$<" "$@"
#	psnup -2 -b 12 -l "$<" "$@"
xps2: $(TEXMASTER:.tex=.ps2)
	gv -spartan -orientation=upside-down "$<" &

ps4: $(TEXMASTER:.tex=.ps4)
%.ps4: %.ps
	psnup -4 -b 24 -d1 -l "$<" "$@"
xps4: $(TEXMASTER:.tex=.ps4)
	gv -spartan -orientation=landscape "$<" &



## -- LaTeX
latex: $(TEXMASTER) $(TEXOTHER)
	test -d plots && $(MAKE) -C plots || true
	test -d figs && $(MAKE) -C figs || true
	test -d exprog && $(MAKE) -C exprog || true
	latex $<


## -- DVI
%.dvi: %.tex $(TEXOTHER)
	latex $<

dvi: $(TEXMASTER:.tex=.dvi)

xdvi: $(TEXMASTER:.tex=.dvi)
	xdvi $< &

aux: $(TEXMASTER:.tex=.aux)
%.aux: %.tex
	latex $<

## -- BIB
bbl: $(TEXMASTER:.tex=.bbl)
%.bbl: %.bib aux
	bibtex $*

##--------------------------------------------------------------
## Archive
##--------------------------------------------------------------
arc: $(ARCNAME).tar.bz2

stamp: $(ARCNAME)-$(STAMPSUFFIX).tar.bz2

%.tar.bz2:
	mkdir $*
	cp -a $(ARCTARGETS) $*
	tar cvjf $*.tar.bz2 $*
	rm -rf $*


##--------------------------------------------------------------
## clean
##--------------------------------------------------------------
clean:
	rm -f *~ *.pdf *.ps *.dvi *.aux *.log *.toc *.out
	test -d plots && $(MAKE) -C plots clean || true
	test -d figs && $(MAKE) -C figs clean || true
	test -d exprog && $(MAKE) -C exprog clean || true

realclean: clean
	test -d plots && $(MAKE) -C plots realclean || true
	test -d figs && $(MAKE) -C figs realclean || true
	test -d exprog && $(MAKE) -C exprog realclean || true
