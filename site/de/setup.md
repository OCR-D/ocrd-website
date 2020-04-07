---
layout: page
lang: de
lang-ref: setup
toc: true
---

# OCR-D-Installationsanleitung

Die OCR-D-Software ist eine modulare Sammlung mehrerer Projekte (genannt _Module_)
mit vielen Werkzeugen pro Modul (genannt _Prozessoren_), die frei kombiniert werden können,
um den für die OCR-Bearbeitung Ihrer Inhalte am besten geeigneten Workflow zu erreichen.

Alle [OCR-D-Module] (https://github.com/topics/ocr-d) folgen der gleichen.
[Schnittstelle](https://ocr-d.github.io/cli) und einem einheitlichen Prinzip. Sobald man
verstanden hat, wie ein Projekt installiert und benutzt wird, kann man auch alle anderen installieren und
verwenden.

## Installation

Es gibt vier Möglichkeiten, die OCR-D-Module zu installieren:

  1. Verwendung der [`ocrd/all` Docker-Modul-Sammlung](https://hub.docker.com/r/ocrd/all) (**empfohlen**)
  2. Die Verwendung von `ocrd/all` zur lokalen Installation von OCR-D-Modulen
  3. Module einzeln über Docker oder nativ installieren (nicht empfohlen)
  4. Verwendung des [OCR-D Framework mit Docker](https://github.com/VolkerHartmann/ocrd_framework) zur Installation aller verfügbaren Prozessoren, des Taverna-Workflows und des lokalen Forschungsdatenrepositoriums

Wir empfehlen die Verwendung des Docker-Images, da dies abgesehen von 
der [Installation von Docker](https://hub.docker.com/r/ocrd/all) 
keine Änderungen an dem Host-System erfordert.

Module einzeln zu installieren, ist nicht empfehlenswert. Hier wird es schwierig, die
Software auf dem neuesten Stand zu halten und sicherzustellen, dass die Module in funktionsfähigen und interoperablen Versionen vorliegen.

## ocrd_all

Das [`ocrd_all`](https://github.com/OCR-D/ocrd_all) Projekt ist aus der
OCR-D-Community heraus entstanden und wird jetzt vom OCR-D-Koordinationsteam betreut. Diese Lösung rationalisiert
die native Installation von OCR-D-Modulen mit einem vielseitigen Makefile-Ansatz.
Neben der lokalen Installation des vollständigen OCR-D-Module ist es auch Basis für die
[`ocrd/all`](https://hub.docker.com/r/ocrd/all) auf DockerHub verfügbaren Docker-Images,
die alle sofort einsetzbaren OCR-D-Module enthalten.

Technisch gesehen ist `ocrd_all` ein Git-Repository, das die gesamte benötigte Software
als Git-Submodule in bestimmten Revisionen enthält. Auf diese Weise kann sichergestellt werden, 
dass die Software-Werkzeuge in einer stabilen Version vorliegen und interoperabel sind.

## ocrd_all über Docker

### mini medi maxi

Es gibt drei Versionen des [`ocrd/all`](https://hub.docker.com/r/ocrd/all) Image:
`minimum`, `medium` und `maximum`. Sie unterscheiden sich in der Anzahl der enthaltenen Module
und damit in der Größe des Bildes. Die `minimum-` oder `medium`-Images können verwendet werden, wenn
für Ihre Workflows mit Sicherheit nicht alle OCR-D-Module benötigt werden. Andernfalls
empfehlen wir, das große, vollständige "maximum"-Image zu verwenden.

Die folgende Tabelle zeigt, welche Module in welcher Image-Version enthalten sind:


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

### Updating docker image

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
git submodule sync
git submodule update --init --recursive
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

## Installation of OCR-D Research Data Repository

It's highly recommended to install the research data repository via Docker. [See link for further information](https://github.com/OCR-D/repository_metastore/blob/master/installDocker/installation.md)

```sh
git clone https://github.com/OCR-D/repository_metastore
cd repository_metastore/installDocker
bash installRepo.sh ~/ocrd/repository
cd ~/ocrd/repository/docker
docker-compose up &
# To stop research data repository
docker-compose stop
```

### Testing the installation

The write access to the service is secured with a password, which is preset
when you use the docker installation. There is an 'ingest' user for ingesting
files. (Password: `ingest`)

1. Upload zipped BagIt container to metastore.
```sh
curl -u ingest:ingest -v -F "file=@zippedBagItContainer" http://localhost:8080/api/v1/metastore/bagit 
```
2. List all BagIt containers.
```sh
curl -XGET -H "Accept:application/json"  http://localhost:8080/api/v1/metastore/bagit 
```
3. List all METS files.
```sh
curl -XGET http://localhost:8080/api/v1/metastore/mets
```
4. List all METS files with title 'Der Herold'.
```sh
curl -XGET -H "Accept:application/json" "http://localhost:8080/api/v1/metastore/mets/title?title=Der%20Herold"
```
5. Download zipped BagIt container from metastore. (use one URL of the list printed above) 
```sh
curl -XGET http://localhost:8090/api/v1/dataresources/123..../data/zippedBagItContainer > bagDownload.zip
```
You may also try this URL in a browser. (http://localhost:8080/api/v1/metastore/bagit)

## Installation Taverna Workflow

### Why using Taverna?

Taverna creates a 'metadata' sub directory containing collected output of all
processors: all intermediate METS files and a provenance file containing all
provenance of the workflow including start/end time of processor/workflow, used
input group(s), used parameters and created output group(s).

There are two ways to install taverna workflow.
1 'Local' installation
2. Docker installation

### 'Local' installation

```sh
git clone https://github.com/OCR-D/taverna_workflow.git
cd taverna_workflow/
bash installTaverna.sh ~/ocrd/taverna
```

#### Testing the installation

To check if the installation works fine you can start a first test.

```sh
cd ~/ocrd/taverna
bash startWorkflow.sh parameters_all.txt
[...]
Outputs will be saved to the directory: /.../Execute_OCR_D_workfl_output
# The processed workspace should look like this:
ls -1 workspace/example/data/
metadata
mets.xml
OCR-D-GT-SEG-BLOCK
OCR-D-GT-SEG-PAGE
OCR-D-IMG
OCR-D-IMG-BIN
OCR-D-IMG-BIN-OCROPY
OCR-D-OCR-CALAMARI_GT4HIST
OCR-D-OCR-TESSEROCR-BOTH
OCR-D-OCR-TESSEROCR-FRAKTUR
OCR-D-OCR-TESSEROCR-GT4HISTOCR
OCR-D-SEG-LINE
OCR-D-SEG-REGION
```

Each sub folder starting with 'OCR-D-OCR' should now contain 4 files with the
detected full text.

### Docker installation

```sh
wget https://raw.githubusercontent.com/OCR-D/taverna_workflow/master/Dockerfile
docker build -t ocrd/taverna .
mkdir ~/docker/ocrd/taverna
cd ~/docker/ocrd/taverna
docker run -v `pwd`:/data ocrd/taverna init
```

#### Testing the installation

To check if the installation works fine you can start a first test.

```sh
cd ~/docker/ocrd/taverna
docker run --network="host" -v `pwd`:/data ocrd/taverna testWorkflow
[...]
Outputs will be saved to the directory: /.../Execute_OCR_D_workfl_output
# The processed workspace should look like this:
ls -1 workspace/example/data/
metadata
mets.xml
OCR-D-GT-SEG-BLOCK
OCR-D-GT-SEG-PAGE
OCR-D-IMG
OCR-D-IMG-BIN
OCR-D-IMG-BIN-OCROPY
OCR-D-OCR-CALAMARI_GT4HIST
OCR-D-OCR-TESSEROCR-BOTH
OCR-D-OCR-TESSEROCR-FRAKTUR
OCR-D-OCR-TESSEROCR-GT4HISTOCR
OCR-D-SEG-LINE
OCR-D-SEG-REGION
```

Each sub folder starting with 'OCR-D-OCR' should now contain 4 files with the detected full text.

## Running a small workflow without taverna 

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

## Installation of the whole OCR-D Framework

To install the complete OCR-D framework docker is highly recommended.

```sh
wget https://github.com/VolkerHartmann/ocrd_framework/blob/master/install_OCR-D_framework.sh
bash install_OCR-D_framework.sh ~/ocrd_framework
```

Now there exists several folders

- repository - Contains all files of repository and the databases
- taverna - Contains all files workspaces and configuration of workflows

### Prepare '/etc/hosts' for accessing files in repository via browser

```sh
echo '127.0.0.1   kitdm20' | sudo tee -a /etc/hosts 
```

#### Testing the installation

To check if the installation works fine you can start a first test.

```sh
# Start repo in a shell
cd ~/ocrd_framework/repository
docker-compose up 
```

```sh
cd ~/ocrd_framework/taverna
docker run --network="host" -v `pwd`:/data ocrd/taverna testWorkflow
[...]
Outputs will be saved to the directory: /.../Execute_OCR_D_workfl_output
# The processed workspace should look like this:
ls -1 workspace/example/data/
metadata
mets.xml
OCR-D-GT-SEG-BLOCK
OCR-D-GT-SEG-PAGE
OCR-D-IMG
OCR-D-IMG-BIN
OCR-D-IMG-BIN-OCROPY
OCR-D-OCR-CALAMARI_GT4HIST
OCR-D-OCR-TESSEROCR-BOTH
OCR-D-OCR-TESSEROCR-FRAKTUR
OCR-D-OCR-TESSEROCR-GT4HISTOCR
OCR-D-SEG-LINE
OCR-D-SEG-REGION
```

Each sub folder starting with 'OCR-D-OCR' should now contain 4 files with the detected full text.

#### Check results in browser

After the workflow all results are ingested to the research data repository.
The repository is available at http://localhost:8080/api/v1/metastore/bagit

#### Configure your own workflow

For defining your own workflow with taverna please refer to the
[README](https://github.com/OCR-D/taverna_workflow/blob/master/README.MD#configure-your-own-workflow)

