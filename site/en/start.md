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

1. Install OCR-D via Docker and download example data from Github:
```sh
docker pull ocrd/all:maximum
mk dir ocr-d
cd ocr-d
git clone https://github.com/OCR-D/assets
mkdir workspace
cp -r assets/data/kant_aufklaerung_1784 workspace/kant_aufklaerung_1784
cd workspace/kant_aufklaerung_1784
```
2. Set up Docker :
 ```sh
sudo systemctl enable docker
sudo usermod -aG docker $USER
docker run --workdir /data --volume $PWD/.config:/.config --volume $PWD:/data --volume $PWD/models:/usr/local/share/ocrd-resources --volume $PWD/models:/usr/local/share/tessdata --volume $PWD/models:/usr/local/share/ocrd-resources -it ocrd/all bash
```
3. Download some models:
```sh
mkdir -p $PWD/models/ocrd-tesserocr-recognize
sudo mkdir -p /usr/local/share/ocrd-resources/ocrd-tesserocr-recognize/configs
cd data
ocrd resmgr download '*'
```

## First minimal workflow with OCR-D

```sh
ocrd-tesserocr-recognize -I OCR-D-IMG -O OCR-D-TESSOCR -P segmentation_level region -P textequiv_level word -P find_tables true -P model ocrd-tesserocr-recognize -I OCR-D-IMG -O OCR-D-TESSOCR -P segmentation_level region -P textequiv_level word -P find_tables true -P model Fraktur_GT4HistOCR
```

Congratulations! You ran your first (minimal) OCR-D Workflow. 
<br>
You will find the results in the directory
`workspace/kant_aufklaerung_1784` under `data`.
<br>
Consult the [Setup Guide](/en/setup) for more details and other installation methods or jump into the 
[User Guide](/en/user_guide) to learn more about OCR&#8209;D. Below you find a short explanation for the `ocrd-tesserocr-recognize` command.
<br>

### Explanation

The command`ocrd-tesserocr-recognize -I OCR-D-IMG -O OCR-D-TESSOCR -P segmentation_level region -P textequiv_level word -P find_tables true -P model Fraktur_GT4HistOCR`
for the recognition contains the following parameters:
<br><br>
1. `ocrd-tesserocr-recognize` is the processor used.
2. `-I` is followed by the name of the input folder, here images.
3. `-O` is followed by the name of the output folder where you will find the results (here binarised images and mets files with the recognised text.
4. `-P segmentation_level region` is a parameter for the processor which tells tesserocr to start the segmentation on the level of regions.
5. `-P textequiv_level word` is a parameter for the processor which tells tesserocr to stop the segmentation on the level of words (meaning glyphs will not be segmented here).
6. `-P find_tables true` is a parameter for the processor which tells tesserocr to recognise tables.
7. `-P model Fraktur_GT4HistOCR` is a parameter for the processor which tells tesserocr to use the model `Fraktur_GT4HistOCR` 
for recognition.