---
layout: page
toc: true
lang: en
lang-ref: cookbook
---

# OCR-D Cookbook

> A set of examples on how to apply the [OCR-D guide](guide)

## Introduction

The "OCR-D cookbook" helps developers writing software and using
tools within the OCR-D ecosystem by listing practical examples in addition to the OCR-D guide.

## From image to transcription

### OCR-D workflow

The workflow consists of several steps, from the image with some additional
metadata to the textual content of the image. The tools used to generate the
text are divided into the following categories:

- Image preprocessing
- Layout analysis
- Text recognition and optimization
- Model training
- Long-term preservation
- Quality assurance

The workflow may be divided in the following steps:

- preprocessing/characterization
- preprocessing/optimization
- preprocessing/optimization/cropping
- preprocessing/optimization/deskewing
- preprocessing/optimization/despeckling
- preprocessing/optimization/dewarping
- preprocessing/optimization/binarization
- preprocessing/optimization/grayscale_normalization
- layout/segmentation
- layout/segmentation/region
- layout/segmentation/line
- layout/segmentation/word
- layout/segmentation/classification
- layout/analysis
- recognition/text-recognition
- recognition/font-identification

### KRAKEN, OLENA, TESSEROCR, OCROPY

```sh
# Step 0: Check/Install git and dependencies
```

