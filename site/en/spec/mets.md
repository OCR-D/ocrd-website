---
layout: page
lang: en
lang-ref: mets.md
toc: true
title: Requirements on handling METS/PAGE
---

# Requirements on handling METS/PAGE

OCR-D has decided to base its data exchange format on [METS](http://www.loc.gov/standards/mets/). This document defines a set of conventions and mechanism for using METS files within OCR-D. The basis for this is the METS Application Profile
for digitised media by the [DFG-Viewer](http://dfg-viewer.de/) (current version: [2.3.1](http://dfg-viewer.de/fileadmin/groups/dfgviewer/METS-Anwendungsprofil_2.3.1.pdf)).

For layout and text recognition results, the primary exchange format in OCR-D is [PAGE](https://github.com/OCR-D/PAGE-XML). Conventions for PAGE are outlined in [a separate document](page).

## 1) Metadata

<a id="unique-id-for-the-document-processed"/>
### 1.1 Unique ID for the document processed

METS documents must be uniquely addressable within the global library community.

For this purpose, the METS file MUST contain a `mods:identifier` 
that must contain a globally unique identifier for the document 
and have a `type` attribute with a value of (in order of preference):

* `purl`
* `urn`
* `handle`
* `url`

<a id="always-use-url-or-relative-filenames"/>
### 1.2 Always use URL or relative filenames

Always use URL, except for files located in the directory or any subdirectories of the METS file.

#### Example

```sh
/tmp/foo/ws1
├── mets.xml
├── foo.tif
└── foo.xml
```

Valid `mets:FLocat/@xlink:href` in `/tmp/foo/ws1/mets.xml`:
* `foo.xml`
* `foo.tif`
* `file://foo.tif`

Invalid `mets:FLocat/@xlink:href` in `/tmp/foo/ws1/mets.xml`:
* `/tmp/foo/ws1/foo.xml` (absolute path)
* `file:///tmp/foo/ws1/foo.tif` (file URL scheme with absolute path)
* `file:///foo.tif` (relative path written as absolute path)

<a id="recording-processing-information-in-mets"/>
### 1.3 Recording processing information in METS

[OCR-D processors](cli) should add information to the METS metadata header to indicate that
they changed the METS. This information is mainly for human consumption to get
an overview of the software agents involved in the METS file's creation. More
detailed or machine-actionable provenance information is outside the scope of
the processor.

To add agent information, a processor must:

1) locate the first `mets:metsHdr` `M`.
2) Add to `M` a new `mets:agent` `A` with these attributes
  - `TYPE` must be the string `OTHER`
  - `OTHERTYPE` must be the string `SOFTWARE`
  - `ROLE` must be the string `OTHER`
  - `OTHERROLE` must be the processing step this processor provided, from the list in [the ocrd-tool.json spec](ocrd_tool#definition)
3) Add to `A` a `mets:name` `N` that should include, in free-text form, these data points
  - Name of the processor, e.g. the name of the executable from `ocrd-tool.json`
  - Version of the processor, e.g. from `ocrd-tool.json`

#### Example

```xml
<mets:agent TYPE="OTHER" OTHERTYPE="SOFTWARE" ROLE="OTHER" OTHERROLE="preprocessing/optimization/binarization">
  <mets:name>ocrd_tesserocr v0.1.2</mets:name>
</mets:agent>
```

## 2) Images

<a id="if-in-page-then-in-mets"/>
### 2.1 If in PAGE then in METS

All URLs used in the `imageFilename` / `filename` attributes of
`pc:Page` / `pc:AlternativeImage` of all PAGE files MUST be referenced in a `mets:fileGrp` as the
`@xlink:href` attribute of a `mets:file` in the METS. For derived images (`pc:AlternativeImage`), this MUST be the same file group as
the PAGE-XML that was the result of the processing step that produced the
`pc:AlternativeImage`.

In other words: New `pc:AlternativeImage` files must be
written to the same `mets:fileGrp` as their target PAGE-XML files, which in most
implementations will mean the same directory. Existing images must be read from the filesystem, 
and could reside in any fileGrp prior to the source PAGE-XML file in the workflow (including the original image in the first fileGrp).

<a id="pixel-density-of-images-must-be-explicit-and-high-enough"/>
### 2.2 Pixel density of images must be explicit and high enough

The pixel density is the ratio of the number of pixels that represent a a unit of measure of the scanned object. It is typically measured in pixels per inch (PPI, a.k.a. DPI).

The original input images MUST have >= 150 ppi.

Every processing step that generates new images and changes their dimensions MUST make sure to adapt the density explicitly when serialising the image.

```sh
$> exiftool input.tif |grep 'X Resolution'
"300"

# WRONG (ppi unchanged)
$> convert input.tif -resize 50% output.tif

# RIGHT:
$> convert input.tif -resize 50% -density 150 -unit inches output.tif

$> exiftool output.tif |grep 'X Resolution'
"150"
```

However, since technical metadata about pixel density is so often lost in
conversion or inaccurate, processors should assume **300 ppi** for images with
missing or suspiciously low pixel density metadata.

<a id="no-multi-page-images"/>
### 2.3 No multi-page images

Image formats like TIFF support encoding multiple images in a single file.

Data providers MUST provide single-image TIFF files.

OCR-D processors MUST raise an exception if they encounter multi-image TIFF files.

<a id="images-and-coordinates"/>
### 2.4 Images and coordinates

Coordinates in a PAGE-XML are always absolute, i.e. relative to extent defined in the `imageWidth` / `imageHeight` attributes of the top-level `pc:Page`.


When a processor wants to access the image of a layout element like a `pc:TextRegion` or `pc:TextLine`, the algorithm should be:

- If the element in question has an attribute `imageFilename`, resolve this value
- Else if the element in question has a subelement `pc:AlternativeImage` with attribute `filename`, resolve this value
- Otherwise, resolve by passing the attribute `imageFilename` of the top-level `pc:Page` and the `points` attribute of the element's `pc:Coords` subelement

(For details on coordinate handling, see [PAGE-XML specs](page#images).)

## 3) File groups `mets:fileGrp`

Referenced files MUST be organised into file groups without recursion.

<a id="file-group-use-syntax"/>
### 3.1 File Group `@USE` syntax

All `mets:fileGrp` MUST have a **unique** `USE` attribute that hints at the provenance of the files
and MUST be a valid [`xsd:ID`](https://www.w3.org/TR/xmlschema11-2/#ID).

It SHOULD have the structure

```
ID := "OCR-D-" + PREFIX? + WORKFLOW_STEP + ("-" + PROCESSOR)?
PREFIX := ("" | "GT-")
WORKFLOW_STEP := ("IMG" | "SEG" | "OCR" | "COR")
PROCESSOR := [A-Z0-9\-]{3,}
```

`PREFIX` can be `GT-` to indicate that these files are [ground truth](glossary#ground-truth).

`WORKFLOW_STEP` can be one of:

- `IMG`: Image(s)
- `SEG`: Segmented [regions](glossary#region) / [lines](glossary#textline) / [words](glossary#word)
- `OCR`: OCR produced from image
- `COR`: Post-correction

`PROCESSOR` should be a mnemonic of the processor or result type in a terse,
all-caps form, such as the name of the tool (`KRAKEN`) or the organisation
`CIS` or the type of manipulation (`CROP`) or a combination of both starting
with the type of manipulation (`BIN-KRAKEN`).

#### Examples

`<mets:fileGrp USE>`                       | Type of use for OCR-D
--                                         | --
`<mets:fileGrp USE="OCR-D-IMG">`           | The unmanipulated source images
`<mets:fileGrp USE="OCR-D-PRE-BIN">`       | Binarization preprocessing
`<mets:fileGrp USE="OCR-D-PRE-CROP">`      | Cropping preprocessing
`<mets:fileGrp USE="OCR-D-PRE-DESKEW">`    | Deskewing preprocessing
`<mets:fileGrp USE="OCR-D-PRE-DESPECK">`   | Despeckling preprocessing
`<mets:fileGrp USE="OCR-D-PRE-DEWARP">`    | Dewarping preprocessing
`<mets:fileGrp USE="OCR-D-SEG-REGION">`    | Region segmentation
`<mets:fileGrp USE="OCR-D-SEG-LINE">`      | Line segmentation
`<mets:fileGrp USE="OCR-D-SEG-WORD">`      | Word segmentation
`<mets:fileGrp USE="OCR-D-SEG-GLYPH">`     | Glyph segmentation
`<mets:fileGrp USE="OCR-D-OCR-TESS">`      | [Tesseract OCR](https://github.com/OCR-D/ocrd_tesserocr)
`<mets:fileGrp USE="OCR-D-OCR-OCRO">`      | [Ocropus OCR](https://github.com/OCR-D/ocrd_cis)
`<mets:fileGrp USE="OCR-D-COR-CIS">`       | [CIS post-correction](https://github.com/cisocrgroup/ocrd_cis)
`<mets:fileGrp USE="OCR-D-COR-ASV">`       | [ASV post-correction](https://github.com/ASVLeipzig/cor-asv-ann)
`<mets:fileGrp USE="OCR-D-GT-SEG-REGION">` | Region segmentation ground truth
`<mets:fileGrp USE="OCR-D-GT-SEG-LINE">`   | Line segmentation ground truth
`<mets:fileGrp USE="OCR-D-GT-SEG-WORD">`   | Word segmentation ground truth
`<mets:fileGrp USE="OCR-D-GT-SEG-GLYPH">`  | Glyph segmentation ground truth

## 4) Files `mets:file` 

<a id="file-id-syntax"/>
### 4.1 File ID syntax

Each `mets:file` must have an `ID` attribute. The `ID` attribute of a `mets:file` SHOULD be the `USE` of the containing `mets:fileGrp` 
combined with its corresponding page ID or a 4-zero-padded number.
The `ID` MUST be unique inside the METS file.

```
FILEID := ID + "_" + [0-9]{4}
ID := FILEGRP + (".IMG")?
```

#### Examples

`<mets:file ID>` | ID of the file for OCR-D
--               | --
`<mets:file ID="OCR-D-IMG_0001">`            | The unmanipulated source image
`<mets:file ID="OCR-D-PRE-BIN_0001">`        | PAGE encapsulating the result from binarization
`<mets:file ID="OCR-D-PRE-BIN.IMG_0001">`    | Black-and-white image
`<mets:file ID="OCR-D-PRE-CROP_0001">`       | PAGE encapsulating the result from (binarization and) cropping
`<mets:file ID="OCR-D-PRE-CROP.IMG_0001">`   | Cropped black-and-white image

### 4.2 `@MIMETYPE` syntax

Every `mets:file` element representing a PAGE file MUST have its `MIMETYPE` attribute set to `application/vnd.prima.page+xml`.

### 4.3 File Group `@USE="FULLDOWNLOAD_..."`

For `mets:file` entries representative of the publication **as a whole**, the `ID` attribute MUST have  prefix `FULLDOWNLOAD_`, followed by the file format (`TEI`, `ALTO`, `hOCR`, `HTML`, `TXT`, `COCO`, `PDF`).

These entries SHOULD be referenced in the [structMap](#ocr-d-structmap) under `/mets:mets/mets:structMap[@TYPE="PHYSICAL"]/mets:div/mets:fptr` (i.e. the top-level `mets:div` element).

They MAY reside in the same `mets:fileGrp` as per-page files of the same type, or in a separate one.

#### Example
`<mets:file ID>` | ID of the file for OCR-D
--               | --
`<mets:file ID="FULLDOWNLOAD_TEI"  MIMETYPE="application/tei+xml">`            | The digitised publication or book in TEI format.
`<mets:file ID="FULLDOWNLOAD_TEI_01"  MIMETYPE="application/tei+xml">`            | The digitised publication or book in TEI format. Version one.
`<mets:file ID="FULLDOWNLOAD_TEI_02"  MIMETYPE="application/tei+xml">`            | The digitised publication or book in TEI format, a second Version.

## 5) Grouping files by page `mets:structMap`

<a id="grouping-files-by-page"/>
### 5.1 Grouping files by page

The METS file MUST have exactly one physical map that contains a single
`mets:div[@TYPE="physSequence"]` which in turn must contain a
`mets:div[@TYPE="page"]` for every page in the work.

These `mets:div[@TYPE="page"]` can contain an arbitrary number of `mets:fptr`
pointers to `mets:file` elements to signify that all the files within a div are
encodings of the same page.

#### Example

```xml
<mets:fileGrp USE="OCR-D-IMG">
    <mets:file ID="OCR-D-IMG_0001">...</mets:file>
</mets:fileGrp>
<mets:fileGrp USE="OCR-D-OCR">
    <mets:file ID="OCR-D-OCR_0001">...</mets:file>
</mets:fileGrp>
<mets:structMap TYPE="PHYSICAL">
  <mets:div ID="PHYS_0000" TYPE="physSequence">
    <mets:div ID="PHYS_0001" TYPE="page">
      <mets:fptr FILEID="OCR-D-IMG_0001"/>
      <mets:fptr FILEID="OCR-D-OCR_0001"/>
    </mets:div>
  </mets:div>
</mets:structMap>
```

### 5.2 OCR-D `mets:structMap`

The METS may contain different `mets:structMap` entries, differentiated by their `TYPE` attribute (e.g. `LOGICAL`, `PHYSICAL, ...`). 
* A `mets:structMap` with `TYPE="PHYSICAL"` is mandatory.
* The _logical_ document structure detected by _library or archive_ MUST be described by `TYPE="LOGICAL"`.
* The _logical_ document structure detected by _OCR-D software_ MUST be described by `TYPE="OCR-D-LOGICAL"`.

attributes in `structMap` | description
--                        | --
`LABEL` | contains the recognized text of a structuring component, e.g. the title of a chapter
`TYPE` | contains the type of a structuring component according to some standardized, controlled vocabulary (see [DFG-Viewer: structural data set](https://dfg-viewer.de/strukturdatenset/)), e.g. `chapter`

## 6) Ranges of pages `mets:structLink`

The `mets:structLink` describes the ranges of pages in parts of a document 
by linking `mets:div` elements of the logical `mets:structMap` to `mets:div` elements of the  physical `mets:structMap`.

#### Example

```xml
<mets:fileGrp USE="OCR-D-IMG">
    <mets:file ID="OCR-D-IMG_0001" >...</mets:file>
</mets:fileGrp>
<mets:fileGrp USE="OCR-D-OCR">
    <mets:file ID="OCR-D-OCR_0001" >...</mets:file>
</mets:fileGrp>
<mets:structMap TYPE="OCR-D-LOGICAL">
  <mets:div DMDID="dmdSec_0001" ADMID="amdSec_0001" ID="OCR-D-loc_0001">
    <mets:div ID="OCR-D-loc_d5e320" TYPE="chapter" LABEL="KapıteI 1">
    <mets:div ID="OCR-D-loc_d7e560" TYPE="chapter" LABEL="Unterkapitel"/>
    </mets:div>
    <mets:div ID="OCR-D-loc_d9e376" TYPE="chapter" LABEL="Kapidel 2"/>
   </mets:div>
</mets:structMap>
<mets:structMap TYPE="LOGICAL">
   <mets:div TYPE="Monograph" DMDID="dmdSec_0001" ADMID="amdSec_0001" ID="loc_0001">
    <mets:div ID="loc_d1e410" TYPE="chapter" LABEL="Kapitel 1"/>
    <mets:div ID="loc_d1e451" TYPE="chapter" LABEL="Kapitel 2"/>
   </mets:div>
</mets:structMap>
<mets:structMap TYPE="PHYSICAL">
  <mets:div ID="PHYS_0000" TYPE="physSequence">
    <mets:div ID="PHYS_0001" TYPE="page">
      <mets:fptr FILEID="OCR-D-IMG_0001"/>
      <mets:fptr FILEID="OCR-D-OCR_0001"/>
    </mets:div>
  </mets:div>
</mets:structMap>
<mets:structLink>

<!-- Library-Part-->   
<mets:smLink xlink:from="loc_0001" xlink:to="PHYS_0000"/>
<mets:smLink xlink:from="loc_d1e410" xlink:to="PHYS_0001"/>
<mets:smLink xlink:from="loc_d1e410" xlink:to="PHYS_0002"/>
<mets:smLink xlink:from="loc_d1e410" xlink:to="PHYS_0003"/>
<mets:smLink xlink:from="loc_d1e410" xlink:to="PHYS_0004"/>
<mets:smLink xlink:from="loc_d1e451" xlink:to="PHYS_0005"/>
<mets:smLink xlink:from="loc_d1e451" xlink:to="PHYS_0006"/>

 <!-- OCR-D-Part-->   
<mets:smLink xlink:from="OCR-D-loc_0001" xlink:to="PHYS_0000"/>
<!-- Kapitel 1-->
<mets:smLink xlink:from="OCR-D-loc_d5e320" xlink:to="PHYS_0001"/>
<mets:smLink xlink:from="OCR-D-loc_d5e320" xlink:to="PHYS_0002"/>
<mets:smLink xlink:from="OCR-D-loc_d5e320" xlink:to="PHYS_0003"/>
<mets:smLink xlink:from="OCR-D-loc_d5e320" xlink:to="PHYS_0004"/>

<!-- Unter-Kapitel zu 1-->
<mets:smLink xlink:from="OCR-D-loc_d7e560" xlink:to="PHYS_0002"/>
<mets:smLink xlink:from="OCR-D-loc_d7e560" xlink:to="PHYS_0003"/>
<mets:smLink xlink:from="OCR-D-loc_d7e560" xlink:to="PHYS_0004"/>

<!-- Kapitel 2-->    
<mets:smLink xlink:from="OCR-D-loc_d7e560" xlink:to="PHYS_0005"/>
<mets:smLink xlink:from="OCR-D-loc_d7e560" xlink:to="PHYS_0006"/>

</mets:structLink>
```
