---
layout: page
author: Volker Hartmann, Elisabeth Engl
date: 2020-02-20T10:14:34+01:00
lang: en
lang-ref: workflow
toc: true
---

# Workflows
There are several steps necessary to get the fulltext of a scanned print. The whole OCR process is shown in the following figure:

![](/assets/Funktionsmodell.png)

The following instruction describes all steps of the OCR workflow. Depending on your particular print or rather images not all of those steps will be necessary to obtain good results. Whether a step is required or optional is indicated in the description of each step. 

## Image Optimization
Prepare image for better OCR.

![](/assets/workflow/Original.png)

### Step 1: Binarization
First, all the images should be binarized. Many of the following processors require binarized images. Note that some segmentation algorithms seem to produce better results using the original image.

This processor takes a scanned colored /gray scale document image as input and produces a black and white binarized image. This step should separate the background from the foreground.

<table class="before-after">
  <tbody>
    <tr>
      <td>
        <img src="/assets/workflow/Original.png"/>
      </td>
      <td>
        <img src="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png"/>
      </td>
    </tr>
  </tbody>
</table>

**See also:**  **ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table class="processor-table">
  <thead>
    <tr>
      <th>Procecssor</th>
      <th>Parameter</th>
      <th>Remark</th>
      <th>Call</th>
	</tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-binarize</td>
      <td></td>
      <td>Fast</td>
	  <td>ocrd-anybaseocr-binarize -I OCR-D-IMG -O OCR-D-BIN</td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
      <td></td>
	  <td>ocrd-cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-BIN</td>
    </tr>
    <tr>
      <td>ocrd-olena-binarize</td>
      <td>
        <pre>
{"impl": "sauvola"}
{"impl": "sauvola-ms"}
{"impl": "sauvola-ms-fg"}
{"impl": "sauvola-ms-split"}
{"impl": "kim"}
{"impl": "wolf"}
{"impl": "niblack"}
{"impl": "singh"}
{"impl": "otsu"}
        </pre>
      </td>
      <td>Recommended</td>
	  <td>ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN</td>
    </tr>
  </tbody>
</table>

### Step 2: Denoising

This processor removes artifacts from the binarized image. 

May not be necessary for all prints.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png" alt=""></td>
      <td><img src="/assets/workflow/denoise.PNG" alt=""></td>
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
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-denoise</td>
      <td><code>{“level-of-operation”:”page”}</code></td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 3: Deskewing

This processor takes a document image as input and does the skew correction of
that document. The input images have to be binarized for this module to work.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/denoise.PNG" alt=""></td>
      <td><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001.png" alt=""></td>
    </tr>
  </tbody>
</table>

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-deskew</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-deskew</td>
      <td><code>{“operation_level”:”page”}</code></td>
      <td>Fast</td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>{“level-of-operation”:”page”}</code></td>
      <td>Recommended</td>
    </tr>
  </tbody>
</table>

### Step 4: Dewarping

This processor takes a document image as input and makes the text line straight if its curved. The input image has to be binarized for the module to work.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-dewarp</td>
      <td>
        <pre>
{
  "pix2pixHD":"/path/to/pix2pixHD/",
  "model_name":"/path/to/pix2pixHD/models"
}
        </pre>
      </td>
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Parameter <code>model_name</code> is missleading. Given directory has to contain a file named ‘latest_net_G.pth’ <br> <strong>GPU required!</strong></td>
    </tr>
  </tbody>
</table>

### Step 5: Cropping

This processor takes a document image as input and crops/selects the page
content area only (i.e. it removes textual noise as well as any other noise
around the page content area).

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001.png" alt=""></td>
      <td><img src="/assets/workflow/OCR-D-IMG-CROP_0001.png" alt=""></td>
    </tr>
  </tbody>
</table>


#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-crop</td>
      <td>&nbsp;</td>
      <td>The input image has to be binarized and <br>should be deskewed for the module to work.</td>
    </tr>
  </tbody>
</table>

## Layout Analysis

Now the image should be optimized for segmentation.

### Step 6: Text segmentation (page)

This processor takes an (optimized) document image as an input and segments the
image into the different text blocks. During this step a classification (text,
marginalia, image, ...) should also be done.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/OCR-D-IMG-CROP_0001.png" alt=""></td>
      <td><img src="/assets/workflow/seg-page.PNG" alt=""></td>
    </tr>
  </tbody>