See subsection [Bootstrapping](#bootstrapping)

```sh
# Step 1: Clone repositories
# Step 1a: KRAKEN
$ cd ~/projects/OCR-D
$ git clone https://github.com/OCR-D/ocrd_kraken
$ cd ocrd_kraken/
$ make deps
$ make install
# Step 1b: Test installation
$ ocrd-kraken-binarize --version
Version 0.0.1, ocrd/core 0.4.0
```

## Workflows

### Binarize one image without existing METS file.

```sh
# Step 0: Create Workspace & METS file
# ------------------------
# Step 0a: Create directory for workshop
$ mkdir -p ~/projects/OCR-D/workshop/2018_06_26/workspaces
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces
# Step 0b: Create workspace including METS file in subdir `./emptyWorkspace`
$ ocrd workspace init emptyWorkspace
$ cd emptyWorkspace
$ ocrd workspace validate
$ cd ws1  
# Step 0c: Validate workspace
<report valid="false">
  <error>METS has no unique identifier</error>
  <error>No files</error>
</report>
# Step 0d: Add identifier to METS file
$ ocrd workspace set-id 'http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000'
$ ocrd workspace validate
<report valid="false">
  <error>No files</error>
</report>

# Step 1: Download tiff image
# ---------------------------
$ wget -O PPN767137728_00000005.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=tif&metsFile=PPN767137728&divID=PHYS_0005&original=true"


# Step 2: Add image to METS
# -------------------------
# Be aware, that the ID and the GROUPID have to identical if the referenced image represents the original image
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0001 --group-id OCR-D-IMG_0001 --mimetype image/tiff PPN767137728_00000005.tif

# Step 3: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 3a: Clone workspace (optional)
# -----------------------------------
# Create new directory and clone workspace to this directory
$ ocrd workspace clone --download mets.xml ../cloneEmptyWorkspace
$ cd ../cloneEmptyWorkspace
# Show all files (use --help to see all parameters)
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/cloneEmptyWorkspace/PPN767137728_00000005.tif

# Step 4: Execute binarization of image
# -------------------------------------
```

See subsection [Bootstrapping](#bootstrapping)

```sh
# Step 4a: Install KRAKEN see [Installation KRAKEN] (#KRAKEN, OLENA, TESSEROCR, OCROPY)
```

See subsection [Install KRAKEN](#KRAKEN-OLENA-TESSEROCR-OCROPY)

```sh
# Step 4b: List all available tools
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json list-tools
  ocrd-kraken-binarize
  ocrd-kraken-ocr
  ocrd-kraken-segment
# Step 4c: List attributes of 'ocrd-kraken-binarize'
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize description
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize categories
Binarize images with kraken
  Image preprocessing
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize steps
  preprocessing/optimization/binarization

# Step 4d: Binarize Image with KRAKEN
# Binarize all images inside fileGrp 'OCR-D-IMG'
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --group-id OCR-D-IMG_0001 --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeEmptyWorkspace --mets mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeEmptyWorkspace/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# That's it
```

### Binarize all images of a METS file.


```sh
# Step 0: Create Workspace & METS file
# ------------------------
# Step 0a: Create workspace including METS file
$ ocrd workspace init ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages
# Step 0b: Validate workspace
$ ocrd workspace validate
<report valid="false">
  <error>METS has no unique identifier</error>
  <error>No files</error>
</report>
# Step 0c: Add identifier to METS file
$ ocrd workspace set-id http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000
# <mods:mods xmlns:mods="http://www.loc.gov/mods/v3">
#   <mods:identifier type="purl">http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000</mods:identifier>
# </mods:mods>
$ ocrd workspace validate
<report valid="false">
  <error>No files</error>
</report>
# Step 1: Download tiff images
# ----------------------------
$ wget -O PPN767137728_00000005.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=jpg&metsFile=PPN767137728&divID=PHYS_0005&original=true"
$ wget -O PPN767137728_00000006.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=jpg&metsFile=PPN767137728&divID=PHYS_0006&original=true"    


# Step 2: Add images to METS
# --------------------------
# Be aware, that the ID and the GROUPID have to identical if the referenced image represents the original image
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0001 --group-id OCR-D-IMG_0001 --mimetype image/tiff PPN767137728_00000005.tif
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0002 --group-id OCR-D-IMG_0002 --mimetype image/tiff PPN767137728_00000006.tif

# Step 3: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 3a: Clone workspace (optional)
# -----------------------------------
# Create new directory and clone workspace to this directory
$ ocrd workspace clone --download $OLDPWD/mets.xml workspace3
# Show all files (use --help to see all parameters)
$ cd workspace3
$ ocrd workspace find
file:///path/to/new/workspace/OCR-D-IMG/PPN767137728_00000005.tif
file:///path/to/new/workspace/OCR-D-IMG/PPN767137728_00000006.tif

# Step 4: Binarize Image with KRAKEN
# ----------------------------------
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages --mets /tmp/pyocrd-'xyz'/mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# That's it
```

### Binarize one image of a METS file.

For preparing workspace see subsection [Binarize all images of a METS file](#binarize-all-images-of-a-mets-file) (Step 0 - 3)

```sh
# Step 0: Reuse existing workspace
# --------------------------------
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages

# Step 0b: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 1: Clone workspace (optional)
# -----------------------------------
# This step creates a temporal directory (/tmp/pyocrd-'xyz')
$ ocrd workspace clone --download mets.xml ../selectOneImage
# Change directory
$ cd ../selectOneImage
# Show all files (use --help to see all parameters)
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/selectOneImage/OCR-D-IMG/PPN767137728_00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/selectOneImage/OCR-D-IMG/PPN767137728_00000006.tif

# Step 2: Binarize Image with KRAKEN
# ----------------------------------
# Step 2a: List all GROUPIDs.
§ ocrd workspace find --output-field groupId
OCR-D-IMG_0001
OCR-D-IMG_0002
Step 2b: Binarize image from a chosen GROUPID
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --group-id OCR-D-IMG_0001 --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeSelectedImage --mets mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeSelectedImage/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# That's it
```

### Get Ground Truth from OCR-D

```sh
# Create data directory
$ mkdir -p ~/projects/OCR-D/data/groundTruth
$ cd ~/projects/OCR-D/data/groundTruth
# Download GT from OCR-D
$ wget http://ocr-d.de/sites/all/GTDaten/blumenbach_anatomie_1805.zip
$ unzip blumenbach_anatomie_1805.zip

# Step 1: Clone workspace from METS
$ mkdir -p ~/projects/OCR-D/workshop/2018_06_26/workspaces/; cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/
$ ocrd workspace clone --download ~/projects/OCR-D/data/groundTruth/blumenbach_anatomie_1805/blumenbach_anatomie_1805/mets.xml blumenbach_anatomie_1805
$ cd blumenbach_anatomie_1805/
```

### Installing a MP executable

```bash=
$ mkdir ~/projects/OCR-D/modules
$ cd ~/projects/OCR-D/modules
$ git clone https://github.com/OCR-D/ocrd_kraken
$ cd ocrd_kraken
$ sudo make install
```

### Tools for MP

#### Getting files referenced inside METS

The command 'ocrd workspace find' supports several options.

```sh
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages
# List all files.
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000006.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files inside a fileGrp
§ ocrd workspace find --file-grp OCR-D-IMG-KRAKEN-BIN
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files of a GROUPID
$ ocrd workspace find --group-id  OCR-D-IMG_0001
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# See 'ocrd workspace find --help' for further information
```
