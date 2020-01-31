---
layout: page
lang: en
lang-ref: installation
---
# Installation OCR-D stack

## Notation

Commands like this

```sh
sudo apt-get install python3
```

must be executed in a terminal.

## Basic setup

### Operating System

Currently we only support Ubuntu 18.04 and 18.10.

### Python

You need to have Python 3.6 installed:

```sh
sudo apt-get install python3 python3-virtualenv
```

### Setup a virtualenv

We set up a dedicated environment to install Python packages to:

```sh
python3 -m virtualenv ~/env-ocrd
```

### Activate virtualenv

```sh
source ~/env-ocrd/bin/activate
```

### Install ocrd core software

```sh
pip install ocrd
```

Verify it has been installed by calling the `ocrd` command line tool:

```sh
ocrd --help
```

Output should be similar to

```
Usage: ocrd [OPTIONS] COMMAND [ARGS]...

  CLI to OCR-D

Options:
  --version                       Show the version and exit.
  -l, --log-level [OFF|ERROR|WARN|INFO|DEBUG|TRACE]
                                  Log level
  --help                          Show this message and exit.

Commands:
  bashlib    Work with bash library
  ocrd-tool  Work with ocrd-tool.json JSON_FILE
  process    Process a series of tasks
  workspace  Working with workspace
  zip        Bag/Spill/Validate OCRD-ZIP bags
```

## OCR-D Modules

Functionality is encapsulated in module projects which can be individually installed and combined.

We recommend the following projects to get started:

* ocrd_ocropy
* ocrd_kraken
* ocrd_tesserocr


### ocrd_ocropy

```sh
pip install ocrd_ocropy
```

Verify:

```sh
ocrd-ocropy-segment --help
```

### ocrd_kraken

```sh
pip install ocrd_ocropy
```

Verify:

```sh
ocrd-kraken-binarize --help
```

### ocrd_tesserocr

ocrd_tesserocr requires tesseract to be installed in addition to the module project:

```sh
sudo apt-get install libtesseract-dev tesseract-ocr
pip install ocrd_tesseroccr
```

Verify:

```sh
ocrd-tesserocr-recognize --help
```
