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
<summary> 8 GB RAM (more recommended)</summary>
  
  - The more RAM is available, the more concurrent processes can be run<br>
  - Exceedingly large images (newspapers, folio-size books...) require a lot of RAM
  
</details>
<details>
<summary> 20 GB free disk space for local installation (more recommended)</summary>
  
  - How much disk space is needed depends mainly on the individual purposes of the installation. In addition to the installation itself 
  you will need space for various <a href="https://ocr-d.de/en/models">pretrained models</a>, training and evaluation data for training, and data to process.
  
</details>
<details>
<summary> Python 3.6 or 3.7</summary>
  
  - OCR-D's target Python version is currently Python 3.6 which we will continue to support until at least Q3 2022<br>
  - Python 3.7 is also tested and supported<br>
  - Python 3.8 and newer versions are not yet fully supported, since there are no pre-built Python packages for Tensorflow 2.5 and <2 and other related software. We expect to unconditionally support Python 3.8 once all processors and models are upgraded to work with a more recent Tensorflow.
  
</details>
<details>
<summary> Operating system: Ubuntu 18.04 (or Docker)</summary>
  - For installation on Windows 10 (WSL) and macOS see the setup guides in the [OCR-D-Wiki](https://github.com/OCR-D/ocrd-website/wiki).
  - Ubuntu 18.04 is our target platform because it was the most up-to-date Ubuntu LTS release when we started developing and <a href="https://ubuntu.com/about/release-cycle">will be supported for the foreseeable future</a><br>
  - Ubuntu 22.04 is now (2022) the current Ubuntu LTS, seems to work, too, and will be our next target platform.<br />
  - Other Linux distributions or Ubuntu versions can also be used, though some instructions have to be adapted (e.g. package management, locations of some files)<br>
  - With Windows Subsystem for Linux (WSL), a feature of Windows 10, it is <a href="https://github.com/OCR-D/ocrd-website/wiki/OCR-D-on-Windows">also possible to set up an Ubuntu 18.04 installation within Microsoft Windows</a>
  - OCR-D can be deployed on an <a href="https://github.com/OCR-D/ocrd-website/wiki/OCR-D-on-macOS">Apple MacOSX machine using Homebrew</a>
  
</details>

## Installation

### ocrd_all

`ocrd_all` is the main way to distribute and install the OCR-D software. 
If you want to produce OCR output from image data, 
this is what you need.
  
  <details>
    <summary>Tell me more about ocrd_all</summary>
    
The [`ocrd_all`](https://github.com/OCR-D/ocrd_all) project is an effort by the
OCR-D community, now maintained by the OCR-D coordination team. It streamlines
the native installation of OCR-D modules with a versatile Makefile approach.
Besides allowing native installation of the full OCR-D stack (or any subset),
it is also the base for the [`ocrd/all`](https://hub.docker.com/r/ocrd/all)
Docker images available from DockerHub that contain the full stack (or certain subsets)
of OCR-D modules ready for deployment.

Technically, [`ocrd_all`](https://github.com/OCR-D/ocrd_all) is a Git repository 
that keeps all the necessary software as Git submodules at specific revisions. 
This way, the software tools are known to be at a stable version and guaranteed to 
be interoperable with one another.
    
  </details>

### Installation: Docker or Native  
  
There are two methods to install OCR-D:

 1. **[Docker Installation of OCR-D](#ocrd_all-via-docker)** using the prebuilt `ocrd/all` [Docker images](https://hub.docker.com/r/ocrd/all) to install a module collection (**recommended**)    
 2. **[Native Installation of OCR-D](#ocrd_all-natively)** using the `ocrd_all` [git repository](https://github.com/OCR-D/ocrd_all) to install selected modules natively  

We recommend using the prebuilt Docker images, since this does not require any changes to
the host system besides [installing Docker](https://hub.docker.com/r/ocrd/all).

  <details>
    <summary>Installation of individual OCR-D modules</summary>
Sometimes it can be useful to [install the modules individually](#individual-installation-experts-only), either via Docker or natively.
Beware that we do not recommend installing modules individually, as it can be difficult to catch all dependencies, 
keep the software versions up-to-date and ensure that all components are at a usable and interoperable state.

  </details>
    
## ocrd_all via Docker

### Prerequisites

If you want to use the OCR-D-Docker-solution, [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) and [docker compose](https://docs.docker.com/compose/install/) have to be installed.

After installing docker you have to set up daemon and add user to  the group 'docker'

```sh
# Start docker daemon at startup
sudo systemctl enable docker
# Add user to group 'docker'
sudo usermod -aG docker $USER
```

<img src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png" alt="warning" style="zoom:33%;" /> Please log out and log in again.

To test access to docker try the following command:

```sh
docker images
```

Now you should see an (empty) list of available images.

### mini medi maxi

There are three versions of the
[`ocrd/all`](https://hub.docker.com/r/ocrd/all) Docker image:
`minimum`, `medium` and `maximum`. They differ in which modules are included
and hence the size of the image:  
* `minimum` is comprised of the essential OCR-D components, with Tesseract and OCRopus as OCR engines.  
* `medium` adds the Calamari OCR engine, as well as extra segmentation, pre- and postprocessing options.   
* `maximum` includes all modules for best performance and full flexibility, but requires the most disk space. 

We encourage the use of the relatively large but complete `maximum` image. 
The `minimum` or `medium` images should only be used when certain that none but the included OCR-D 
modules are needed. 

<details markdown=1>
  <summary>Click here for a table showing the modules included in each version</summary>

| Module                      | `minimum` | `medium` | `maximum` |
| -----                       | ----      | ----     | ----      |
| core                        | ☑         | ☑        | ☑         |
| ocrd_cis                    | ☑         | ☑        | ☑         |
| ocrd_fileformat             | ☑         | ☑        | ☑         |
| ocrd_im6convert             | ☑         | ☑        | ☑         |
| ocrd_pagetopdf              | ☑         | ☑        | ☑         |
| ocrd_repair_inconsistencies | ☑         | ☑        | ☑         |
| ocrd_tesserocr              | ☑         | ☑        | ☑         |
| ocrd_wrap                   | ☑         | ☑        | ☑         |
| tesserocr                   | ☑         | ☑        | ☑         |
| workflow-configuration      | ☑         | ☑        | ☑         |
| cor-asv-ann                 | -         | ☑        | ☑         |
| dinglehopper                | -         | ☑        | ☑         |
| docstruct                   | -         | ☑        | ☑         |
| format-converters           | -         | ☑        | ☑         |
| ocrd_calamari               | -         | ☑        | ☑         |
| ocrd_keraslm                | -         | ☑        | ☑         |
| ocrd_olahd_client           | ☑         | ☑        | ☑         |
| ocrd_olena                  | -         | ☑        | ☑         |
| ocrd_segment                | -         | ☑        | ☑         |
| tesseract                   | -         | ☑        | ☑         |
| ocrd_neat                   | -         | ☑        | ☑         |
| ocrd_anybaseocr             | -         | -        | ☑         |
| ocrd_detectron2             | -         | -        | ☑         |
| ocrd_doxa                   | -         | -        | ☑         |
| ocrd_kraken                 | -         | -        | ☑         |
| ocrd_ocropy                 | -         | -        | -         |
| ocrd_pc_segmentation        | -         | -        | -         |
| ocrd_typegroups_classifier  | -         | -        | ☑         |
| sbb_binarization            | -         | -        | ☑         |
| cor-asv-fst                 | -         | -        | -         |

</details>
  
### Fetch Docker image

To fetch the `maximum` version of the `ocrd/all` Docker image:<br> 
(replace `maximum` accordingly if you want the `minimum` or `medium` version)

```sh
docker pull ocrd/all:maximum
```

  <details>
    <summary>Docker and git images</summary>
If you want to keep the modules' git repos inside the Docker images – so you can keep making 
fast updates, without waiting for a new pre-built image, but also without building an image yourself – 
then add the suffix `-git` to the image version, e.g. `maximum-git`. This will behave like the native installation, 
only inside the container. Yes, you can also [commit changes](https://rollout.io/blog/using-docker-commit-to-create-and-change-an-image/) 
made in containers back to your local Docker image.)
  </details>

### Testing the Docker installation

To start, download and extract a document from the [OCR-D GT Repo](https://ola-hd.ocr-d.de/search?q=&fulltextsearch=false&metadatasearch=false&isGT=true&perPageRecords=30):

```sh
wget "https://ola-hd.ocr-d.de/api/export?id=21.T11998/0000-001C-F82E-8&internalId=false" -O wundt_grundriss_1896.ocrd.zip
unzip wundt_grundriss_1896.ocrd.zip
cd data
```

Now, spin up the docker container:

```sh
docker run --user $(id -u) --workdir /data --volume $PWD:/data --rm -it ocrd/all bash
```

Your command line should start with something similar to:

```sh
I have no name!@ade9a4692fcd:/data$
```

After spinning up the container, you can use the installation and call the processors the same way as in the native installation.

Alternatively, you would have to [translate each command to a docker call](/en/user_guide#translating-native-commands-to-docker-calls) (not recommended).

Let's segment the images in file group `OCR-D-IMG` from the zip file into regions, thereby creating a 
[PAGE-XML](https://github.com/PRImA-Research-Lab/PAGE-XML) file group `OCR-D-SEG-BLOCK-DOCKER`):

```sh
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK-DOCKER
```

When you are finished using OCR-D commands, use this command to stop using docker interactively:

```sh
exit
``` 

### Updating Docker image

To update the Docker image to the latest version, just run the `docker pull` command:<br> 
(replace `maximum` accordingly if you use the `minimum` or `medium` version)

```sh
docker pull ocrd/all:maximum
```

### Further reading

We recommend jumping to the [section about installing models at the bottom of this page](#installing-models) next.
Alternatively, for instructions on how to proceed further with the processing of your data, please see the [user guide](/en/user_guide). Make sure to also read [the notes on translating native command line calls to docker calls](/en/user_guide#translating-native-commands-to-docker-calls).
  
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
wget "https://ola-hd.ocr-d.de/api/export?id=21.T11998/0000-001C-F82E-8&internalId=false" -O wundt_grundriss_1896.ocrd.zip
sudo unzip wundt_grundriss_1896.ocrd.zip
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

### Further reading

We recommend jumping to the [section about installing models at the bottom of this page](#installing-models) next.
For instructions on how to process your own data, please see the [user guide](/en/user_guide).

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

## Installing models

Several processors in OCR-D need pretrained models you have to install beforehand. 
Please consult our [instruction on models](/en/models) to get more information on how to download and install them. 