# OCR-D website

> All the OCR-D documentation and information in one place

## Setup

### Hardware

18.04, >= 8 GB RAM

### Software

First some development pkgs:

```sh
sudo apt install make git ruby-2.5 openjdk-jre python3-pip
```

Then jekyll, in the repo:

```sh
bundle install
```

### Submodules

The OCR-D site requires quite a few sub repositories conveniently laid out in
the `./repo` dir:

* [`gt-guidelines`](`gt-guidelines`): The DITA based guidelines on how Ground
  Truth is to be transcribed into the PAGE XML format. 
* [`ocrd_all`](`ocrd_all`)
* [`ocrd-kwalitee`](`ocrd-kwalitee`)
* [`slides`](`slides`)
* [`spec`](`spec`)

## `make help`
Run `make help` to see a list of commands.

<!-- BEGIN-EVAL make help -->

  Targets

    bootstrap         Set up the repos, site and tools
    gt                Build gt-guidelines. This takes a few minutes. Be patient.
    build-modules     TODO Build module information
    build-processors  TODO Build processor information
    serve             serve the site dynamically
    build-site        build the site
    core-docs         Build sphinx documentation for core
    spec              Build the spec documents TODO translate

  Variables

    REPODIR          Directory containing this Makefile. Don't change it. Default '/data/monorepo/ocrd-website'
    JEKYLL           Which jekyll binary to use. Default 'jekyll'
    DSTDIR           Where to build site. Default '/data/monorepo/ocrd-website/docs'
    SRCDIR           Where site is stored. Default '/data/monorepo/ocrd-website/site'
    GTDIR            Repositories mit dne DITA Quelltexten. Default: /data/monorepo/ocrd-website/repo/gt-guidelines
    JEKYLL_HOST      host to serve from. Default: 10.46.3.57
    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: /data/monorepo/ocrd-website/kwalitee.yml
    LANGS            Languages to build. Default: 'de en'
    LANGS_DST        Guideline langs to build. Default: 

<!-- END-EVAL -->

Activate any virtualenvs before running `make`.

To ensure a complete setup for Debian/Ubuntu based Linuxes: `make bootstrap`

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

Most elements of the page should be made available as both german and english texts.

Use the keys `lang` and `lang-ref` in YAML front matter to control language:
* `lang` should be either `en` or `de`.
* `lang-ref` is a unique arbitrary identifier that marks two pages as translations of each other.

E.g. to create new page about cars:

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
