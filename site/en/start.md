---
layout: page
lang: en
lang-ref: https://translate.google.com/translate?hl=&sl=en&tl=de&u=https%3A%2F%2Focr-d.de%2Fen%2Fstart
toc: true
title: 
---

# OCR-D Quick Start Guide

## Open your Ubuntu Terminal

**On Ubuntu**, open your Terminal.<br>
**On Windows**, install WSL, Ubuntu and Docker Desktop by following these steps:

1. Install WSL 2 by opening the PowerShell and running:
```sh
wsl --install
```
2. [Download and install Ubuntu 22.04.2 LTS from Microsoft App Store.](https://www.microsoft.com/store/productId/9PN20MSR04DW)

3. Open Ubuntu 22.04.2 LTS and follow the instructions.

4. [Install Docker Desktop and set it up for WSL 2](https://docs.docker.com/desktop/wsl/). 

5. Make sure, Docker Desktop is running.

## Install and set up Docker

In the Ubuntu shell, run:
```sh
docker ps
```
If the command is not found, you may need to 
[install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) first.

## Further Requisites

1. Set up Docker :
 ```sh
sudo systemctl enable docker
sudo usermod -aG docker $USER
 ```
2. Install OCR-D via Docker
```sh
docker pull ocrd/all:maximum
```
3. Download example data from Github
```sh
mkdir ocr-d
wget https://github.com/OCR-D/gt_structure_text/releases/download/v1.5.0/euler_rechenkunst01_1738.ocrd.zip
unzip euler_rechenkunst01_1738.ocrd.zip -d ocr-d/euler_rechenkunst01_1738
```
4. Start interactive shell in Docker
```sh
docker run --volume $PWD/ocr-d:/data --volume ocrd-resources:/models -it ocrd/all:maximum bash
```
5. Download some models:
```sh
ocrd resmgr download ocrd-tesserocr-recognize '*'
```

## First minimal workflow with OCR-D

```sh
ocrd-tesserocr-recognize -w euler_rechenkunst01_1738 -I OCR-D-IMG -O OCR-D-OCR-TESS -P segmentation_level region -P find_tables true -P model frak2021
```

Congratulations! You ran your first (minimal) OCR-D Workflow. 

You will find the results in the directory
`/data/ocr-d/euler_rechenkunst01_1738` (in the container) or
`ocr-d/euler_rechenkunst01_1738` (on the host side).

Consult the [Setup Guide](/en/setup) for more details and other installation methods or jump into the 
[User Guide](/en/user_guide) to learn more about OCR&#8209;D. 

Next we will explain the above `ocrd-tesserocr-recognize` command.

### Explanation

The command that called the recognition processor consists of the following parts:
```sh
ocrd-tesserocr-recognize -I OCR-D-IMG -O OCR-D-OCR-TESS -P segmentation_level region -P find_tables true -P model frak2021
╰─────── 1 ────────────╯ ╰─── 2 ────╯ ╰───── 3 ───────╯ ╰────────── 4 ─────────────╯ ╰────── 5 ────────╯ ╰───── 6 ───────╯
```
1. `ocrd-tesserocr-recognize` is the name of the processor executable used.
2. `-I` is followed by the name of the input file group (and directory); 
    here: images.
3. `-O` is followed by the name of the output file group (and directory); 
    here: binarised images and PAGE-XML files with the recognised text.
4. `-P segmentation_level region` is a parameter name/value pair; 
    here: tells the processor to start segmentation on the level of regions
    (so no prior layout analysis annotating text lines in PAGE-XML is required).
5. `-P find_tables true` ...
    here: enables layout detection of tables.
6. `-P model frak2021` ...
    here: use the named resource `frak2021.traineddata` for recognition.
