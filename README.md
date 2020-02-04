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
    gt-guidelines     Build gt-guidelines. This takes a few minutes. Be patient.
    data              Build ocrd-kwalitee data
    build-modules     TODO Build module information
    build-processors  TODO Build processor information
    serve-site        serve the site
    build-site        build the site
    core-docs         Build sphinx documentation for core
    spec              Build the spec documents TODO translate

  Variables

    JEKYLL           Which jekyll binary to use. Default 'jekyll'
    BUILDDIR         Where to build site. Default 'docs'
    SRCDIR           Where site is stored. Default 'site'
    KWALITEE_CONFIG  Configuration file for ocrd-kwalitee. Default: kwalitee.yml

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
make gt-guidelines
```
