---
layout: page
author: Volker Hartmann, Elisabeth Engl
date: 2020-02-20T10:14:34+01:00
lang: en
lang-ref: https://translate.google.com/translate?hl=&sl=en&tl=de&u=https%3A%2F%2Focr-d.de%2Fen%2Fworkflows
title: OCR-D Workflow Guide
toc: true
---

# Workflows
There are several steps necessary to get the fulltext of a scanned print. The whole OCR process is shown in the following figure:

![](https://ocr-d.de/assets/Funktionsmodell.svg)

The following instructions describe all steps of an OCR workflow. Depending on your particular print (or rather images), not all of those
steps might be necessary to obtain good results. Whether a step is required or optional is indicated in the description of each step.
This guide provides an overview of the available OCR-D processors and their required parameters. For more complex workflows and recommendations
see the [OCR-D-Website-Wiki](https://github.com/OCR-D/ocrd-website/wiki). Feel free to add your own experiences and recommendations in the Wiki!
We will regularly amend this guide with valuable contributions from the Wiki.

**Note:** In order to be able to run the workflows described in this guide, you need to have prepared your images in an [OCR-D-workspace](https://ocr-d.de/en/user_guide#preparing-a-workspace).
We expect that you are familiar with the [OCR-D-user guide](https://ocr-d.de/en/user_guide) which explains all preparatory steps, syntax and different
solutions for executing whole workflows.

## Image Optimization (Page Level)
At first, the image should be prepared for OCR.

### Step 0: Image Enhancement (Page Level, optional)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-preprocessing.md|sed '$d'-->

### Step 1: Binarization (Page Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-binarization.md|sed '$d'-->

### Step 2: Cropping (Page Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-cropping.md|sed '$d'-->

### Step 3: Binarization (Page Level)

For better results, the cropped images can be binarized again at this point or later on (on region level).


#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remark</th>
      <th>Call</th>
  </tr>
  </thead>
  <tbody>
    <tr data-processor="ocrd-olena-binarize">
      <td>ocrd-olena-binarize</td>
      <td></td>
      <td>Recommended</td>
      <td><code>ocrd-olena-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
  <tr data-processor="ocrd-skimage-binarize">
      <td>ocrd-skimage-binarize</td>
      <td></td>
      <td></td>
      <td><code>ocrd-skimage-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
  <tr data-processor="ocrd-cis-ocropy-binarize">
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
      <td></td>
      <td><code>ocrd-cis-ocropy-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
  </tbody>
</table>


### Step 4: Denoising (Page Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-denoising.md|sed '$d'-->

### Step 5: Deskewing (Page Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-deskewing.md|sed '$d'-->

### Step 6: Dewarping (Page Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-dewarping.md|sed '$d'-->

## Layout Analysis

By now the image should be well prepared for segmentation.

### Step 7: Region segmentation

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-region-segmentation.md|sed '$d'-->

## Image Optimization (Region Level)

In the following steps, the text regions should be optimized for OCR.

### Step 8:  Binarization (Region Level)

In this processing step, a scanned colored /gray scale document image is taken as input and a black
and white binarized image is produced. This step should separate the background from the foreground.

The binarization should be at least executed once (on page or region level). If you already binarized
your image twice on page level, and have no large images, you can probably skip this step.


#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr data-processor="ocrd-skimage-binarize">
      <td>ocrd-skimage-binarize</td>
      <td><code>-P level-of-operation region</code></td>
      <td></td>
      <td><code>ocrd-skimage-binarize -I OCR-D-SEG-REG -O OCR-D-BIN-REG -P level-of-operation region</code></td>
    </tr>
    <tr data-processor="ocrd-preprocess-image">
      <td>ocrd-preprocess-image</td>
      <td>
        <code>-P level-of-operation region</code><br/>
        <code>-P "output_feature_added" binarized</code><br/>
        <code>-P command "scribo-cli sauvola-ms-split '@INFILE' '@OUTFILE' --enable-negate-output"</code>
      </td>
      <td>&nbsp;</td>
      <td><code>
    ocrd-preprocess-image -I OCR-D-SEG-REG -O OCR-D-BIN-REG -P level-of-operation region -P output_feature_added binarized -P command "scribo-cli sauvola-ms-split @INFILE @OUTFILE --enable-negate-output"
      </code></td>
    </tr>
    <tr data-processor="ocrd-cis-ocropy-binarize">
      <td>ocrd-cis-ocropy-binarize</td>
      <td><code>-P level-of-operation region</code><br/><code>-P "noise_maxsize": float</code></td>
      <td></td>
      <td><code>ocrd-cis-ocropy-binarize -I OCR-D-SEG-REG -O OCR-D-BIN-REG -P level-of-operation region</code></td>
    </tr>
  </tbody>
</table>

### Step 9:  Clipping (Region Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-clipping.md|sed '$d'-->

### Step 10:  Deskewing (Region Level)

In this processing step, text region images are taken as input and their skew is corrected by annotating the detected angle (-45° .. 45°) and rotating the image. Optionally, also the orientation is corrected by annotating the detected angle (multiples of 90°) and transposing the image.


<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
      <a href="https://ocr-d.de/assets/workflow/seg-page.PNG"><img src="https://ocr-d.de/assets/workflow/seg-page.PNG" alt=""></a>
      </td>
      <td>
      <a href="https://ocr-d.de/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png"><img src="https://ocr-d.de/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></a>
      </td>
    </tr>
  </tbody>
</table>

#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr data-processor="ocrd-cis-ocropy-deskew">
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>-P level-of-operation region</code></td>
      <td></td>
      <td><code>ocrd-cis-ocropy-deskew -I OCR-D-BIN-REG -O OCR-D-DESKEW-REG -P level-of-operation region</code></td>
    </tr>
    <tr data-processor="ocrd-tesserocr-deskew">
      <td>ocrd-tesserocr-deskew</td>
      <td></td>
      <td>Fast, also performs a decent orientation correction</td>
      <td><code>ocrd-tesserocr-deskew -I OCR-D-BIN-REG -O OCR-D-DESKEW-REG</code></td>
    </tr>
  </tbody>
</table>

### Step 11: Line segmentation

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-line-segmentation.md|sed '$d'-->

### Step 12: Resegmentation (Line Level)

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-resegmentation.md|sed '$d'-->

### Step 13: Dewarping (Line Level)

In this processing step, the text line images get vertically aligned if they are curved.

<table class="">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
      <a href="https://ocr-d.de/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="https://ocr-d.de/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
      <td>
      <a href="https://ocr-d.de/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="https://ocr-d.de/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
    </tr>
  </tbody>
</table>

#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr data-processor="ocrd-cis-ocropy-dewarp">
      <td>ocrd-cis-ocropy-dewarp</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td><code>ocrd-cis-ocropy-dewarp -I OCR-D-CLIP-LINE -O OCR-D-DEWARP-LINE</code></td>
    </tr>
  </tbody>
</table>

## Text Recognition

### Step 14: Text recognition

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-text-recognition.md|sed '$d'-->

## Post Correction (Optional)

### Step 15: Text alignment

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-text-alignment.md|sed '$d'-->

### Step 16: Post-correction

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-post-correction.md|sed '$d'-->

## Evaluation (Optional)

If Ground Truth data is available, the OCR can be evaluated.

### Step 17: OCR Evaluation

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-ocr-evaluation.md|sed '$d'-->

## Generic Data Management (Optional)

OCR-D produces PAGE XML files which contain the recognized text as well as detailed
information on the structure of the processed pages, the coordinates of the recognized
elements etc. Optionally, the output can be converted to other formats, or copied verbatim (re-generating PAGE-XML)

### Step 18: Adaptation of Coordinates

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-adaption-of-coordinates.md|sed '$d'-->

### Step 19: Format Conversion

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-format-conversion.md|sed '$d'-->

### Step 20: Archiving

<!-- HERE-EVAL sed -n '0,/^## Notes/ p' ./repo/ocrd-website.wiki/Workflow-Guide-archiving.md|sed '$d'-->

### Step 21: Dummy Processing

Sometimes it can be useful to have a dummy processor, which takes the files in an Input fileGrp and
copies them the a new Output fileGrp, re-generating the PAGE XML from the current namespace schema/model.

#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr data-processor="ocrd-dummy">
      <td>ocrd-dummy</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    <td><code>ocrd-dummy -I OCR-D-FILEGRP -O OCR-D-DUMMY</code></td>
    </tr>
  </tbody>
</table>

# Recommendations

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-recommendations.md-->

<script src="/js/workflows.js"></script>