</table>


#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-segment-region</td>
      <td>&nbsp;</td>
      <td>Should also work for original images!?</td>
    </tr>
    <tr>
      <td>ocrd-anybaseocr-block-segmentation</td>
      <td><pre>
{
  "block_segmentation_model": "/path/to/mrcnn",
  "block_segmentation_weights": "/path/to/model/block_segmentation_weights.h5"
}
      </pre>
      </td>
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Should also work for original images!?</td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"page"}</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

## Image Optimization (on Block Level)

Now the blocks should be optimized for OCR.

### Step 7:  Binarization 

This processor takes a scanned colored /gray scale block as input and produces
a black and white binarized image. This step should separate the background
from the foreground.

The binarization should be at least executed once (on page/block/line level).

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-binarize</td>
      <td>{"operation_level":"region"}</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 8:  Deskewing 

This processor takes an image as input and does the skew correction for all text blocks.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="before-after">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/seg-page.PNG" alt=""></td>
      <td><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></td>
    </tr>
  </tbody>
</table>

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"region"}</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 9:  Cliping 

This processor can be used to remove intrusions of neighbouring segments in
regions / lines of a workspace. It runs a (ad-hoc binarization and) connected
component analysis on every text region / line of every PAGE in the input file
group, as well as its overlapping neighbours. For each binary object of
conflict, it determines whether it belongs to the neighbour, and can therefore
be clipped to white. It references the resulting segment image files in the
output PAGE (as AlternativeImage).

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"region"}</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 10: Line segmentation 

This processor can be used to segment regions into lines. It runs a (ad-hoc
binarization and) line segmentation on every text region of every PAGE in the
input file group, and adds a TextLine element with the resulting polygon
outline to the annotation of the output PAGE.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></td>
      <td><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></td>
    </tr>
  </tbody>
</table>

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"region"}</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-segment-line</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 11:  Line correction 

This processor can be used to correct the segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"line"}</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-resegment</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>ocrd-segment-repair</td>
      <td>{"sanitize":true}</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 12: Dewarping (on line level)

This processor can be used to dewarp the segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

<table class="">
  <thead>
    <tr>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></td>
      <td><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></td>
    </tr>
  </tbody>
</table>

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-dewarp</td>
      <td>{"operation_level":"line",<br>"pix2pixHD":"/path/to/pix2pixHD/",<br>"model_name":"/path/to/pix2pixHD/models"}</td>
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Parameter ‘model_name’ is missleading. Given directory has to contain a file named ‘latest_net_G.pth’ <br> <strong>GPU required!</strong></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

## Text Recognition and Optimization

### Step 13: Text recognition

