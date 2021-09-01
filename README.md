# OCR-D website

> All the OCR-D documentation and information in one place

## Setup

### Hardware

18.04, >= 8 GB RAM

### Software

First some development pkgs:

```sh
sudo apt install make git ruby-dev ruby-bundler openjdk-8-jre python3-pip
```

NOTE: The `openjdk-8-jre` dependency is only required for [building the GT guidelines](#rebuild-gt-guidelines).

Then jekyll, in the repo:

```sh
make jekyll
```

This will install jekyll into `./vendor/bundle`.

### Submodules

The OCR-D site requires quite a few sub repositories conveniently laid out in
the `./repo` dir:

* [`gt-guidelines`](repo/gt-guidelines): The DITA based guidelines on how Ground Truth is to be transcribed into the PAGE XML format. 
* [`ocrd_all`](repo/ocrd_all)
* [`ocrd-kwalitee`](repo/ocrd-kwalitee)
* [`slides`](repo/slides)
* [`spec`](repo/spec)
* [`shinlcude`](repo/shinclude)

## `make help`
Run `make help` to see a list of commands.

<!-- BEGIN-EVAL make help -->

  Targets

    deps-ubuntu       ubuntu deps
    jekyll            Install jekyll dependencies
    shinclude         Install shinclude
    bootstrap         Set up the repos, site and tools
    gt                Build gt-guidelines. This takes a few minutes. Be patient.
    build-modules     TODO Build module information
    build-processors  TODO Build processor information
    serve             serve the site dynamically
    build-site        build the site
    core-docs         Build sphinx documentation for core
    spec              Build the spec documents TODO translate
    workflows         Rebuild the workflow document from wiki fragments

  Variables

    REPODIR          Directory containing this Makefile. Don't change it. Default '/home/kba/build/github.com/OCR-D/monorepo/ocrd-website'
    JEKYLL           Which jekyll binary to use. Default 'jekyll'
    DSTDIR           Where to build site. Default '/home/kba/build/github.com/OCR-D/monorepo/ocrd-website/docs'
    SRCDIR           Where site is stored. Default '/home/kba/build/github.com/OCR-D/monorepo/ocrd-website/site'
    GTDIR            Repositories mit dne DITA Quelltexten. Default: /home/kba/build/github.com/OCR-D/monorepo/ocrd-website/repo/gt-guidelines
    JEKYLL_HOST      host to serve from. Default: 10.46.3.57
    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: /home/kba/build/github.com/OCR-D/monorepo/ocrd-website/kwalitee.yml
    LANGS            Languages to build. Default: 'de en'
    LANGS_DST        Guideline langs to build. Default: 

<!-- END-EVAL -->

Activate any virtualenvs before running `make`.

To ensure a complete setup for Debian/Ubuntu based Linuxes: `make bootstrap`. This will test whether all the tools are installed and offer remediation if not.

## Directory structure

* `docs`: This is where the site will be built. Never touch it.
* `site`: This is the jekyll site. Posts and Pages live here.
* `repo`: Contains required subrepos
* `layout.html`: Template for the layout for sphinx-doc to use. to be run through shinclude

## Rebuild gt-guidelines

```
make gt
```

## Multilinguality

Most elements of the page should be made available as both German and English texts.

Use the keys `lang` and `lang-ref` in YAML front matter to control language:
* `lang` should be either `en` or `de`.
* `lang-ref` is a unique arbitrary identifier that marks two pages as translations of each other.

E.g. to create a new page about cars:

`site/en/cars.md`

```markdown
---
title: The interestingness of cars never ceases to amaze
lang: en
lang-ref: that-weird-cars-page
---

# Cars ...

amazing aren't they?
```

`site/de/autos.md`:

```markdown
---
title: Autos sollen gekauft werden
lang: de
lang-ref: that-weird-cars-page
---

weil es fuer die wirtschaft gut ist.
```

You could then go to https://ocr-d.de/en/cars and to https://ocr-d.de/de/autos from there.

## Deploying the site

First, clone https://github.com/OCR-D/ocr-d.github.io:

```sh
git clone https://github.com/OCR-D/ocr-d.github.io:
```

Then, rebuild the website to render the changes to Markdown to HTML:


```sh
make build-site
```

Copy all the contents of `./docs` to `ocr-d.github.io`:

```sh
cp -r ./docs/* ocr-d.github.io
```

Commit and push the changes in `ocr-d.github.io`:

```sh
cd ocr-d.github.io
git add .
git commit -m 'website updated'
```

## Changing the menu

The menus are generated from the YAML file `site/_data/menu.yml`.

Every menu entry
  * **MUST** have a `url` field
  * **MUST** have a `label` field
  * **MAY** have a `children` field for a submenu

Both `url` and `label` can be either a string or an object with keys `de` and
`en`. In the former case, `url` or `label` are the same across languages, in
the latter case, you can adapt it per language.

`url` should not include the `/en` or `/de` prefix unless the page in question
is only available in one language.

## Updating publications

- Go to https://www.zotero.org/groups/418719/ocr-d
- Select all items (Hold Shift to mark in bulk, Ctrl-leftclick to mark the first entry)
- Export as "Zotero RDF"
- Open Zotero Desktop
- Import collection from file
- Delete all "Presentation" (for "articles", delete everything else for "presentations")
- Sort reverse by date
- Select all
- Right click -> export bibliography
- Use `OCRD_infoclio.ch` style
- Export as html, save as `pub.html`
- Edit `pub.html`, crop to just the `<body>` contents
- Replace some minor inconsistencies in Zotero's HTML output:
  - `sed -i 's,>/slides,>https://ocr-d.de/slides,' pub.html`
  - `sed -i 's,doi.org//,ocr-d.de/,' pub.html`
- paste `pub.html` into `site/en/publications.md` or `site/de/publications.md`

## Updating workflows

The [workflows](https://ocr-d.de/en/workflows) page is built from pages on inidividual steps in the [OCR-D wiki](https://github.com/OCR-D/ocrd-website.wiki).

To automate this, you need to have [shinclude](https://github.com/kba/shinclude) installed with `make shinclude`.

Make sure that `repo/ocrd-website.wiki` is up-to-date: `cd repo/ocrd-website.wiki; git pull origin master`.

`make workflows` will generate `site/en/workflows.md` from the wiki fragments. Inspect it for consistency before merging.
