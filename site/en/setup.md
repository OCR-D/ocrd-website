---
layout: page
author: Konstantin Baierer
lang: en
lang-ref: setup
toc: true
---

# Setup guide for pilot libraries

OCR-D's software is a modular collection of many projects (called _modules_)
with many tools per module (called _processors_) that you can combine freely
to achieve the workflow best suited for OCRing your content.

All [OCR-D modules](https://github.com/topics/ocr-d) follow the same
[interface](https://ocr-d.github.io/cli) and common design patterns. So once
you understand how to install and use one project, you know how to install and
use all of them.

## Installation

There are three ways to install OCR-D modules:

  1. Using the [`ocrd/all` Docker module collection](https://hub.docker.com/r/ocrd/all) (**recommended**)
  2. Using `ocrd/all` to install OCR-D modules locally
  3. Installing modules indivudally via Docker or natively (not recommended)

We recommend using the Docker image since this does not require any changes to
the host system besides [installing Docker](https://hub.docker.com/r/ocrd/all).

We do not recommend installing modules individually because it can be difficult to keep the
software up-to-date and ensure that they are at working and interoperable versions.

## ocrd_all

The [`ocrd_all`](https://github.com/OCR-D/ocrd_all) project is an effort by the
OCR-D community, now maintained by the OCR-D coordination team. It streamlines
the native installation of OCR-D modules with a versatile Makefile approach.
Besides allowing local installation of the full OCR-D stack, it is also the
base for the [`ocrd/all`](https://hub.docker.com/r/ocrd/all)
Docker images available from DockerHub that contain the full stack of OCR-D
modules ready for deployment.

Technically, `ocrd_all` is a Git repository that keeps all the necessary software
as Git submodules at specific revisions. This way, the software tools are known
to be at a stable version and guaranteed to be interoperable with one another.

## ocrd_all via Docker

### mini medi maxi

There are three versions of the
[`ocrd/all`](https://hub.docker.com/r/ocrd/all) image:
`minimum`, `medium` and `maximum`. They differ in which modules are included
and hence the size of the image. Only use the `minimum` or `medium` images if
you are certain that you do not need the full OCR-D stack for your workflows, otherwise
we encourage you to use the large but complete `maximum` image.

Check this table to see which modules are included in which version:

| Module                      | `minimum` | `medium` | `maximum` |
| -----                       | ----      | ----     | ----      |
| core                        | ☑         | ☑        | ☑         |
| ocrd_cis                    | ☑         | ☑        | ☑         |
| ocrd_im6convert             | ☑         | ☑        | ☑         |
| ocrd_repair_inconsistencies | ☑         | ☑        | ☑         |
| ocrd_tesserocr              | ☑         | ☑        | ☑         |
| tesserocr                   | ☑         | ☑        | ☑         |
| workflow-configuration      | ☑         | ☑        | ☑         |
| cor-asv-ann                 | -         | ☑        | ☑         |
| dinglehopper                | -         | ☑        | ☑         |
| format-converters           | -         | ☑        | ☑         |
| ocrd_calamari               | -         | ☑        | ☑         |
| ocrd_keraslm                | -         | ☑        | ☑         |
| ocrd_olena                  | -         | ☑        | ☑         |
| ocrd_segment                | -         | ☑        | ☑         |
| tesseract                   | -         | ☑        | ☑         |
| ocrd_anybaseocr             | -         | -        | ☑         |
| ocrd_kraken                 | -         | -        | ☑         |
| ocrd_ocropy                 | -         | -        | ☑         |
| ocrd_pc_segmentation        | -         | -        | ☑         |
| ocrd_typegroups_classifier  | -         | -        | ☑         |
| sbb_textline_detector       | -         | -        | ☑         |
| cor-asv-fst                 | -         | -        | ☑         |

### Fetch docker image

To fetch the `maximum` version of the `ocrd/all` Docker image:

```sh
docker pull ocrd/all:maximum
```

Replace `maximum` accordingly if you want the `minimum` or `medium` variant.

If no specific version is chosen, `latest` is selected by default, which is equivalent to `medium`.

### Updating docker image

To update the docker images to their latest version, just run the `docker pull` command again:

```sh
docker pull ocrd/all:<version>
```

This can even be set up as a cron-job to ensure the image is always up-to-date.

### Translating native commands to docker calls

In the documentation, both of the [OCR-D coordination
project](https://ocr-d.github.io) as well as the documentation of the
[individual OCR-D modules](https://github.com/topics/ocr-d), you will find
*native commands*, i.e. command line calls that expect the software to be
installed natively. These are simple to translate to commands based on the
docker images by prepending the boilerplate telling Docker which image to use,
which user to run as, which files to bind to a container path etc.

For example a call to
[`ocrd-tesserocr-binarize`](https://github.com/OCR-D/tesserocr) might natively
look like this:

```sh
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
```

To run it with the [`ocrd/all:maximum`] Docker container:

```sh
docker run -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
           \_________/ \___________/ \______/ \_________________/ \___________________________________________________________/
              (1)          (2)         (3)          (4)                            (5)
```

* (1) tells Docker to run the container as the calling user instead of root
* (2) tells Docker to bind the current working directory as the `/data` folder in the container
* (3) tells Docker to change the container's working directory to `/data`
* (4) tells docker which image to run
* (5) is the unchanged call to `ocrd-tesserocr-segment-region`

It can also be useful to delete the container after creation with the `--rm`
parameter.

## ocrd_all natively

The `ocrd_all` project contains a sophisticated Makefile to install or compile
prerequisites as necessary, set up a virtualenv, install the core software,
install OCR-D modules and more. Detailed documentation [can be found in its
README](https://github.com/OCR-D/ocrd_all).

### Prerequisites

There are some [system requirements](https://github.com/OCR-D/ocrd_all#system-packages) for ocrd_all.

You need to have `git` and `make` installed to make use of `ocrd_all`:

```sh
sudo apt install git make
```

It is easiest to install all the possible system requirements by calling `make deps-ubuntu` as root:

```sh
sudo make deps-ubuntu
```

### Cloning the repository

Clone the repository and all its submodules:

```sh
git clone --recursive https://github.com/OCR-D/ocrd_all
cd ocrd_all
```

### Updating the repository

As `ocrd_all` is in [active
development](https://github.com/OCR-D/ocrd_all/commits/master), it is wise to
regularly update the repository and its submodules:

```sh
git pull
make modules
```

### Installing with ocrd_all

You can either install
  1. all the software at once with the `all` target (equivalent to the [`maximum` Docker version](#mini-medi-maxi))
  2. modules individually by using an executable from that module as the target or :
  3. modules invidually by using the project name for the `OCRD_MODULES` variable:

```sh
make all                       # Installs all the software (recommended)

make ocrd-tesserocr-binarize   # Install ocrd_tesserocr which contains ocrd-tesserocr-binarize
make ocrd-cis-ocropy-binarize  # Install ocrd_cis  which contains ocrd-cis-ocropy-binarize

make all OCRD_MODULES="ocrd_tesserocr ocrd_cis"  # Will install both ocrd_tesserocr and ocrd_cis
```

## Individual installation

With all variants of individual module installation, it will be up to you to
keep the repositories up-to-date and installed. We therefore discourage
individual installation of modules and recommend using ocrd_all as outlined above..

### Individual Docker container

This is the best option if you want full control over which modules you
actually intend to use while still profiting from the simple installation of
Docker containers.

You need to have [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

All OCR-D modules are also [published as Docker containers to DockerHub](https://hub.docker.com/u/ocrd). To find the docker
image for a module, replace the `ocrd_` prefix with `ocrd/`:

```sh
docker pull ocrd/tesserocr  # Installs ocrd_tesserocr
docker pull ocrd/olena  # Installs ocrd_olena
```

To run the containers, please see [the notes on translating native command line
calls to docker calls above](#translating-native-commands-to-docker-calls). Make sure the image
name matches the executable. For example to run the same example in the dedicated `ocrd_tesserocr` container:

```sh
docker run -u $(id -u) -w /data -v $PWD:/data -- ocrd/tesserocr ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK-DOCKER
```

### Native installation

> **NOTE**
> 
> ocrd_tesserocr requires **tesseract-ocr >= 4.1.0**. But the Tesseract packages
> bundled with **Ubuntu < 19.10** are too old. If you are on Ubuntu 18.04 LTS,
> please enable [Alexander Pozdnyakov PPA](https://launchpad.net/~alex-p/+archive/ubuntu/tesseract-ocr),
> which has up-to-date builds of tesseract and its dependecies:
> 
> ```sh
> sudo add-apt-repository ppa:alex-p/tesseract-ocr
> sudo apt-get update
> ```

#### virtualenv

* **Always install python modules into a virtualenv**
* **Never run `pip`/`pip3` as root**

First install Python 3 and `venv`:

```sh
sudo apt install python3 python3-venv
```

```sh
# If you haven't created the venv yet:
python3 -m venv ~/venv
# Activate the venv
source ~/venv/bin/activate
```

Once you have activated the virtualenv, you should see `(venv)` prepended to
your shell prompt.

#### From PyPI

This is the best option if you want to use the stable, released version of individual modules.

However, many modules require a number of non-Python (system) packages. For the
exact list of packages you need to look at the README of the module in
question. (If you are not on Ubuntu >= 18.04, then your requirements may
deviate from that.)

For example to install `ocrd_tesserocr` from PyPI:

```sh
sudo apt-get install git python3 python3-pip python3-venv libtesseract-dev libleptonica-dev tesseract-ocr-eng tesseract-ocr wget
pip3 install ocrd_tesserocr
```

Many ocrd modules conventionally contain a Makefile with a `deps-ubuntu` target that can handle calls to `apt-get` for you:

```sh
sudo make deps-ubuntu
```

#### From git 

This is the best option if you want to change the source code or install the latest, unpublished changes.

```sh
git clone https://github.com/OCR-D/ocrd_tesserocr
cd ocrd_tesserocr
sudo make deps-ubuntu # or manually with apt-get
make deps             # or pip3 install -r requirements
make install          # or pip3 install .
```

If you intend to develop a module, it is best to install the module editable:

```sh
pip install -e .
```

This way, you won't have to reinstall after making changes.

## Testing the installation

For example, let's fetch a document from the [OCR-D GT Repo](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/):

```sh
wget 'https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/736a2f9a-92c6-4fe3-a457-edfa3eab1fe3/data/wundt_grundriss_1896.ocrd.zip'
unzip wundt_grundriss_1896.ocrd.zip
cd data
```

### Test native installation

This section applies if you installed the software natively, either [via
`ocrd_all`](#ocrd_all-natively) or [on a per-module basis](#native-installation).

First, activate your venv:

```sh
# Activate the venv
source ~/venv/bin/activate
```

Let's segment the images in file group `OCR-D-IMG` into regions (creating a
first [PAGE-XML](https://github.com/PRImA-Research-Lab/PAGE-XML) file group
`OCR-D-SEG-BLOCK`):

```sh
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
```

### Test Docker installation

This section applies if you installed the software as docker container(s), either [via
`ocrd_all`](#ocrd_all-via-docker) or [on a per-module basis](#individual-docker-container).

You can spin up a docker container, mounting the current working directory like this:

```sh
docker run -u $(id -u) -w /data -v $PWD:/data -- ocrd/all:maximum ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK-DOCKER
```

Note that the CLI is exactly the same, the only difference is the prefix to instruct Docker, as [explained above](#mini-medi-maxi)

## Running a small workflow

### With PyPI and workflow engine from core

The [core package](https://github.com/OCR-D/core) will be installed with every
OCR-D module package, but you can also install it manually:

```sh
pip3 install ocrd
```

Its CLI `ocrd` contains a simple workflow engine, available with the `ocrd process` command, which allows you to chain multiple OCR-D processor calls into simple sequential workflows.

For example, let's combine the ocropy-based binarization of the
[ocrd_cis](https://github.com/cisocrgroup/ocrd_cis) module project with the segmentation and recognition
in [ocrd_tesserocr](https://github.com/OCR-D/ocrd_tesserocr).

First, install ocrd_cis, too:

```sh
# Install ocrd_cis
pip3 install ocrd_cis # with pip
```

Next, install a suitable OCR model for Tesseract:

```sh
# Install OCR model into Tesseract datapath
sudo apt-get install tesseract-ocr-script-frak
```

Now we can define the workflow (as a list of processor calls in abbreviated
form, and a number of parameter files where defaults are insufficient):

```sh
# Create parameter files
echo '{ "model": "Fraktur" }' > param-tess-fraktur.json

# Run workflow
ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json' 
```
