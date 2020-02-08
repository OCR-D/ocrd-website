---
layout: page
lang: en
lang-ref: data
toc: true
---

# Data

## Reference Data

The reference data includes a Ground Truth corpus and other special corpora.
The Ground Truth corpus contains pages from publications printed between 1500
and 1900. The content of the corpus is based on a particular selection from the
holdings of the DFG project ["German Text
Archive"](http://www.deutschestextarchiv.de), the [Digitized Collections of the
Staatsbibliothek zu Berlin](http://digital.staatsbibliothek-berlin.de/) and the
[Wolfenbüttel Digital
Library](http://www.hab.de/de/home/bibliothek/digitale-bibliothek-wdb.html) of
the Duke August library. The holdings of projects and digital collections of
other libraries as well as additional Ground Truth data, which are compiled
together with module projects, can be included in the corpus as special
extensions in concertation with the OCR-D coordination project. If additional
annotations or texts are necessary, these can be created in consultation with
the OCR-D coordination project.

## Depth of Annotation, Text Accuracy and Artifacts

The Ground Truth corpus offers three annotation depths:

* Structural regions, text lines, word coordinates
* Structure regions, text lines
* Text lines

[Overview](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit) (The list will be extended continuously.)

The special corpora contain:

* a corpus of data with lower text accuracy (dirty OCR), which can be used for individual comparisons and evaluations
* a corpus of artifacts with objects that show disturbances
[Overview](https://docs.google.com/spreadsheets/d/1sS9bmPFo6UjRysO6Q-bGSOAFOR41m6dyiIOvgg6ajLg/edit#gid=0)

## Creation of the Ground Truth

The image data were first subjected to a layout analysis (text region and line recognition) using [Transkribus](https://transkribus.eu/Transkribus/) and then segmented automatically. The automatically recognized text as well as the lines and text regions were corrected manually. Finally the data in form of PAGE files, digital images and METS files were ziped as a BagIt file.

**If you are interested in further Ground Truth data (e.g. for binarization) please contact us: [engl[at]hab.de](mailto:engl@hab.de)**

The data are subject to a CC-BY-SA license, for the use of the image data
different licenses may exist. Please [contact the project](contact) and/or the owning library.

# OCR-D Research Data Repository
The OCR-D research data repository collects all versions of documents and (intermediate) results created during the document analysis. It contains at least the end results of every processed document. During the ingest much metadata about the document will be extracted and made available for search/filter (e.g. identifier(s), title, classification(s), genre(s), semantic label(s), used processor(s), text). In future, there may also be export options for specific tools.

# OCR-D Ground Truth Repository
Similarly, there is a publicly available OCR-D repository, which contains all ground truth data provided by OCR-D. 
* For further information about the metadata format, see https://github.com/OCR-D/gt-labelling
* The repository itself is available at https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search
