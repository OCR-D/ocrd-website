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

![](/assets/Funktionsmodell.png)

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
Optionally, you can start off your workflow by enhancing your images, which can be vital for the following binarization. In this processing step,
the raw image is taken and enhanced by e.g. grayscale conversion, brightness normalization, noise filtering, etc.  

**Note:** `ocrd-preprocess-image` can be used to run arbitrary shell commands for preprocessing (original or derived) images, and can be seen as a generic OCR-D wrapper for many of the following workflow steps, provided a matching external tool exists. (The only restriction is that the tool must not change image size or the position/coordinates of its content.)

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
    <tr>
      <td>ocrd-im6convert</td>
      <td>
      <p><code><pre>
{
  "output-format": "image/tiff" # or "image/jp2", "image/png"...
}
      </pre></code></p>
      </td>
      <td>for <code>output-options</code> see <a href="https://imagemagick.org/script/command-line-options.php">IM Documentation</a></td>
      <td><code>ocrd-im6convert -I OCR-D-IMG -O OCR-D-ENH -P output-format image/tiff</code></td>
    </tr>
    <tr>
      <td>ocrd-preprocess-image</td>
      <td>
      <p><code><pre>{
  "input_feature_filter": "binarized",
  "output_feature_added": "binarized",
  "command": "scribo-cli sauvola-ms-split '@INFILE' '@OUTFILE' --enable-negate-output"
  }</pre></code></p>
	  </td>
      <td>
	  for parameters and command examples (presets) see [the Readme](https://github.com/bertsky/ocrd_wrap#ocr-d-processor-interface-ocrd-preprocess-image)
	  </td>
      <td><code>
	  ocrd-preprocess-image -I OCR-D-IMG -O OCR-D-PREP -P output_feature_added binarized -P command "scribo-cli sauvola-ms-split @INFILE @OUTFILE --enable-negate-output"
	  </code></td>
    </tr>
    <tr>
      <td>ocrd-skimage-normalize</td>
      <td>
	  </td>
      <td>
	  </td>
      <td><code>
	  ocrd-skimage-normalize -I OCR-D-IMG -O OCR-D-NORM
	  </code></td>
    </tr>
	<tr>
      <td>ocrd-skimage-denoise-raw</td>
      <td>
	  </td>
      <td>
	  </td>
      <td><code>
	  ocrd-skimage-denoise-raw -I OCR-D-IMG -O OCR-D-DENOISE
	  </code></td>
    </tr>
  </tbody>
</table>

### Step 1: Binarization (Page Level)

All the images should be binarized right at the beginning of your workflow.
Many of the following processors require binarized images. Some implementations
(for deskewing, segmentation or recognition) may produce better results using
the original image. But these can always retrieve the raw image instead of the
binarized version automatically.

In this processing step, a scanned colored /gray scale document image is taken
as input and a black and white binarized image is produced. This step should
separate the background from the foreground.

**Note:** Binarization tools usually provide a threshold parameter which allows
you to increase or decrease the weight of the foreground. This is optional and
can be especially useful for images which have not been enhanced.

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
      <th>Processor</th>
      <th>Parameter</th>
      <th>Remark</th>
      <th>Call</th>
	</tr>
  </thead>
  <tbody>   
    <tr>
      <td>ocrd-olena-binarize
      </td>
      <td>
      </td>
      <td>Recommended</td>
      <td><code><div class="native-call">ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN</div>
	  <div class="Docker-call">docker run --user $(id -u) --volume $PWD:/data ocrd/all:maximum ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN</div>
	  </code></td>
    </tr>
	<tr>
		<td><details>
      <summary><i>see all parameters</i></summary>
		<table>
		<tbody>
		<tr>
		<td>
		<p><code>
		{"k": float}
		</code></p>
		</td>
		<td>used to adjust the foreground weight; only relevant to the Sauvola algos</td>
		</tr>
		<tr>
		<td>
		<p><code>
		{"impl": "sauvola"}
		</code></p>
		</td>
		<td></td>
		</tr>
		</table>
		</details>
		</td>
	</tr>
	<tr>
      <td>ocrd-cis-ocropy-binarize</td>
      <td>
	  <p><code>
{"threshold": float}
      </code></p>	  
	  </td>
      <td></td>
      <td><code>ocrd-cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-BIN</code></td>
    </tr>
	<tr>
      <td>ocrd-skimage-binarize</td>
      <td>
	  </td>
      <td>
	  </td>  
      <td><code>ocrd-skimage-binarize -I OCR-D-IMG -O OCR-D-BIN</code></td>
	</tr>	
	  <td>ocrd-anybaseocr-binarize</td>
      <td>
	  <p><code>
{"threshold": float}
      </code></p>
	  </td>
      <td>Fast</td>
      <td><code>ocrd-anybaseocr-binarize -I OCR-D-IMG -O OCR-D-BIN</code></td>
    </tr>
  </tbody>
</table>


### Step 2: Cropping (Page Level)

In this processing step, a document image is taken as input and the page
is cropped to the content area only (i.e. without noise at the margins or facing pages) by marking the coordinates of the page frame.
We strongly recommend to execute this step if your images are not cropped already (i.e. only show the page of a book without a ruler, 
footer, color scale etc.). Otherwise you might run into severe segmentation problems. 


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
        <a href="/assets/workflow/denoised.png"><img src="/assets/workflow/denoised.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/OCR-D-IMG-CROP_0001.png"><img src="/assets/workflow/OCR-D-IMG-CROP_0001.png" alt=""></a>
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
      <td>ocrd-anybaseocr-crop</td>
      <td>&nbsp;</td>
      <td>The input image has to be binarized and <br>should be deskewed for the module to work.</td>
	  <td><code>ocrd-anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP</code></td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-crop</td>
      <td>&nbsp;</td>
      <td></td>
	  <td><code>ocrd-tesserocr-crop -I OCR-D-BIN -O OCR-D-CROP</code></td>
    </tr>
  </tbody>
</table>

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
    <tr>
      <td>ocrd-olena-binarize</td>
      <td>
      </td>
      <td>Recommended</td>
      <td><code>ocrd-olena-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
	<tr>
      <td>ocrd-skimage-binarize</td>
      <td>
	  </td>
      <td>
	  </td>
      <td><code>ocrd-skimage-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
	<tr>
      <td>ocrd-cis-ocropy-binarize</td>
      <td></td>
      <td></td>
      <td><code>ocrd-cis-ocropy-binarize -I OCR-D-CROP -O OCR-D-BIN2</code></td>
    </tr>
  </tbody>
</table>


### Step 4: Denoising (Page Level)

In this processing step, artifacts like little specks (both in foreground or background) are removed from the binarized image. 

This may not be necessary for all prints, and depends heavily on the selected binarization algorithm.


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
        <a href="/assets/workflow/OCR-D-BIN_0001-BIN_sauvola.png"><img src="/assets/workflow/OCR-D-IMG-CROP-ALTERNATE_0009.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/denoise.PNG"><img src="/assets/workflow/OCR-D-IMG-DENOISE-ALTERNATE_0009.png" alt=""></a>
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
      <td><code></code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-denoise -I OCR-D-BIN2 -O OCR-D-DENOISE</code></td>
    </tr>
	<tr>
      <td>ocrd-skimage-denoise</td>
      <td></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-skimage-denoise -I OCR-D-BIN2 -O OCR-D-DENOISE</code></td>
    </tr>
  </tbody>
</table>

### Step 5: Deskewing (Page Level)

In this processing step, a document image is taken as input and the skew of
that page is corrected by annotating the detected angle (-45° .. 45°) and rotating the image. Optionally, also the orientation is corrected by annotating the detected angle (multiples of 90°) and transposing the image.
The input images have to be binarized for this module to work.

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
        <a href="/assets/workflow/OCR-D-IMG-DESPECK_0001.png"><img src="/assets/workflow/OCR-D-IMG-DESPECK_0001.png" alt=""></a>
      </td>
      <td>
        <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001.png" alt=""></a>
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
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>{"level-of-operation": "page"}</code></td>
      <td>Recommended</td>
	  <td><code>ocrd-cis-ocropy-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE -P level-of-operation page</code></td>
    </tr>    
	<tr>
      <td>ocrd-tesserocr-deskew</td>
      <td><code>{"operation_level”:”page”}</code></td>
      <td>Fast, also performs a decent orientation correction</td>
	  <td><code>ocrd-tesserocr-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE -P operation_level page</code></td>
    </tr>
    <tr>
      <td>ocrd-anybaseocr-deskew</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-anybaseocr-deskew -I OCR-D-DENOISE -O OCR-D-DESKEW-PAGE</code></td>
    </tr>	
  </tbody>
</table>

### Step 6: Dewarping (Page Level)

In this processing step, a document image is taken as input and the text lines are straightened or stretched
if they are curved. The input image has to be binarized for the module to work.


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
      <td>For available models take a look at this <a href="https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models">site</a> <br> Parameter <code>model_name</code> is misleading. Given directory has to contain a file named ‘latest_net_G.pth’ <br> <strong>GPU required!</strong></td>
      <td>
        <code>ocrd-anybaseocr-dewarp -I OCR-D-DESKEW-PAGE -O OCR-D-DEWARP-PAGE -p '{\"pix2pixHD\":\"/path/to/pix2pixHD/\",\"model_name\":\"/path/to/pix2pixHD/models\"}'</code>
      </td>
    </tr>
  </tbody>
</table>


## Layout Analysis

By now the image should be well prepared for segmentation.

### Step 7: Region segmentation

In this processing step, an (optimized) document image is taken as an input and the
image is segmented into the various regions, including columns.
Segments are also classified, either coarse (text, separator, image, table, ...) or fine-grained (paragraph, marginalia, heading, ...).

**Note:** If you use `ocrd-tesserocr-segment-region`, which uses only bounding boxes instead of polygon coordinates, 
then you should post-process via `ocrd-segment-repair` with `plausibilize=True` to obtain better results without large overlaps.

**Note:** The `ocrd-sbb-textline-detector` and `ocrd-cis-ocropy-segment` processors do not only segment the page, but also the text lines within
the detected text regions in one step. Therefore with those (and only with those!) processors you don't
need to segment into lines in an extra step.


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
      <td>ocrd-tesserocr-segment-region</td>
      <td>&nbsp;</td>
      <td>Recommended</td>
	  <td><code>ocrd-tesserocr-segment-region -I OCR-D-DEWARP-PAGE -O OCR-D-SEG-REG</code></td>
    </tr>
	<tr>
      <td>ocrd-segment-repair</td>
      <td><code>{"plausibilize":true}</code></td>
      <td>Only to be used after `ocrd-tesserocr-segment-region`</td>
	  <td><code>ocrd-segment-repair -I OCR-D-SEG-REG -O OCR-D-SEG-REPAIR -P plausibilize true</code></td>
    </tr>
    <tr>
      <td>ocrd-sbb-textline-detector</td>
      <td>{"model": /path/to/model"}</td>
      <td>Models can be found [here](https://qurator-data.de/sbb_textline_detector/); you need to **pass your local path to the model on your hard drive**
	  as parameter value for this processor to work!</td>
	  <td><code>ocrd-sbb-textline-detector -I OCR-D-DEWARP-PAGE -O OCR-D-SEG-LINE -P model /path/to/model</code></td>
    </tr>
	<tr>
      <td>ocrd-cis-ocropy-segment</td>
      <td><code>{"level-of-operation":"page"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-segment -I OCR-D-DEWARP-PAGE -O OCR-D-SEG-LINE -P level-of-operation page</code></td>
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
      <td>For available models take a look at this <a href="https://github.com/OCR-D/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models"; you need to **pass your local path to the model on your hard drive**
	  as parameter value for this processor to work!>site</a></td>
	  <td><code>ocrd-anybaseocr-block-segmentation -I OCR-D-DEWARP-PAGE -O OCR-D-SEG-REG -P block_segmentation_model /path/to/mrcnn -P block_segmentation_weights /path/to/model/block_segmentation_weights.h5</code></td>
    </tr>
	<tr>
      <td>ocrd-pc-segmentation</td>
      <td>
      </td>
      <td>
	  </td>
	  <td><code>ocrd-pc-segmentation -I OCR-D-DEWARP-PAGE -O OCR-D-SEG-REG</code></td>
    </tr>
  </tbody>
</table>

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
    <tr>
      <td>ocrd-skimage-binarize</td>
      <td>
	  <p><code>
{"level-of-operation": "region"}
      </code></p>	
	  </td>
      <td>
	  </td>
	  <td><code>ocrd-skimage-binarize -I OCR-D-SEG-REG -O OCR-D-BIN-REG -P level-of-operation region</code></td>
    </tr>    
	<tr>
      <td>ocrd-preprocess-image</td>
      <td><code>{"level-of-operation":"region","output_feature_added": "binarized","command": "scribo-cli sauvola-ms-split '@INFILE' '@OUTFILE' --enable-negate-output"}</code></td>
      <td>&nbsp;</td>
	  <td><code>
	  ocrd-preprocess-image -I OCR-D-SEG-REG -O OCR-D-BIN-REG -P level-of-operation region -P output_feature_added binarized -P command "scribo-cli sauvola-ms-split @INFILE @OUTFILE --enable-negate-output"
	  </code></td>
	  </td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-binarize</td>
      <td>
	  <p><code>
{"level-of-operation": "region", "noise_maxsize": float}
      </code></p>	  
	  </td>
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
      <a href="/assets/workflow/seg-page.PNG"><img src="/assets/workflow/seg-page.PNG" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png"><img src="/assets/workflow/OCR-D-IMG-DESKEW_0001_region0002.png" alt=""></a>
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
      <td>ocrd-cis-ocropy-deskew</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-deskew -I OCR-D-BIN-REG -O OCR-D-DESKEW-REG -P level-of-operation region</code></td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-deskew</td>
      <td>&nbsp;</td>
      <td>Fast, also performs a decent orientation correction</td>
	  <td><code>ocrd-tesserocr-deskew -I OCR-D-BIN-REG -O OCR-D-DESKEW-REG</code></td>
    </tr>	
  </tbody>
</table>

### Step 10:  Clipping (Region Level)

In this processing step, intrusions of neighbouring non-text (e.g. separator) or text segments (e.g. ascenders/descenders) into
text regions of a page can be removed. A connected component analysis is run on every text region,
as well as its overlapping neighbours. Now for each conflicting binary object,
a rule based on majority and proper containment determines whether it belongs to the neighbour, and can therefore
be clipped to the background. 

This basic text-nontext segmentation ensures that for each text region there is a clean image without interference from separators and neighbouring texts. (Cleaning via coordinates would be impossible in many common cases.)

TODO: add images

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
      <td>ocrd-cis-ocropy-clip</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-clip -I OCR-D-DESKEW-REG -O OCR-D-CLIP-REG -P level-of-operation region</code></td>
    </tr>
  </tbody>
</table>

### Step 11: Line segmentation 

In this processing step, text regions are segmented into text lines. 
A line detection algorithm is run on every text region of every PAGE in the
input file group, and a TextLine element with the resulting polygon
outline is added to the annotation of the output PAGE.

**Note:** If you use `ocrd-tesserocr-segment-line`, which uses only bounding boxes instead of polygon coordinates, 
then you should post-process with the processors described in [Step 12](#step-12-resegmentation-line-level). 
If you use `ocrd-cis-ocropy-segment`, you can directly go on with [Step 13](#step-13-dewarping-on-line-level).

**Note:** As described in [Step 7](#step-7-page-segmentation), `ocrd-sbb-textline-detector` and `ocrd-cis-ocropy-segment` do not only segment 
the page, but also the text lines within the detected text regions in one step. Therefore with those (and only with those!) processors you don’t
need to segment into lines in an extra step.

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
      <td>ocrd-cis-ocropy-segment</td>
      <td><code>{"level-of-operation":"region"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-segment -I OCR-D-CLIP-REG -O OCR-D-SEG-LINE -P level-of-operation region</code></td>
    </tr>
    <tr>
      <td>ocrd-tesserocr-segment-line</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-tesserocr-segment-line -I OCR-D-CLIP-REG -O OCR-D-SEG-LINE</code></td>
    </tr>
  </tbody>
</table>

### Step 12: Resegmentation (Line Level) 

In this processing step the segmented lines can be corrected.

TODO: add images

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
      <td>ocrd-cis-ocropy-clip</td>
      <td><code>{"level-of-operation":"line"}</code></td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-clip -I OCR-D-SEG-LINE -O OCR-D-CLIP-LINE -P level-of-operation line</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-ocropy-resegment</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-resegment -I OCR-D-SEG-LINE -O OCR-D-RESEG</code></td>
    </tr>
  </tbody>
</table>

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
      <a href="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
      </td>
      <td>
      <a href="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png"><img src="/assets/workflow/OCR-D-IMG-DEWARP_0001_region0002_region0002_line0005.png" alt=""></a>
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
      <td>ocrd-cis-ocropy-dewarp</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-ocropy-dewarp -I OCR-D-CLIP-LINE -O OCR-D-DEWARP-LINE</code></td>
    </tr>
  </tbody>
</table>

## Text Recognition

### Step 14: Text recognition

This processor recognizes text in segmented lines.

An overview on the existing model repositories and short descriptions on the most important models can be found [here](https://ocr-d.de/en/models).

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
      <td>ocrd-tesserocr-recognize</td>
      <td>
      <p>
      <code>
      {"model": "Fraktur"}
      </code>
      </p>
      <p>
      <code>
      {"model": "GT4HistOCR_50000000.997_191951"}
      </code>
      </p>
      </td>
      <td>Recommended <br/> Model can be found <a href="https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/Fraktur_5000000/">here</a><br/>/tessdata_best/GT4HistOCR_50000000.997_191951.traineddata)</td>
	  <td><code>TESSDATA_PREFIX="/test/data/tesseractmodels/" ocrd-tesserocr-recognize -I OCR-D-DEWARP-LINE -O OCR-D-OCR -P model Fraktur</code></td>
    </tr>
    <tr>
      <td>ocrd-calamari-recognize</td>
      <td>
        <code>
{"checkpoint":"/path/to/models/\*.ckpt.json"}
        </code>
      </td>
      <td>
        Recommended<br/>Model can be found <a href="https://ocr-d-repo.scc.kit.edu/models/calamari/GT4HistOCR/model.tar.xz">here</a>; you need 
		to **pass your local path to the model on your hard drive** as parameter value for this processor to work! 
      </td>
	  <td><code>ocrd-calamari-recognize -I OCR-D-DEWARP-LINE -O OCR-D-OCR -P checkpoint /path/to/models/\*.ckpt.json</code></td>
    </tr>
  </tbody>
</table>


**Note:** For `ocrd-tesserocr` the environment variable `TESSDATA_PREFIX` has
to be set to point to the directory where the used models are stored. (The
directory should at least contain the following models: `deu.traineddata`,
`eng.taineddata`, `osd.traineddata`)


**Note:** If you want to go on with the optional post correction, you should also set the `textequiv_level` to `glyph` or in the case of 
`ocrd-calamari-recognize` at least `word` (which is already the default for `ocrd-tesserocr-recognize`). 

## Post Correction (Optional)

### Step 15: Text alignment

In this processing step, text results from multiple OCR engines (in different annotations sharing the same line segmentation) are aligned 
into one annotation with `TextEquiv` alternatives.

**Note:** This step is only required if you want to do post-correction afterwards,
feeding alternative character hypotheses from several OCR-engines to improve the search space.
The previous recognition step must be run on glyph or at least on word level.


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
      <td>ocrd-cis-align</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-cis-align -I OCR-D-OCR1,OCR-D-OCR2 -O OCR-D-ALIGN</code></td>
    </tr>
  </tbody>
</table>

### Step 16: Post-correction

In this processing step, the recognized text is corrected by statistical error modelling, language modelling, and word modelling (dictionaries, 
morphology and orthography).

**Note:** Most tools benefit strongly from input which includes alternative OCR hypotheses. Currently, models for `ocrd-cor-asv-ann-process`
are optimised for input from single OCR engines, whereas `ocrd-cis-postcorrect` expects input from multi-OCR alignment.


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
      <td>ocrd-cor-asv-ann-process</td>
      <td><code>{"textequiv_level":"word","model_file":"/path/to/model/model.h5"}</code></td>
      <td>Models can be found <a href="https://github.com/ASVLeipzig/cor-asv-ann-models">here</a>; you need to **pass your local path to the model on your hard drive**
	  as parameter value for this processor to work!</td>
	  <td><code>ocrd-cor-asv-ann-process -I OCR-D-OCR -O OCR-D-PROCESS -P textequiv_level word -P model_file /path/to/model/model.h5</code></td>
    </tr>
    <tr>
      <td>ocrd-cis-postcorrect</td>
      <td><code>
	  {"profilerPath": "/path/to/profiler.bash","profilerConfig": str,"nOCR": int,"model": "/path/to/model/model.zip"}
	  </code></td>
      <td>
	  The various parameters should be specified in a JSON file. If you don't want to use a profiler, you can set the value for "profilerConfig" to 
	  "ignored". In this case, your profiler.bash should look like this: 
	  `#!/bin/bash
	  cat > /dev/null
	  echo '{}'`
	  you need to **pass your local path to the model on your hard drive** as parameter value for this processor to work!
	  </td>
	  <td><code>ocrd-cis-postcorrect -I OCR-D-ALIGN -O OCR-D-CORRECT -p postcorrect.json</code></td>
    </tr>
  </tbody>
</table>

## Evaluation (Optional)

If Ground Truth data is available, the OCR can be evaluated.

### Step 17: OCR Evaluation

In this processing step, the text output of the OCR or post-correction can be evaluated by aligning with ground truth text and measuring the error rates.

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
      <td>ocrd-dinglehopper</td>
      <td>&nbsp;</td>
      <td>First input group should point to the ground truth.</td>
	  <td><code>ocrd-dinglehopper -I OCR-D-GT,OCR-D-OCR -O OCR-D-EVAL</code></td>
    </tr>
	<tr>
      <td>ocrd-cor-asv-ann-evaluate</td>
      <td>
      <p>
      <code>
      {"metric": "Levenshtein" (default), "NFC", "NFKC", "historic-latin"}
      </code>
      <code>
      {"confusion": integer}
      </code>
      </p>	  
	  </td>
      <td>First input group should point to the ground truth. There is no output file group, it only uses logging. If you want to save the evaluation findings in a file, you could e.g. add `2> eval.txt` at the end of your command</td>
	  <td><code>ocrd-cor-asv-ann-evaluate -I OCR-D-GT,OCR-D-OCR</code></td>
    </tr>
  </tbody>
</table>

## Generic Data Management (Optional)

OCR-D produces PAGE XML files which contain the recognized text as well as detailed
information on the structure of the processed pages, the coordinates of the recognized
elements etc. Optionally, the output can be converted to other formats, or copied verbatim (re-generating PAGE-XML)

### Step 18: Adaptation of Coordinates

All OCR-D processors are required to relate coordinates to the original image for each page, and to keep the original image reference (`Page/@imageFilename`). However, sometimes it may be necessary to deviate from that strict requirement in order to get the overall workflow to work. 

For example, if you have a page-level dewarping step, it is currently impossible to correctly relate to the original image's coordinates for any segments annotated after that, because there is no descriptive annotation of the underlying coordinate transform in PAGE-XML. Therefore, it is better to _replace the original image_ of the output PAGE-XML by the dewarped image before proceeding with the workflow. If the dewarped image has also been cropped or deskewed, then of course all existing coordinates are re-calculated accordingly as well.

Another use case is exporting PAGE-XML for tools that cannot apply cropping or deskewing, like [LAREX](https://github.com/OCR4all/LAREX) or Transkribus.

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
      <td>ocrd-segment-replace-original</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
	  <td><code>ocrd-segment-replace-original -I OCR-D-SEG-LINE -O OCR-D-SUBST</code></td>
    </tr>
  </tbody>
</table>

### Step 19: Format Conversion

In this processing step the produced PAGE XML files can be converted to ALTO,
PDF, hOCR or text files. Note that ALTO and hOCR can also be converted into
different formats whereas the PDF version of PAGE XML OCR results is a widely
accessible format that can be used as-is by expert and layman alike.

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
      <td>ocrd-fileformat-transform</td>
      <td><code><pre>
        {"from-to": "alto2.0 alto3.0"} 
        # or {from-to: "alto2.0 alto3.1"}
        # or {from-to: "alto2.0 hocr"}
        # or {from-to: "alto2.1 alto3.0"}
        # or {from-to: "alto2.1 alto3.1"}
        # or {from-to: "alto2.1 hocr"}
        # or {from-to: "alto page"}
        # or {from-to: "alto text"}
        # or {from-to: "gcv hocr"}
        # or {from-to: "hocr alto2.0"}
        # or {from-to: "hocr alto2.1"}
        # or {from-to: "hocr text"}
        # or {from-to: "page alto"}
        # or {from-to: "page hocr"}
        # or {from-to: "page text"}
      </pre></code>
      </td>
      <td>as the values consist of two words, when using `-P` they have to be enclosed in quotation marks; e.g. -P from-to "alto2.0 alto3.0"<br/>
	  if you want to save all OCR results in one file, you can use the following command: `cat OCR* > full.txt`
	  </td>
      <td><code>ocrd-fileformat-transform -I OCR-D-OCR -O OCR-D-ALTO</code></td>
    </tr>
    <tr>
      <td>ocrd-pagetopdf</td>
      <td><code><pre>
      {
        # fix (invalid) negative coordinates
        "negative2zero": true,
        # create a single "fat" PDF
        "multipage": "name_of_pdf",
        # render text on this level
        "textequiv_level": "word",
        # draw polygon outlines in the PDF
        "outlines": "line"
      }
      </pre></code>
      </td>
      <td>&nbsp;</td>
      <td><code>ocrd-pagetopdf -I OCR-D-OCR -O OCR-D-PDF -P textequiv_level word</code></td>
    </tr>

</tbody>
</table>

### Step 20: Archiving
After you have successfully processed your images, the results should be saved and archived. OLA-HD is
a longterm archive system which works as a mixture between an archive system and a repository. For further
details on OLA-HD see the extensive [concept paper](https://github.com/subugoe/OLA-HD-IMPL/blob/master/docs/OLA-HD_Konzept.pdf).
You can also check out the [prototype](http://141.5.98.232/) to make sure, OLA-HD meets your needs and requirements. 

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
      <td>ocrd-olahd-client</td>
      <td>{
  "endpoint": "http://141.5.98.232/api",
  "username": "X",
  "password": "*"
}</td>
      <td>the parameters should be written to a json file:<br/>
	  echo '{  "endpoint": "http://141.5.98.232/api",
  "username": "X",
  "password": "*"}' > olahd.json
	  </td>
	  <td><code>ocrd-olahd-client -I OCR-D-OCR -p olahd.json</code></td>
    </tr>
  </tbody>
</table>

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
    <tr>
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
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "sauvola"}</td>
    </tr>
	<tr>
      <td>2</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "kim"}</td>
    </tr>
    <tr>
      <td>4</td>
      <td>ocrd-cis-ocropy-denoise</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>5</td>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>7</td>
      <td>ocrd-tesserocr-segment-region</td>
      <td></td>
    </tr>
    <tr>  
	  <td>7a</td>
      <td>ocrd-segment-repair</td>
      <td>{"plausibilize": true}</td>
    </tr>
    <tr>
      <td>9</td>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-cis-ocropy-segment</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>  
	  <td>11a</td>
      <td>ocrd-segment-repair</td>
      <td>{"sanitize": true}</td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>14</td>
      <td>ocrd-calamari-recognize</td>
      <td>{"checkpoint":"/path/to/models/\*.ckpt.json"}</td>
    </tr>
  </tbody> 
</table>

### Example with ocrd-process

```sh
ocrd process \
  "olena-binarize -I OCR-D-IMG -O OCR-D-BIN -P impl sauvola" \
  "anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP" \
  "olena-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P impl kim" \
  "cis-ocropy-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page" \
  "cis-ocropy-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P level-of-operation page" \
  "tesserocr-segment-region -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG-REG" \
  "segment-repair -I OCR-D-SEG-REG -O OCR-D-SEG-REPAIR -P plausibilize true" \
  "cis-ocropy-deskew -I OCR-D-SEG-REPAIR -O OCR-D-SEG-REG-DESKEW -P level-of-operation region" \
  "cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP -P level-of-operation region" \
  "cis-ocropy-segment -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE -P level-of-operation region" \
  "segment-repair -I OCR-D-SEG-LINE -O OCR-D-SEG-REPAIR-LINE -P sanitize true" \
  "cis-ocropy-dewarp -I OCR-D-SEG-REPAIR-LINE -O OCR-D-SEG-LINE-RESEG-DEWARP" \
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
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "sauvola"}</td>
    </tr>
	<tr>
      <td>2</td>
      <td>ocrd-anybaseocr-crop</td>
      <td></td>
    </tr>
    <tr>
      <td>3</td>
      <td>ocrd-olena-binarize</td>
      <td>{"impl": "kim"}</td>
    </tr>
    <tr>
      <td>4</td>
      <td>ocrd-cis-ocropy-denoise</td>
      <td>{"level-of-operation":"page"}</td>
    </tr>
    <tr>
      <td>5</td>
      <td>ocrd-tesserocr-deskew</td>
      <td>{"operation_level":"page"}</td>
    </tr>
    <tr>
      <td>7</td>
      <td>ocrd-tesserocr-segment-region</td>
      <td></td>
    </tr>
    <tr>  
	  <td>7a</td>
      <td>ocrd-segment-repair</td>
      <td>{"plausibilize": true}</td>
    </tr>
    <tr>
      <td>9</td>
      <td>ocrd-cis-ocropy-deskew</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>10</td>
      <td>ocrd-cis-ocropy-clip</td>
      <td>{"level-of-operation":"region"}</td>
    </tr>
    <tr>
      <td>11</td>
      <td>ocrd-tesserocr-segment-line</td>
      <td></td>
    </tr>
    <tr>  
	  <td>11a</td>
      <td>ocrd-segment-repair</td>
      <td>{"sanitize": true}</td>
    </tr>
    <tr>
      <td>13</td>
      <td>ocrd-cis-ocropy-dewarp</td>
      <td></td>
    </tr>
    <tr>
      <td>14</td>
      <td>ocrd-calamari-recognize</td>
      <td>{"checkpoint":"/path/to/models/\*.ckpt.json"}</td>
    </tr>
  </tbody> 
</table>

### Example with ocrd-process

```sh
ocrd process \
  "olena-binarize -I OCR-D-IMG -O OCR-D-BIN -P impl sauvola" \
  "anybaseocr-crop -I OCR-D-BIN -O OCR-D-CROP" \
  "olena-binarize -I OCR-D-CROP -O OCR-D-BIN2 -P impl kim" \
  "cis-ocropy-denoise -I OCR-D-BIN2 -O OCR-D-BIN-DENOISE -P level-of-operation page" \
  "tesserocr-deskew -I OCR-D-BIN-DENOISE -O OCR-D-BIN-DENOISE-DESKEW -P operation_level page" \
  "tesserocr-segment-region -I OCR-D-BIN-DENOISE-DESKEW -O OCR-D-SEG-REG" \
  "segment-repair -I OCR-D-SEG-REG -O OCR-D-SEG-REPAIR -P plausibilize true" \
  "cis-ocropy-deskew -I OCR-D-SEG-REPAIR -O OCR-D-SEG-REG-DESKEW -P level-of-operation region" \
  "cis-ocropy-clip -I OCR-D-SEG-REG-DESKEW -O OCR-D-SEG-REG-DESKEW-CLIP -P level-of-operation region" \
  "tesserocr-segment-line -I OCR-D-SEG-REG-DESKEW-CLIP -O OCR-D-SEG-LINE" \
  "segment-repair -I OCR-D-SEG-LINE -O OCR-D-SEG-REPAIR-LINE -P sanitize true" \
  "cis-ocropy-dewarp -I OCR-D-SEG-REPAIR-LINE -O OCR-D-SEG-LINE-RESEG-DEWARP" \
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P checkpoint /path/to/models/\*.ckpt.json"
```

**Note:** 
(1) This workflow expects your images to be stored in a folder called `OCR-D-IMG`. If your images are saved in a different folder,
you need to adjust `-I OCR-D-IMG` in the second line of the call above with the name of your folder, e.g. `-I my_images`
(2) For the last processor in this workflow, `ocrd-calamari-recognize`, you need to specify your local path to the model on your hard drive 
as parameter value! The last line of the `ocrd-process` call above could e.g. look like this:
```sh
  "calamari-recognize -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR -P checkpoint /test/data/calamari_models/\*.ckpt.json"
```
All the other lines can just be copied and pasted.