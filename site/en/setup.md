---
layout: page
lang: en
lang-ref: https://translate.google.com/translate?hl=&sl=en&tl=de&u=https%3A%2F%2Focr-d.de%2Fen%2Fsetup
toc: true
title: OCR-D setup guide
---

# OCR-D setup guide

OCR-D's software is a modular collection of many projects (called _modules_)
with many tools per module (called _processors_) that you can combine freely
to achieve the workflow best suited for OCRing your content.

## System requirements

Minimum system requirements
<details>
<summary>- 8 GB RAM (more recommended)</summary>
  
  - The more RAM is available, the more concurrent processes can be run
  - Exceedingly large images (newspapers, folio-size books...) require a lot of RAM
  
</details>
<details>
<summary>- min. 20 GB free disk space for local installation (more recommended)</summary>
  
  - How much disk space is needed depends mainly on the individual purposes of the installation. In addition to the installation itself 
  you will need space for various [pretrained models](https://ocr-d.de/en/models), training and evaluation data for training, and data to process.
  
</details>
<details>
<summary>- Operating system: Ubuntu 18.04</summary>
  
  - Ubuntu 18.04 is our target platform because it was the most up-to-date Ubuntu LTS release when we started developing and [will be supported for the foreseeable future](https://ubuntu.com/about/release-cycle)
  - Ubuntu 22.04 is now (2022) the current Ubuntu LTS, seems to work, too, and might be our next target platform.
  - Other Linux distributions or Ubuntu versions can also be used, though some instructions have to be adapted (e.g. package management, locations of some files)
  - With Windows Subsystem for Linux (WSL), a feature of Windows 10, it is [also possible to set up an Ubuntu 18.04 installation within Microsoft Windows](https://github.com/OCR-D/ocrd-website/wiki/OCR-D-on-Windows)
  - OCR-D can be deployed on an [Apple MacOSX machine using Homebrew](https://github.com/OCR-D/ocrd-website/wiki/OCR-D-on-macOS)
  
</details>
<details>
<summary>- Python 3.6 or 3.7</summary>
  
  - OCR-D's target Python version is currently Python 3.6 which we will continue to support until at least Q3 2022
  - Python 3.7 is also tested and supported
  - We currently **cannot fully support Python 3.8**, because there currently (May 2022) are no pre-built Python packages for Tensorflow 2.5 and other GPU related software). We expect to unconditionally support Python 3.8 and newer versions somewhere in the future when all processors work with a recent Tensorflow 2.x.
  
</details>
For installation on Windows 10 (WSL) and macOS see the setup guides in the [OCR-D-Wiki](https://github.com/OCR-D/ocrd-website/wiki)

Alternatively, you can use [Docker](https://hub.docker.com/u/ocrd). This way, you will only have to meet the minimum requirements for 
free disk space. But you can use any operating system you want and do not have to worry about the Python version. 

## Installation

There are two ways to install OCR-D modules:

  1. [Using](#ocrd_all-via-docker) the [ocrd_all prebuilt Docker images `ocrd/all`](https://hub.docker.com/r/ocrd/all) to install a module collection (**recommended**)
  2. [Using](#ocrd_all-natively) the [ocrd_all git repository](https://github.com/OCR-D/ocrd_all) to install selected modules natively

We recommend using the prebuilt Docker images since this does not require any changes to
the host system besides [installing Docker](https://hub.docker.com/r/ocrd/all).

For developers it might be useful to [install the modules individually](#individual-installation), either via Docker or natively.
Beware that for all other users and purposes we do not recommend installing modules individually, because it can be difficult to catch all dependencies, 
keep the software up-to-date and ensure that they are at usable and interoperable versions.

## ocrd_all

The [`ocrd_all`](https://github.com/OCR-D/ocrd_all) project is an effort by the
OCR-D community, now maintained by the OCR-D coordination team. It streamlines
the native installation of OCR-D modules with a versatile Makefile approach.
Besides allowing native installation of the full OCR-D stack (or any subset),
it is also the base for the [`ocrd/all`](https://hub.docker.com/r/ocrd/all)
Docker images available from DockerHub that contain the full stack (or certain subsets)
of OCR-D modules ready for deployment.

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
| ocrd_fileformat             | ☑         | ☑        | ☑         |
| ocrd_im6convert             | ☑         | ☑        | ☑         |
| ocrd_pagetopdf              | ☑         | ☑        | ☑         |
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

### Fetch Docker image

To fetch the `maximum` version of the `ocrd/all` Docker image:

```sh
docker pull ocrd/all:maximum
```

Replace `maximum` accordingly if you want the `minimum` or `medium` variant.

(Also, if you want to keep the modules' git repos inside the Docker images – so you can keep making 
fast updates, without waiting for a new pre-built image but also without building an image yourself –, 
then add the suffix `-git` to the variant, e.g. `maximum-git`. This will behave like the native installation, 
only inside the container. Yes, you can also [commit changes](https://rollout.io/blog/using-docker-commit-to-create-and-change-an-image/) 
made in containers back to your local Docker image.)

### Testing the Docker installation

For example, let's fetch a document from the [OCR-D GT Repo](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/):

```sh
wget 'https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/736a2f9a-92c6-4fe3-a457-edfa3eab1fe3/data/wundt_grundriss_1896.ocrd.zip'
unzip wundt_grundriss_1896.ocrd.zip
cd data
```

Let's segment the images in file group `OCR-D-IMG` from the zip file into regions (creating a
first [PAGE-XML](https://github.com/PRImA-Research-Lab/PAGE-XML) file group
`OCR-D-SEG-BLOCK-DOCKER`)

You can spin up a docker container, mounting the current working directory like this:

```sh
docker run --user $(id -u) --workdir /data --volume $PWD:/data -- ocrd/all:maximum ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK-DOCKER
```

For instructions on how to process your own data, please see the [user guide](/en/user_guide). Make sure to also read [the notes on translating native command line
calls to docker calls above](/en/user_guide#translating-native-commands-to-docker-calls). Make sure the image
name matches the executable. 


### Updating Docker image

To update the docker images to their latest version, just run the `docker pull` command again:

```sh
docker pull ocrd/all:<version>
```

This can even be set up as a cron-job to ensure the image is always up-to-date.

## ocrd_all natively

The `ocrd_all` project contains a sophisticated Makefile to install or compile
prerequisites as necessary, set up a virtualenv, install the core software,
install OCR-D modules and more. Detailed documentation [can be found in its
README](https://github.com/OCR-D/ocrd_all).

### Installation

There are some [system requirements](https://github.com/OCR-D/ocrd_all#system-packages) for ocrd_all.

You need to have `make` installed to make use of `ocrd_all`:

```sh
sudo apt install make
```

Clone the repository (still without submodules) and change into the `ocrd_all` directory:

```sh
git clone https://github.com/OCR-D/ocrd_all
cd ocrd_all
```
You should now be in a directory called `ocrd_all`.


It is easiest to install all the possible system requirements by calling `make deps-ubuntu` as root:

```sh
sudo make deps-ubuntu
```

This will install all system requirements.


Now you are ready for the final step which will actually install the OCR-D-Software.

You can either install
  1. all the software at once with the `all` target (equivalent to the [`maximum` Docker version](#mini-medi-maxi)),
  2. modules individually by using an executable from that module as the target, or
  3. a subset of modules by listing the project names in the `OCRD_MODULES` variable (equivalent to a custom selection of the [`medium` Docker version](#mini-medi-maxi)):

```sh
make all                       # Installs all the software (recommended)

make ocrd-tesserocr-binarize   # Install ocrd_tesserocr which contains ocrd-tesserocr-binarize
make ocrd-cis-ocropy-binarize  # Install ocrd_cis  which contains ocrd-cis-ocropy-binarize

make all OCRD_MODULES="core ocrd_tesserocr ocrd_cis" # Will install only ocrd_tesserocr and ocrd_cis
```

(Custom choices for `OCRD_MODULES` and other control variables (cf. `make help`) can also be made permanent by writing them into `local.mk`.)

**Note:** Never run `make all` as root unless you know *exactly* what you are doing!

Installation is incremental, i.e. failed/interrupted attempts can be continued, and modules can be installed one at a time as needed.

Running `make` will also take care of cloning and updating all required submodules.

Especially running `make all` will take a while (between 30 and 60 minutes or more on slower machines). In the end, it should say that the last processor was installed successfully.

Having installed `ocrd_all` successfully, `ocrd --version` should give you the current version of [OCR-D/core](https://github.com/OCR-D/core).
Activate the virtual Python environment, which was created in the directory `venv`, before running any OCR-D command.

```sh
source venv/bin/activate
ocrd --version
ocrd, version 2.13.2 # your version should be 2.13.2 or later
``` 

### Testing the native installation

For example, let's fetch a document from the [OCR-D GT Repo](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/):

```sh
wget 'https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/736a2f9a-92c6-4fe3-a457-edfa3eab1fe3/data/wundt_grundriss_1896.ocrd.zip'
unzip wundt_grundriss_1896.ocrd.zip
cd data
```

If you haven't done it already, activate your venv:

```sh
# Activate the venv
source /path/to/ocrd_all/venv/bin/activate
```

Let's segment the images in file group `OCR-D-IMG` from the zip file into regions (creating a
first [PAGE-XML](https://github.com/PRImA-Research-Lab/PAGE-XML) file group
`OCR-D-SEG-BLOCK`):

```sh
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
```

For instructions on how to process your own data, please see the [user guide](/en/user_guide).

### Updating the software

As `ocrd_all` is in [active
development](https://github.com/OCR-D/ocrd_all/commits/master), it is wise to
regularly update the repository and its submodules:

```sh
git pull 
```

This will refresh the local clone of ocrd_all with the changes in the official ocrd_all GitHub repository.

Now you can install the changes with

```sh
make all 
```

This will run the installation process for all submodules which have been changed. In the end, it should
say that the last processor was installed successfully. `--version` for the processors which have been changed
should give you its current version. 


## Individual installation (experts only)

For developing purposes it might be useful to install modules individually, either with Docker or natively. 
With all variants of individual module installation, it will be up to you to
keep the repositories up-to-date and installed. We therefore discourage
individual installation of modules and recommend using ocrd_all as outlined above..

All [OCR-D modules](https://github.com/topics/ocr-d) follow the same
[interface](https://ocr-d.github.io/cli) and common design patterns. So once
you understand how to install and use one project, you know how to install and
use all of them.

### Individual Docker container

This is the best option if you want full control over which modules you
actually intend to use while still profiting from the simple installation of
Docker containers.

You need to have [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Many OCR-D modules are also [published as Docker containers to DockerHub](https://hub.docker.com/u/ocrd). To find the Docker
image for a module, replace the `ocrd_` prefix with `ocrd/`:

```sh
docker pull ocrd/tesserocr  # Installs ocrd_tesserocr
docker pull ocrd/olena  # Installs ocrd_olena
```

Now you can [test your installation](#testing-the-docker-installation).


### Native installation

Installing each module into your system natively requires you to know and install all its _dependencies_ first.
That can be _system packages_ (or even system package repositories) or _Python packages_. 

To learn about system dependencies, consult the module's README files. In contrast, Python dependencies should
be resolved automatically by using the Python package manager `pip`.

> **NOTE**
> 
> ocrd_tesserocr requires **tesseract-ocr >= 4.1.0**. But the Tesseract packages
> bundled with **Ubuntu < 19.10** are too old. If you are on Ubuntu 18.04 LTS,
> please enable [Alexander Pozdnyakov PPA](https://launchpad.net/~alex-p/+archive/ubuntu/tesseract-ocr),
> which has up-to-date builds of tesseract and its dependencies:
> 
> ```sh
> sudo add-apt-repository ppa:alex-p/tesseract-ocr
> sudo apt-get update
> ```

Next subsections:
- For Python you also first need [virtualenv](#virtualenv). Then you have two options: 
- installing [via PyPI](#from-pypi) or 
- installing [via local git clone](#from-git).

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

Now you can [test your installation](#testing-the-native-installation).


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

Now you can [test your installation](#testing-the-native-installation).
