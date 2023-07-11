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
**On Windows**, install WSL and Linux by following these steps:

* Install WSL 2 by opening the PowerShell and running:

```sh
wsl --install
```

* [Download and install Ubuntu 22.04.2 LTS from Microsoft App Store.](https://www.microsoft.com/store/productId/9PN20MSR04DW)
* Open Ubuntu 22.04.2 LTS and follow the instructions.

## Install and set up Docker

Run:

```sh
docker ps
```

If the command is not found, you may need to 
[install Docker]([docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository)) first.
<br>
Now run:

```sh
sudo systemctl enable docker
sudo usermod -aG docker $USER
```


## First Steps with OCR-D

```sh
docker pull ocrd/all:maximum
docker run --user $(id -u) --workdir /data --volume $PWD:/data --rm -it ocrd/all bash
mk dir ocr-d
cd ocr-d
git clone https://github.com/OCR-D/assets
mkdir workspace
cp -r assets/data/kant_aufklaerung_1784 workspace/kant_aufklaerung_1784
cd workspace/kant_aufklaerung_1784
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
```

Congratulations! You ran your first (minimal) OCR-D Workflow. You will find the results in the directory
`workspace/kant_aufklaerung_1784` under `data`.

