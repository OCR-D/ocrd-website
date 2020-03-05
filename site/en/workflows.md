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


### Step 1: Binarization
First, all the images should be binarized. Many of the following processors require binarized images. Note that some segmentation algorithms seem to produce better results using the original image.

This processor takes a scanned colored /gray scale document image as input and produces a black and white binarized image. This step should separate the background from the foreground.

<table class="before-after">
  <tbody>
    <tr>
      <td>
        <a href="/assets/workflow/Original.png"><img src="/assets/workflow/Original.png"/></a>
      </td>
      <td>
        <a href="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png"><img src="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png"/></a>
      </td>
    </tr>
  </tbody>
</table>


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
      <td><code>ocrd-anybaseocr-binarize -I OCR-D-IMG -O OCR-D-BIN</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
      <td></td>
      <td><code>ocrd-cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-BIN</code></td>
    </tr>
    <tr>
      <td>ocrd-olena-binarize</td>
      <td>
      <p><code>
      {"impl": "sauvola"}
      </code></p>
      <p><code>
{"impl": "sauvola-ms"}
      </code></p>
      <p><code>
{"impl": "sauvola-ms-fg"}
      </code></p>
      <p><code>
{"impl": "sauvola-ms-split"}
      </code></p>
      <p><code>
{"impl": "kim"}
      </code></p>
      <p><code>
{"impl": "wolf"}
      </code></p>
      <p><code>
{"impl": "niblack"}
      </code></p>
      <p><code>
{"impl": "singh"}
      </code></p>
      <p><code>
{"impl": "otsu"}
      </code></p>
      </td>
      <td>Recommended</td>
      <td><code>ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN -p'{"impl": "sauvola"}'</code></td>
    </tr>
  </tbody>
</table>

### Step 2: Denoising

This processor removes artifacts from the binarized image. 

May not be necessary for all prints.


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
        <a href="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png"><img src="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/denoise.PNG"><img src="/assets/workflow/denoise.PNG" alt=""></a>
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
    <tr>
      <td>ocrd-cis-ocropy-denoise</td>
      <td><code>{“level-of-operation”:”page”}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-denoise -I OCR-D-BIN -O OCR-D-DENOISE</code></td>
    </tr>
  </tbody>
</table>

### Step 3: Deskewing

