---
layout: page
lang: de
lang-ref: glossary.md
toc: true
---

# OCR-D Glossary

> Glossary of terms from the domain of image processing/OCR and how they are used within the OCR-D framework

This section is non-normative.

## Layout and Typography

### Block

See [Region](#region)

### Border

From the [PAGE-XML content schema documentation](https://ocr-d.de/de/gt-guidelines/pagexml/pagecontent_xsd_Complex_Type_pc_BorderType.html)

> Border of the actual page (if the scanned image contains parts not belonging to the page).

### Font family

Within OCR-D, *font family* refers to grouping elements by font similarity. The
semantics of a *font family* are up to the data producer.

### Glyph

Within OCR-D, a glyph is the atomic unit within a [word](#word).

### Grapheme Cluster

See [Glyph](#glyph)

### Line

See [TextLine](#textline)

### Reading Order

Reading order describes the logical sequence of [regions](#region) within a document.

### Region

A region is described by a polygon inside a page.

### Region type

The semantics or function of a [region](#region) such as heading, page number, column, table...

### Symbol

See [Glyph](#glyph)

### TextLine

A text line is a single row of [words](#word) within a text [region](#region). (Depending on the region's or page's orientation, and the script's writing direction, it can be horizontal or vertical.)

### Print space

From the [PAGE-XML content schema documentation](https://ocr-d.de/de/gt-guidelines/pagexml/pagecontent_xsd_Complex_Type_pc_PrintSpaceType.html)

> Determines the effective area on the paper of a printed page. Its size is equal for all pages of a book (exceptions: titlepage, multipage pictures).
>
> It contains all living elements (except marginalia) like paragraphs and headings, as well as footnotes, headings, running titles.
>
> It does not contain pagenumber (if not part of running title), marginalia, signature mark, preview words.

### Word

A word is a sequence of [glyphs](#glyph) within a [line](#textline) which does not contain any word-bounding whitespace. (That is, it includes punctuation and is synonym to _token_ in NLP.)

## Data

### Ground Truth

Ground truth (GT) [in the context of OCR-D](http://ocr-d.de/daten) are
transcriptions, specific structure descriptions and word lists. These are
essentially available in PAGE XML format in combination with the original
image. Essential parts of the GT were created manually.

We distinguish different usage scenarios for GT:

#### Reference data

With the term *reference data*, we refer to data that illustrates
different stages of an OCR/OLR process on representative materials. They are
supposed to support the assessment of commonly encountered difficulties and challenges when
running certain analysis operations and are therefore manually annotated
at all levels.

#### Evaluation data

*Evaluation data* are used to quantitatively evaluate the performance of OCR tools
and/or algorithms. Parts of these data which correspond to the tool(s) under consideration
are guaranteed to be recorded manually.

#### Training data

Many OCR-related tools need to be adapted to the specific domain of the works which are to
be processed. This domain adaptation is called *training*. Data used to guide this process
are called *training data*. It is essential that those parts of these data which are fed
to the training algorithm are captured manually.

## Activities

### Binarization

Binarization means converting all color or grayscale pixels in an image to either black or white.

Controlled term: `binarized` (`comments` of a mets:file), `preprocessing/optimization/binarization` (`step` in ocrd-tool.json)

See [Felix' Niklas interactive demo](http://felixniklas.com/imageprocessing/binarization)

### Dewarping

Manipulate an image in such a way that all text lines are
straightened and any geometrical distortions have been corrected.

Controlled term: `preprocessing/optimization/dewarping`

See [Matt Zucker's entry on Dewarping](https://mzucker.github.io/2016/08/15/page-dewarping.html).

### Despeckling

Remove artifacts such as smudges, ink blots, underlinings etc. from an image. Typically applied to 
remove "salt-and-pepper" noise resulting from [Binarization](#Binarization).

Controlled term: `preprocessing/optimization/despeckling`

### Deskewing

Rotate an image so that all text lines are horizontal.

Controlled term: `preprocessing/optimization/deskewing`

### Font identification

Detect the font type(s) used in the document, either before or after an OCR run.

Controlled term: `recognition/font-identification`

### Grayscale normalization

> ISSUE: https://github.com/OCR-D/spec/issues/41

Controlled term:
  - `gray_normalized` (`comments` in file)
  - `preprocessing/optimization/cropping` (step)

Gray normalization is similar to binarization but instead of a purely bitonal
image, the output can also contain shades of gray to avoid inadvertently
combining glyphs when they are very close together.

### Document analysis

Document analysis is the detection of structure on the document level to e.g. create a table of contents.

### Reading order detection

Detect the [reading order](#reading-order) of [regions](#region).

### Cropping

Detecting the print space in a page, as opposed to the margins. It is a form of
[region segmentation](#region-segmentation).

Controlled term: `preprocessing/optimization/cropping`.

### Border removal

--> [Cropping](#cropping)

### Segmentation

Segmentation means detecting areas within an image.

Specific segmentation algorithms are labelled by the semantics of the regions
they detect not the semantics of the input, i.e. an algorithm that detects
regions is called [region segmentation](#region-segmentation).

### Region segmentation

Segment an image into [regions](#region). Also determines whether this is a text
or non-text region (e.g. images).

Controlled term:
- `SEG-REGION` (`USE`)
- `layout/segmentation/region` (step)

### Region classification

Determine the [type](#region-type) of a detected region.

### Line segmentation
Segment text [regions](#region) into [textlines](#textline).

Controlled term:
- `SEG-LINE` (`USE`)
- `layout/segmentation/line` (step)

### Line recognition

See [OCR](#ocr).

### OCR

Map pixel areas to [glyphs](#glyph) and [words](#words).

### Word segmentation

Segment a [textline](#textline) into [words](#word)

Controlled term:
- `SEG-LINE` (`USE`)
- `layout/segmentation/word` (step)

### Glyph segmentation

Segment a [textline](#textline) into [glyphs](#glyph)

Controlled term: `SEG-GLYPH`

### Text recognition

See [OCR](#ocr).

### Text optimization

Text optimization encompasses the manipulations to the text based on the steps
up to and including text recognition. This includes (semi-)automatically correcting
recognition errors, orthographical harmonization, fixing segmentation errors etc.

## Data Persistence

### Software repository

The software repository contains all OCR-D algorithms and tools developed
during the project including tests. It will also contain the documentation and
installation instructions for deploying a document analysis workflow.

### Ground Truth repository

Contains all the [ground truth](#ground-truth) data.

### Research data repository

The research data repository may contain the results of all
[activities](#activities) during document analysis. At least it contains the
end results of every processed document and its full provenance. The research
data repository must be available locally.

### Model repository

Contains all trained (OCR) models for text recognition. The model repository
has to be available at least locally. Ideally, a publicly available model repository will
be developed.

### Workspace

A workspace is a representation for some document in the local file system. Minimally it consists of a directory with a copy of the [METS](https://ocr-d.de/en/spec/mets) file. Additionally, that directory may contain physical data files and sub-directories belonging to the document (required or generated by run-time OCR-D processing), as referenced by the METS via `mets:file/mets:FLocat/@href` and `mets:fileGrp/@USE`. Files and sub-directories without reference (like log or config files) are not part of the workspace, as are references to remote locations. They can be added to the workspace by referencing them in the METS via their relative local path names.

## Workflow modules

The [OCR-D project](https://ocr-d.de) divided the various elements of an OCR
workflow into six abstract modules.

### Image preprocessing

Manipulating the input images for subsequent layout analysis and text recognition.

### Layout analysis

Detection of structure within the page.

### Text recognition and optimization

Recognition of text and post-correction of recognition errors.

### Model training

Generating data files from aligned ground truth text and images to configure
the prediction of text and layout recognition engines.

### Long-term preservation and persistence

Storing results of OCR and OLR indefinitely, taking into account versioning,
multiple runs, provenance/parametrization and providing access to these saved
snapshots in a granular fashion.

### Quality assurance

Providing measures, algorithms and software to estimate the quality of the [individual processes](#activities) within the OCR-D domain.

## Component architecture

### (OCR-D) Application

Application composed of various servers that can execute processors; can be a desktop computer or workstation, a distributed system comprising a controller and multiple processing servers, or an HPC cluster.

### OCR-D Web API

As proposed in [OCR-D/spec#173](https://github.com/OCR-D/spec/pull/173), the OCR-D Web API defines uniform and interdependent services that can be distributed across network components, depending on the use case.

### (OCR-D) Service

Group of endpoints of the OCR-D Web API; discovery/workspace/processing/workflow/...

### (OCR-D) Server

Concrete implementation of a subset of OCR-D services, or the network host providing it.

### (OCR-D) Controller

OCR-D Server (implementing at least *discovery*, *workspace* and *workflow* services) executing workflows (a single workflow or multiple workflows simultaneously), distributing tasks to configured processing servers, managing workspace data management. Should also manage load balancing.

### (OCR-D) Processing Server

OCR-D server (implementing at least *discovery* and *processing* services) that can execute one or more (locally installed) processors or evaluators, manages workspace data; implementor should consider whether a single OCR-D processing server (with page-parallel processing) best fits the use case, or multiple OCR-D processing servers (with document-parallel processing), or even dedicated OCR-D processing servers with GPU/CUDA support.

### (OCR-D) Backend

Software component of a server concerned with network operations; e.g. Python library with request handlers, implementing service discovery and network-capable workspace data management.

### (OCR-D) Workflow Runtime Library

Software component of a server or processor concerned with OCR systems modelling; e.g. Python library in [OCR-D/core](https://github.com/OCR-D/core) providing classes for all essential functional components (`OcrdPage`, `OcrdMets`, `Workspace`, `Resolver`, `Processor`, `ProcessorTask`, `Workflow`, `WorkflowTask` ...), including mechanisms for signalling and orchestration of workflows, on top of which components (from processor to controller) can be implemented.

### (OCR-D) Workflow Engine

Central software component of the controller, executing workflows, including control structures (in a linear/parallel/incremental way). Also needed in single-host CLI deployments (where it can be based on inter-process communication and file system I/O alone), like `ocrd process`.

### (OCR-D) Processor

A processor is a tool that implements the uniform [OCR-D command-line-interface](https://ocr-d.de/en/spec/cli) for run-time data processing. That is, it executes a single [workflow step](#activities), or a combination of multiple workflow steps, on the [workspace](https://ocr-d.de/en/user_guide#preparing-a-workspace) (represented by local [METS](https://ocr-d.de/en/spec/mets)), reading input files for all or requested physical pages of the input fileGrp(s), and writing output files for them into the output fileGrp(s). It may take a number of optional or mandatory [parameters](https://ocr-d.de/en/spec/ocrd_tool).

→ [OCR-D Workflow Guide](https://ocr-d.de/en/workflows)


### (OCR-D) Evaluator

An evaluator is a tool that implements the uniform OCR-D CLI for run-time quality estimation, assessing an [activity's](#activities) annotation (i.e. a [processor's](#processor) output) with some quality metric to yield a score and applying a given threshold against it to signal full or partial success/failure.

### (OCR-D) Module

Software package/repository providing one or more processors or evaluators, possibly encompassing additional areas of functionality (training, format conversion, creation of GT, visualization)

Modules can comprise multiple methods/activities that are called [*processors*](#processor)
for OCR-D. There were [eight MP](https://ocr-d.de/en/module-projects) in the
second phase of OCR-D (2018-2020).

### Messaging

Messaging service on the basis of Publish/Subscribe architecture (or similar) to coordinate network components, in particular for the distribution of tasks and load balancing, as well as signalling processor/evaluator results.

### OCR-D Workflow

Combination of [activities](#activities) via concrete [processors](#processor) and [evaluators](#evaluator) and their parameterization configured as a sequence or lattice, depending on their success or failure. Implemented in the [OCR-D Workflow Runtime Library](#ocr-d-workflow-runtime-library) and serializable in a yet-to-specifcy format (as of 2020/10).

The term *Workflow* is understood to encompass more features in other contexts, such as manual intervention by the user. In contrast to the terminology in workflow engines like Taverna or digitization frameworks like Kitodo, an OCR-D workflow is a fully automatic process.
