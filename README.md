# OCR-D website

> All the OCR-D documentation and information in one place

## Setup

Requires jekyll, Python > 3.6, Java, git, make

Run `make help` to see a list of commands.

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