This processor recognizes text in segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-recognize</td>
      <td>
        <pre>
{"textequiv_level":"glyph",<br />"overwrite_words":true,"model":"Fraktur"}
        </pre>
        <pre>
{"textequiv_level":"glyph",<br/>"overwrite_words":true,<br/>"model":"GT4HistOCR_50000000.997_191951"}
        </pre>
      </td>
      <td>Recommended <br/> Model can be found [here](https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/GT4HistOCR_50<br/>00000/tessdata_best/GT4HistOCR_50000000.997_191951.traineddata)</td>
    </tr>
    <tr>
      <td>ocrd-calamari-recognize</td>
      <td>
        <pre>
{"checkpoint":"/path/to/models/\*.ckpt.json"}
        </pre>
        &nbsp;</td>
      <td>
        Recommended<br/>Model can be found [here](https://ocr-d-repo.scc.kit.edu/models/calamari/GT4HistOCR/model.tar.xz) 
      </td>
    </tr>
  </tbody>
</table>


**Note:** For `ocrd-tesserocr` the environment variable `TESSDATA_PREFIX` has
to be set to point to the directory where the used models are stored. (The
directory should at least contain the following models: `deu.traineddata`,
`eng.taineddata`, `osd.traineddata`)

## Post Correction (Optional)

### Step 14: Text aligning

This processor alignes texts from multiple OCR-engines in one PAGE.xml. 

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-align</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </tbody>
</table>

### Step 15: Post correction

This processor tries to optimize the recognized text. 

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cor-asv-ann-process</td>
      <td>{“textequiv_level”:”line”,”model_file”:”/path/to/model/model.h5”}</td>
      <td>Models can be found <a href="https://github.com/ASVLeipzig/cor-asv-ann-models">here</a></td>
    </tr>
    <tr>
      <td>ocrd-cis-post-correct.sh</td>
      <td>???</td>
      <td>Not tested yet!</td>
    </tr>
  </tbody>
</table>

## Analysis (Optional)

If Ground Truth data is available, the OCR can be analysed.

### Step 16: Analysis

This processor can be used to analyse the output of the OCR.

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-dinglehopper</td>
      <td>&nbsp;</td>
      <td>First input group should point to the ground truth.</td>
    </tr>
  </tbody>
</table>

# Recommendations

All processors, with the exception of those for post-correction, were tested on
selected pages of some prints from the 17th and 18th century.

The results vary quite a lot from page to page. In most cases, segmentation is a problem.

These recommendations may also work well for other prints of those centuries. 



## Best results for selected pages

The following workflow has produced best results for 'simple' pages (e.g. [this
page](https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/dda89351-7596-46eb-9736-593a5e9593d3/data/bagit/data/OCR-D-IMG/OCR-D-IMG_0004.tif))
without any  (CER ~1%).

| Step | Processor                 | Parameter                                         |
| ---- | ------------------------- | ------------------------------------------------- |
| 1    | ocrd-olena-binarize       | {"impl": "sauvola-ms-split"}                      |
| 2    | ocrd-cis-ocropy-denoise   | {"level-of-operation":"page"}                     |
| 3    | ocrd-anybaseocr-deskew    |                                                   |
| 6    | ocrd-cis-ocropy-segment   | {"level-of-operation":"page"}                 |
| 8    | ocrd-cis-ocropy-deskew    | {"level-of-operation":"region"}               |
| 9    | ocrd-cis-ocropy-clip      | {"level-of-operation":"region"}               |
| 10   | ocrd-cis-ocropy-segment   | {"level-of-operation":"region"}               |
| 11   | ocrd-cis-ocropy-resegment |                                                   |
| 12   | ocrd-cis-ocropy-dewarp    |                                                   |
| 13   | ocrd-calamari-recognize   | {"checkpoint":"/path/to/models/\*.ckpt.json"} |



## Good results for all pages

Overall the results are good for all kind of pages. 

| Step | Processor                 | Parameter                                         |
| ---- | ------------------------- | ------------------------------------------------- |
| 1    | ocrd-olena-binarize       | {"impl": "sauvola-ms-split"}                      |
| 2    | ocrd-cis-ocropy-denoise   | {"level-of-operation":"page"}                     |
| 3    | ocrd-anybaseocr-deskew    |                                                   |
| 6    | ocrd-cis-ocropy-segment   | {"level-of-operation":"page"}                 |
| 8    | ocrd-cis-ocropy-deskew    | {"level-of-operation":"region"}               |
| 9    | ocrd-cis-ocropy-clip      | {"level-of-operation":"region"}               |
| 10   | ocrd-cis-ocropy-segment   | {"level-of-operation":"region"}               |
| 11   | ocrd-cis-ocropy-resegment |                                                   |
| 12   | ocrd-cis-ocropy-dewarp    |                                                   |
| 13   | ocrd-calamari-recognize   | {"checkpoint":"/path/to/models/\*.ckpt.json"} |



## Good results for slower processors

If your computer is not that powerful you may try this workflow. It works fine for simple pages and produces also good results in shorter time.

| Step | Processor                     | Parameter                                                    |
| ---- | ----------------------------- | ------------------------------------------------------------ |
| 1    | ocrd-olena-binarize           | {"impl": "sauvola-ms-split"}                                 |
| 2    | ocrd-cis-ocropy-denoise       | {"level-of-operation":"page"}                                |
| 3    | ocrd-anybaseocr-deskew        |                                                              |
| 6    | ocrd-tesserocr-segment-region |                                                              |
| 8    | ocrd-cis-ocropy-deskew        | {"level-of-operation":"region"}                          |
| 10   | ocrd-cis-ocropy-segment       | {"level-of-operation":"region"}                          |
| 12   | ocrd-cis-ocropy-dewarp        |                                                              |
| 13   | ocrd-tesserocr-recognize      | {"textequiv_level":"glyph","overwrite_words":true,<br />"model":"GT4HistOCR_50000000.997_191951"} |

