---
layout: page
author: Volker Hartmann
date: 2020-02-20T10:14:34+01:00
lang: en
lang-ref: workflow
toc: true
---

# Workflows
There are several steps necessary to get the fulltext of a scanned manuscript.

## Image Optimization
Prepare image for better OCR.

### Step 1: Binarization
First of all the images should be binarized. (Some segmentation algorithms seems to produce better results using original image.)

This processor takes a scanned colored /gray scale document image as input and produce a black and white binarized image. This step should separate the background from the foreground.

**See also:**  **ToDo reference to the result inside talk on final workshop** 

#### Available processors
| Processor                | Parameter                       | Remarks     |
| ------------------------ | ------------------------------- | ----------- |
| ocrd-anybaseocr-binarize |                                 |             |
| ocrd-cis-ocropy-binarize |                                 | Fast        |
| ocrd-olena-binarize      | {\"impl\":\"sauvola\"}          |             |
|                          | {\"impl\":\"sauvola-ms\"}       |             |
|                          | {\"impl\":\"sauvola-ms-fg\"}    |             |
|                          | {\"impl\":\"sauvola-ms-split\"} | Recommended |
|                          | {\"impl\":\"kim\"}              |             |
|                          | {\"impl\":\"wolf\"}             |             |
|                          | {\"impl\":\"niblack\"}          |             |
|                          | {\"impl\":\"singh\"}            |             |
|                          | {\"impl\":\"otsu\"}             |             |

### Step 2: Denoising
This processor removes artifacts from the binarized image. 
May not be necessary for all manuscripts

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-ocropy-denoise | {"level-of-operation":"page"} |         |

### Step 3: Deskewing
This processor takes a document image as input and do the skew correction of that document. The input images have to be binarized for this module to work.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
| Processor              | Parameter                     | Remarks     |
| ---------------------- | ----------------------------- | ----------- |
| ocrd-anybaseocr-deskew |                               |             |
| ocrd-tesserocr-deskew  | {"operation_level":"page"}    | Fast        |
| ocrd-cis-ocropy-deskew | {"level-of-operation":"page"} | Recommended |

### Step 4: Dewarping
This processor takes a document image as input and make the text line  straight if its curved. The input image has to be binarized for the  module to work.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
| Processor              | Parameter                     | Remarks      |
| ---------------------- | ----------------------------- | ------------ |
| ocrd-anybaseocr-dewarp | {\"pix2pixHD\":\"/path/to/pix2pixHD/\",<br />\"model_name\":\"/path/to/pix2pixHD/models\"} | For available models take a look at this [site](https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models) <br /> Parameter 'model_name' is missleading. Given directory has to contain a file named 'latest_net_G.pth' <br/> **GPU required!** |

### Step 5: Cropping
This processor takes a document image as input and crops/selects the page content area only (that's mean remove textual noise as well as any  other noise around page content area).

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors
| Processor              | Parameter                     | Remarks      |
| ---------------------- | ----------------------------- | ------------ |
| ocrd-anybaseocr-crop |           | The input image has to be  binarized and <br />should be deskewed for the module to work. |

## Layout Analyzis
Now the image should be optimized for segmentation.
### Step 6: Text segmentation (page)

This processor takes (optimized) document image as an input and segments the image into the different text blocks. During this step also a classification (text, marginalie, image, ...) should be done.

See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-tesserocr-segment-region |  | Should also work for original images!? |
| ocrd-anybaseocr-block-segmentation | {\"block_segmentation_model\":<br />\"/path/to/mrcnn\",<br />\"block_segmentation_weights\":<br />\"/path/to/model/block_segmentation_weights.h5\"} |  For available models take a look at this [site](https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models) <br/> Should also work for original images!?    |
| ocrd-cis-ocropy-segment  | {\"level-of-operation\":\"page\"} |         |

## Image Optimization (on Block Level)
Now the blocks should be optimized for OCR.

### Step 7:  Binarization 
This processor takes a scanned colored /gray scale block as input and produce a black and white binarized image. This step should separate the background from the foreground.
The binarization should be at least executed once (on page/block/line level)

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-tesserocr-binarize | {\"operation_level\":\"region\"} |         |

### Step8:  Deskewing 
This processor takes an  image as input and do the skew correction for all text blocks.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-ocropy-deskew | {\"level-of-operation\":\"region\"} |         |

### Step 9:  Cliping 
This processor can be used to remove intrusions of neighbouring segments in regions / lines of a workspace. It runs a (ad-hoc binarization and) connected component analysis on every text region / line of every PAGE in the input file group, as well as its overlapping neighbours, and for each binary object of conflict, determines whether it belongs to the neighbour, and can therefore be clipped to white. It references the resulting segment image files in the output PAGE (as AlternativeImage).

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-ocropy-clip | {\"level-of-operation\":\"region\"} |         |

### Step 10:  Line segmentation 
This processor can be used to segment regions into lines. It runs a (ad-hoc binarization and) line segmentation on every text region of every PAGE in the input file group, and adds a TextLine element with the resulting polygon outline to the annotation of the output PAGE.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-ocropy-segment | {\"level-of-operation\":\"region\"} |         |
| ocrd-tesserocr-segment-line |  |         |

### Step 11:  Line correction 
These processors can be used to correct the segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-ocropy-clip | {\"level-of-operation\":\"line\"} |         |
| ocrd-cis-ocropy-resegment |  |         |
| ocrd-segment-repair | {\"sanitize\":true} |         |

### Step 12: Dewarping (on line level)
These processors can be used to correct the segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-anybaseocr-dewarp | {\"operation_level\":\"line\",<br/>\"pix2pixHD\":\"/path/to/pix2pixHD/\",<br />\"model_name\":\"/path/to/pix2pixHD/models\"} | For available models take a look at this [site](https://github.com/mjenckel/ocrd_anybaseocr/tree/master/ocrd_anybaseocr/models) <br /> Parameter 'model_name' is missleading. Given directory has to contain a file named 'latest_net_G.pth' <br/> **GPU required!** |
| ocrd-cis-ocropy-dewarp |  |         |

## Text Recognition and Optimization
### Step 13: Text recognition
This processor recognize text in segmented lines.

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-tesserocr-recognize | {\"textequiv_level\":\"glyph\",<br />\"overwrite_words\":true,\"model\":\"Fraktur\"} |  |
|  | {\"textequiv_level\":\"glyph\",<br/>\"overwrite_words\":true,<br/>\"model\":\"GT4HistOCR_50000000.997_191951\"} | Recommended <br/> Model can be found [here](https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/GT4HistOCR_50<br/>00000/tessdata_best/GT4HistOCR_50000000.997_191951.traineddata) |
| ocrd-calamari-recognize | {\"checkpoint\":\"/path/to/models/*.ckpt.json\"} | Model can be found [here](https://ocr-d-repo.scc.kit.edu/models/calamari/GT4HistOCR/model.tar.xz) |
**Note:** For 'ocrd-tesserocr' the environment variable 'TESSDATA_PREFIX' has to be set to point to directory where the used models are stored. (The directory should at least contain the following models: deu.traineddata, eng.taineddata, osd.traineddata )

## Post Correction (Optional)
### Step 14: Text aligning
This processor alignes texts from multiple OCR-engines in one PAGE.xml. 

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cis-align          |                               |         |

### Step 15: Post correction
This processor try to optimize the recognized text. 

**See also:  ToDo reference to the result inside talk on final workshop** 

#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-cor-asv-ann-process |{\"textequiv_level\":\"line\",\"model_file\":\"/path/to/model/model.h5\"}                               |  Models can be found [here](https://github.com/ASVLeipzig/cor-asv-ann-models)       |
| ocrd-cis-post-correct.sh | ???                              | Not tested yet!      |


## Analyzis (Optional)
If Ground Truth data is available the OCR can be analyzed.
### Step 16: Analyzis
This processor can be used to analyze the output of the OCR.
#### Available processors

| Processor               | Parameter                     | Remarks |
| ----------------------- | ----------------------------- | ------- |
| ocrd-dinglehopper       |                               | First input group should point to the ground truth.   |