This processor takes a document image as input and does the skew correction of
that document. The input images have to be binarized for this module to work.


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
        <a href="/assets/workflow/denoise.PNG"><img src="/assets/workflow/denoise.PNG" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001.png" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-deskew</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-anybaseocr-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE</code></td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-deskew</td>
      <td><code>{"operation_level”:”page”}</code></td>
      <td>Fast</td>
	  <td><code>ocrd-tesserocr-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE -p'{"operation_level”:”page”}'</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>{“level-of-operation”:”page”}</code></td>
	  <td><code>ocrd-cis-ocropy-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE -p'{“level-of-operation”:”page”}'</code></td>
      <td>Recommended</td>
    </tr>
  </tbody>
</table>

### Step 4: Dewarping

This processor takes a document image as input and makes the text line straight if its curved. The input image has to be binarized for the module to work.


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
      <a href="/assets/workflow/OCR-D-IMG-TO-DEWARP_0005.png"><img src="/assets/workflow/OCR-D-IMG-TO-DEWARP_0005.png" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DEWARPEP_0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARPEP_0005.png" alt=""></a>
      </td>
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
      <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-dewarp</td>
      <td>
      <code>
      <pre>
{
  "pix2pixHD":"/path/to/pix2pixHD/",
  "model_name":"/path/to/pix2pixHD/models"
}
      </pre>
      </code>
      </td>
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Parameter <code>model_name</code> is missleading. Given directory has to contain a file named ‘latest_net_G.pth’ <br> <strong>GPU required!</strong></td>
      <td>
        <code>ocrd-anybaseocr-dewarp -I OCR-D-DESKEW-PAGE -O OCR-D-DEWARP-PAGE -p '{\"pix2pixHD\":\"/path/to/pix2pixHD/\",\"model_name\":\"/path/to/pix2pixHD/models\"}'</code>
      </td>
    </tr>
  </tbody>
</table>

### Step 5: Cropping

This processor takes a document image as input and crops/selects the page
content area only (i.e. it removes textual noise as well as any other noise
around the page content area).


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
        <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/OCR-D-IMG-CROP_0001.png"><img src="/assets/workflow/OCR-D-IMG-CROP_0001.png" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-crop</td>
      <td>&nbsp;</td>
      <td>The input image has to be binarized and <br>should be deskewed for the module to work.</td>
	  <td><code>ocrd-anybaseocr-crop -I OCR-D-DEWARP-PAGE -O OCR-D-CROP</code></td>
    </tr>
  </tbody>
</table>

## Layout Analysis

Now the image should be optimized for segmentation.

### Step 6: Text segmentation (page)

This processor takes an (optimized) document image as an input and segments the
image into the different text blocks. During this step a classification (text,
marginalia, image, ...) should also be done.


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
        <a href="/assets/workflow/OCR-D-IMG-CROP_0001.png"><img src="/assets/workflow/OCR-D-IMG-CROP_0001.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/seg-page.PNG"><img src="/assets/workflow/seg-page.PNG" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-segment-region</td>
      <td>&nbsp;</td>
      <td>Should also work for original images!?</td>
	  <td><code>ocrd-tesserocr-segment-region -I OCR-D-CROP -O OCR-D-SEG-REG</code></td>
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
	  <td><code>ocrd-anybaseocr-block-segmentation -I OCR-D-CROP -O OCR-D-SEG-REG -p '{"block_segmentation_model": "/path/to/mrcnn","block_segmentation_weights": "/path/to/model/block_segmentation_weights.h5"}'</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-segment</td>
      <td><code>{"level-of-operation":"page"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-segment -I OCR-D-CROP -O OCR-D-SEG-REG -p '{"level-of-operation":"page"}'</code></td>
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


#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-binarize</td>
      <td><code>{"operation_level":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-tesserocr-binarize -I OCR-D-SEG-REG -O OCR-D-BIN-REG -p '{"operation_level":"region"}'</code></td>
    </tr>
  </tbody>
</table>

### Step 8:  Deskewing 

This processor takes an image as input and does the skew correction for all text blocks.


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
      <a href="/assets/workflow/seg-page.PNG"><img src="/assets/workflow/seg-page.PNG" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocrd-anybaseocr-deskew -I OCR-D-BIN-REG -O OCR-D-DESKEW-REG -p '{"level-of-operation":"region"}'</code></td>
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

TODO: add images

#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-clip</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-clip -I OCR-D-DESKEW-REG -O OCR-D-CLIP-REG -p '{"level-of-operation":"region"}'</code></td>
    </tr>
  </tbody>
</table>

### Step 10: Line segmentation 

This processor can be used to segment regions into lines. It runs a (ad-hoc
binarization and) line segmentation on every text region of every PAGE in the
input file group, and adds a TextLine element with the resulting polygon
outline to the annotation of the output PAGE.


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
      <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-segment</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-segment -I OCR-D-CLIP-REG -O OCR-D-SEG-LINE -p '{"level-of-operation":"region"}'</code></td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-segment-line</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-tesserocr-segment-line -I OCR-D-CLIP-REG -O OCR-D-SEG-LINE</code></td>
    </tr>
  </tbody>
</table>

### Step 11:  Line correction 

This processor can be used to correct the segmented lines.

TODO: add images

#### Available processors
<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-ocropy-clip</td>
      <td><code>{"level-of-operation":"line"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-clip -I OCR-D-SEG-LINE -O OCR-D-CLIP-LINE -p '{"level-of-operation":"line"}'</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-resegment</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-resegment -I OCR-D-SEG-LINE -O OCR-D-RESEG</code></td>
    </tr>
    <tr>
      <td>ocrd-segment-repair</td>
      <td><code>{"sanitize":true}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-segment-repair -I OCR-D-SEG-LINE -O OCR-D-SEG-REPAIR -p '{"sanitize":true}'</code></td>
    </tr>
  </tbody>
</table>

### Step 12: Dewarping (on line level)

This processor can be used to dewarp the segmented lines.


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
      <a href="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-anybaseocr-dewarp</td>
      <td><code>{"operation_level":"line",<br>"pix2pixHD":"/path/to/pix2pixHD/",<br>"model_name":"/path/to/pix2pixHD/models"}</code></td>
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Parameter ‘model_name’ is missleading. Given directory has to contain a file named ‘latest_net_G.pth’ <br> <strong>GPU required!</strong></td>
	  <td><code>ocrd-anybaseocr-dewarp -I OCR-D-CLIP-LINE -O OCR-D-DEWARP-LINE -p '{"operation_level":"line","pix2pixHD":"/path/to/pix2pixHD/","model_name":"/path/to/pix2pixHD/models"}'</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-dewarp -I OCR-D-CLIP-LINE -O OCR-D-DEWARP-LINE</code></td>
    </tr>
  </tbody>
</table>

## Text Recognition and Optimization

### Step 13: Text recognition

This processor recognizes text in segmented lines.


#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-tesserocr-recognize</td>
      <td>
      <p>
      <code>
      {"textequiv_level": "glyph", "overwrite_words": true,"model": "Fraktur"}
      </code>
      </p>
      <p>
      <code>
      {"textequiv_level": "glyph", "overwrite_words": true, "model": "GT4HistOCR_50000000.997_191951"}
      </code>
      </p>
      </td>
      <td>Recommended <br/> Model can be found [here](https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/GT4HistOCR_50<br/>00000/tessdata_best/GT4HistOCR_50000000.997_191951.traineddata)</td>
	  <td><code>ocrd-tesserocr-recognize -I OCR-D-DEWARP-LINE -O OCR-D-OCR -p '{"model": "Fraktur"}'</code></td>
    </tr>
    <tr>
      <td>ocrd-calamari-recognize</td>
      <td>
        <code>
{"checkpoint":"/path/to/models/\*.ckpt.json"}
        </code>
      </td>
      <td>
        Recommended<br/>Model can be found [here](https://ocr-d-repo.scc.kit.edu/models/calamari/GT4HistOCR/model.tar.xz) 
      </td>
	  <td><code>ocrd-calamari-recognize -I OCR-D-DEWARP-LINE -O OCR-D-OCR -p '{"checkpoint": "Fraktur"}'</code></td>
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


#### Available processors

<table>
  <thead>
    <tr>
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remarks</th>
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cis-align</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-align -I OCR-D-OCR1,OCR-D-OCR2 -O OCR-D-ALIGN</code></td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-cor-asv-ann-process</td>
      <td><code>{“textequiv_level”:”line”,”model_file”:”/path/to/model/model.h5”}</code></td>
      <td>Models can be found <a href="https://github.com/ASVLeipzig/cor-asv-ann-models">here</a></td>
	  <td><code>ocrd-cor-asv-ann-process -I OCR-D-ALIGN -O OCR-D-PROCESS -p '{“textequiv_level”:”line”,”model_file”:”/path/to/model/model.h5”}'</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-post-correct.sh</td>
      <td>???</td>
      <td>Not tested yet!</td>
	  <td><code>ocrd-cis-post-correct.sh -I OCR-D-ALIGN -O OCR-D-CORRECT</code></td>
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
	  <th>Call</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>ocrd-dinglehopper</td>
      <td>&nbsp;</td>
      <td>First input group should point to the ground truth.</td>
	  <td><code>ocrd-dinglehopper -I OCR-D-GT,OCR-D-OCR -O OCR-D-EVAL</code></td>
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

<table>
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
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "sauvola-ms-split"}</td>
    </tr>
    <tr>
      <td>2</td>
      <td>ocrd-cis-ocropy-denoise</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-anybaseocr-deskew</td>
      <td></td>
    </tr>
	<tr>
      <td>5</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>6</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>8</td>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>9</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-cis-ocropy-resegment</td>
      <td></td>
    </tr>
    <tr>
      <td>12</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-calamari-recognize</td>
      <td>{"checkpoint":"/path/to/models/\*.ckpt.json"}</td>
    </tr>
  </tbody> 
</table>

### Example with ocrd-process

```sh
ocrd process \
  "olena-binarize -I OCR-D-IMG -O OCR-D-BIN -p '{\"impl\": \"sauvola-ms-split\"}'" \
  "cis-ocropy-denoise -I OCR-D-BIN -O OCR-D-BIN-DENOISE -p '{\"level-of-operation\":\"page\"}'" \
  "anybaseocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW" \
  "anybaseocr-crop -I OCR-D-BIN-DENOISE-DESKEW -I OCR-D-CROP" \
  "cis-ocropy-segment -I OCR-D-CROP -O OCR-D-SEG-REG -p '{\"level-of-operation\":\"page\"}'" \
  "cis-ocropy-deskew -I OCR-D-SEG-REG -O OCR-D-SEG-REG-DESKEW -p '{\"level-of-operation\":\"region\"}'" \
  "cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP -p '{\"level-of-operation\":\"region\"}'" \
  "cis-ocropy-segment -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE -p '{\"level-of-operation\":\"region\"}'" \
  "cis-ocropy-resegment -I OCR-D-SEG-LINE -O OCR-D-SEG-LINE-RESEG" \
  "cis-ocropy-dewarp -I OCR-D-SEG-LINE-RESEG -O OCR-D-SEG-LINE-RESEG-DEWARP" \
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -p '{\"checkpoint\":\"/path/to/models/*.ckpt.json\"}'"
```



## Good results for all pages

Overall the results are good for all kind of pages. 

<table>
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
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "sauvola-ms-split"}</td>
    </tr>
    <tr>
      <td>2</td>
      <td>ocrd-cis-ocropy-denoise</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-anybaseocr-deskew</td>
      <td></td>
    </tr>
	<tr>
      <td>5</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>6</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-tesserocr-segment-line</td>
      <td></td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"line"}</td>
    </tr>
    <tr>
      <td>12</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-tesserocr-recognize</td>
      <td>{"textequiv_level":"glyph",<br/>"overwrite_words":true,<br/>
        "model":"GT4HistOCR_50000000.997_191951"}</td>
    </tr>
  </tbody>
</table>

### Example with ocrd-process

```sh
ocrd process \
  "olena-binarize -I OCR-D-IMG -O OCR-D-BIN -p '{\"impl\": \"sauvola-ms-split\"}'" \
  "cis-ocropy-denoise -I OCR-D-BIN -O OCR-D-BIN-DENOISE -p '{\"level-of-operation\":\"page\"}'" \
  "anybaseocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW" \
  "anybaseocr-crop -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-CROP" \
  "cis-ocropy-segment -I OCR-D-CROP -O OCR-D-SEG-REG -p '{\"level-of-operation\":\"page\"}'" \
  "tesserocr-segment-line -I OCR-D-SEG-REG -O OCR-D-SEG-LINE" \
  "cis-ocropy-clip -I OCR-D-SEG-LINE -O OCR-D-SEG-LINE-CLIP -p '{\"level-of-operation\":\"line\"}'" \
  "cis-ocropy-dewarp -I OCR-D-SEG-LINE-CLIP -O OCR-D-SEG-LINE-CLIP-DEWARP" \
  "tesserocr-recognize -I OCR-D-SEG-LINE-CLIP-DEWARP -O OCR-D-OCR -p '{\"textequiv_level\":\"glyph\",\"overwrite_words\":true,\"model\":\"GT4HistOCR_50000000.997_191951\"}'"
```



## Good results for slower processors

If your computer is not that powerful you may try this workflow. It works fine for simple pages and produces also good results in shorter time.

<table>
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
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "sauvola-ms-split"}</td>
    </tr>
    <tr>
      <td>2</td>
      <td>ocrd-cis-ocropy-denoise</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-anybaseocr-deskew</td>
      <td></td>
    </tr>
	<tr>
      <td>5</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>6</td>
      <td>ocrd-tesserocr-segment-region</td>
      <td></td>
    </tr>
    <tr>
      <td>8</td>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>12</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-tesserocr-recognize</td>
      <td>{"textequiv_level":"glyph",<br/>"overwrite_words":true,<br/>
        "model":"GT4HistOCR_50000000.997_191951"}</td>
    </tr>
  </tbody> 
</table>

### Example with ocrd-process

```sh
ocrd process \
  "olena-binarize -I OCR-D-IMG -O OCR-D-BIN -p '{\"impl\": \"sauvola-ms-split\"}'" \
  "cis-ocropy-denoise -I OCR-D-BIN -O OCR-D-BIN-DENOISE -p '{\"level-of-operation\":\"page\"}'" \
  "anybaseocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-DESKEW-PAGE" \
  "anybaseocr-crop -I OCR-D-DESKEW-PAGE -O OCR-D-CROP" \
  "tesserocr-segment-region -I OCR-D-CROP -O OCR-D-SEG-REG" \
  "cis-ocropy-deskew -I OCR-D-SEG-REG -O OCR-D-SEG-REG-DESKEW -p '{\"level-of-operation\":\"region\"}'" \
  "cis-ocropy-segment -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-LINE -p '{\"level-of-operation\":\"region\"}'" \
  "cis-ocropy-dewarp -I OCR-D-SEG-LINE -O OCR-D-SEG-LINE-DEWARP" \
  "tesserocr-recognize -I OCR-D-SEG-LINE-DEWARP -O OCR-D-OCR -p '{\"textequiv_level\":\"glyph\",\"overwrite_words\":true,\"model\":\"GT4HistOCR_50000000.997_191951\"}'"
```
