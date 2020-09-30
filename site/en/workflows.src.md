---
layout: page
author: Volker Hartmann, Elisabeth Engl
date: 2020-02-20T10:14:34+01:00
lang: en
lang-ref: https://translate.google.com/translate?hl=&sl=en&tl=de&u=https%3A%2F%2Focr-d.de%2Fen%2Fworkflows
toc: true
---

# Workflows
There are several steps necessary to get the fulltext of a scanned print. The whole OCR process is shown in the following figure:

![](https://ocr-d.de/assets/Funktionsmodell.png)

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

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-preprocessing.md -->

### Step 1: Binarization (Page Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-binarization.md -->

### Step 2: Cropping (Page Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-cropping.md -->

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

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-denoising.md -->

### Step 5: Deskewing (Page Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-deskewing.md -->

### Step 6: Dewarping (Page Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-dewarping.md -->

## Layout Analysis

By now the image should be well prepared for segmentation.

### Step 7: Region segmentation

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-region-segmentation.md -->

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

### Step 9:  Deskewing (Region Level)

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

### Step 10:  Clipping (Region Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-clipping.md -->

### Step 11: Line segmentation

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-line-segmentation.md -->

### Step 12: Resegmentation (Line Level)

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-resegmentation.md -->

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

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-text-recognition.md -->

## Post Correction (Optional)

### Step 15: Text alignment

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-text-alignment.md -->

### Step 16: Post-correction

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-post-correction.md -->

## Evaluation (Optional)

If Ground Truth data is available, the OCR can be evaluated.

### Step 17: OCR Evaluation

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-ocr-evaluation.md -->

## Generic Data Management (Optional)

OCR-D produces PAGE XML files which contain the recognized text as well as detailed
information on the structure of the processed pages, the coordinates of the recognized
elements etc. Optionally, the output can be converted to other formats, or copied verbatim (re-generating PAGE-XML)

### Step 18: Adaptation of Coordinates

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-adaption-of-coordinates.md -->

### Step 19: Format Conversion

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-format-conversion.md -->

### Step 20: Archiving

<!-- HERE-INCLUDE ./repo/ocrd-website.wiki/Workflow-Guide-archiving.md -->

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

All processors, with the exception of those for post-correction, were tested on
selected pages of some prints from the 17th and 18th century.

The results vary quite a lot from page to page. In most cases, segmentation is a problem.

These recommendations may also work well for other prints of those centuries.

Note that for our test pages, not all steps described above werde needed to obtain the best results.
Depending on your particular images, you might want to include those processors again for better results.


## Best results for selected pages

The following workflow has produced best results for 'simple' pages (e.g. [this
page](https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/dda89351-7596-46eb-9736-593a5e9593d3/data/bagit/data/OCR-D-IMG/OCR-D-IMG_0004.tif))  (CER ~1%).

<table class="processor-table">
  <thead>
    <tr>
      <th>Step</th>
      <th>Processor</th>
      <th>Parameter</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
    </tr>
  <tr>
      <td>2</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-skimage-binarize</td>
      <td>-P method li</td>
    </tr>
    <tr>
      <td>4</td>
      <td>ocrd-skimage-denoise</td>
      <td>P level-of-operation page</td>
    </tr>
    <tr>
      <td>5</td>
      <td>ocrd-tesserocr-deskew</td>
      <td>-P level-of-operation page</td>
    </tr>
    <tr>
      <td>7</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>-P level-of-operation page</td>
    </tr>
    <tr>
      <td>9</td>
      <td>ocrd-tesserocr-deskew</td>
      <td></td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td></td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>-P level-of-operation region</td>
    </tr>
    <tr>
    <td>12</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td>-P level-of-operation line</td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>14</td>
      <td>ocrd-calamari-recognize</td>
      <td>-P checkpoint /path/to/models/\*.ckpt.json</td>
    </tr>
  </tbody>
</table>

### Example with ocrd-process

```sh
ocrd process \
  "cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-BIN" \
  "anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP" \
  "skimage-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P method li" \
  "skimage-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page" \
  "tesserocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P operation_level page" \
  "cis-ocropy-segment -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG-REG -P level-of-operation page" \
  "tesserocr-deskew -I OCR-D-SEG-REG -O OCR-D-SEG-REG-DESKEW" \
  "cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP" \
  "cis-ocropy-segment -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE" \
  "cis-ocropy-clip -I OCR-D-SEG-LINE -O OCR-D-SEG-CLIP-LINE -P level-of-operation line" \
  "cis-ocropy-dewarp -I OCR-D-SEG-CLIP-LINE -O OCR-D-SEG-LINE-RESEG-DEWARP" \
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P checkpoint /path/to/models/\*.ckpt.json"
```

**Note:**
(1) This workflow expects your images to be stored in a folder called `OCR-D-IMG`. If your images are saved in a different folder,
you need to adjust `-I OCR-D-IMG` in the second line of the call above with the name of your folder, e.g. `-I MAX`
(2) For the last processor in this workflow, `ocrd-calamari-recognize`, you need to specify your local path to the model on your hard drive
as parameter value! The last line of the `ocrd-process` call above could e.g. look like this:
```sh
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P checkpoint /test/data/calamari_models/\*.ckpt.json"
```
All the other lines can just be copied and pasted.

## Good results for slower processors

If your computer is not that powerful you may try this workflow. It works fine for simple pages and produces also good results in shorter time.

<table class="processor-table">
  <thead>
    <tr>
      <th>Step</th>
      <th>Processor</th>
      <th>Parameter</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
    </tr>
  <tr>
      <td>2</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-skimage-binarize</td>
      <td>-P method li</td>
    </tr>
    <tr>
      <td>4</td>
      <td>ocrd-skimage-denoise</td>
      <td>-P level-of-operation page</td>
    </tr>
    <tr>
      <td>5</td>
      <td>ocrd-tesserocr-deskew</td>
      <td>-P level-of-operation page</td>
    </tr>
    <tr>
      <td>7</td>
      <td>ocrd-tesserocr-segment-region</td>
      <td></td>
    </tr>
    <tr>
    <td>7a</td>
      <td>ocrd-segment-repair</td>
      <td>-P plausibilize true</td>
    </tr>
    <tr>
      <td>9</td>
      <td>ocrd-tesserocr-deskew</td>
      <td></td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td></td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-tesserocr-segment-line</td>
      <td></td>
    </tr>
    <tr>
    <tr>
      <td>13</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>14</td>
      <td>ocrd-tesserocr-recognize</td>
      <td>-P textequiv_level glyph -P overwrite_words true -P model GT4HistOCR_50000000.997_191951</td>
    </tr>
  </tbody>
</table>

### Example with ocrd-process

```sh
ocrd process \
  "cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-BIN" \
  "anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP" \
  "skimage-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P method li" \
  "skimage-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page" \
  "tesserocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P operation_level page" \
  "tesserocr-segment-region -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG-REG" \
  "segment-repair -I OCR-D-SEG-REG -O OCR-D-SEG-REPAIR -P plausibilize true" \
  "tesserocr-deskew -I OCR-D-SEG-REPAIR -O OCR-D-SEG-REG-DESKEW" \
  "cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP" \
  "tesserocr-segment-line -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE" \
  "cis-ocropy-dewarp -I OCR-D-SEG-LINE -O OCR-D-SEG-LINE-RESEG-DEWARP" \
  "tesserocr-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P textequiv_level glyph -P overwrite_words true -P model GT4HistOCR_50000000.997_191951}"
```

**Note:**
(1) This workflow expects your images to be stored in a folder called `OCR-D-IMG`. If your images are saved in a different folder,
you need to adjust `-I OCR-D-IMG` in the second line of the call above with the name of your folder, e.g. `-I my_images`
(2) For the last processor in this workflow, `ocrd-tesserocr-recognize`, the environment variable TESSDATA_PREFIX has to be
set to point to the directory where the used models are stored if they are not in the default location.

<script src="/js/workflows.js"></script>
