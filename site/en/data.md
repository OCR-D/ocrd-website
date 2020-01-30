# Data

**Reference Data**

The reference data includes a Ground Truth corpus and other special corpora. The Ground Truth corpus contains pages from publications printed between 1500 and 1900. The content of the corpus is based on a particular selection from the holdings of the DFG project ["German Text Archive"](http://www.deutschestextarchiv.de), the [Digitized Collections of the Staatsbibliothek zu Berlin](http://digital.staatsbibliothek-berlin.de/) and the [Wolfenbüttel Digital Library](http://www.hab.de/de/home/bibliothek/digitale-bibliothek-wdb.html) of the Duke August library. The holdings of projects and digital collections of other libraries as well as additional Ground Truth data, which are compiled together with module projects, can be included in the corpus as special extensions in concertation with the OCR-D coordination project. If additional annotations or texts are necessary, these can be created in consultation with the OCR-D coordination project.

**Depth of Annotation, Text Accuracy and Artifacts**

The Ground Truth corpus offers three annotation depths:

* Structural regions, text lines, word coordinates
* Structure regions, text lines
* Text lines

[Overview](sites/all/GTDaten/IndexGT.html) (The list will be extended continuously.)

The special corpora contain:

* a corpus of data with lower text accuracy (dirty OCR), which can be used for individual comparisons and evaluations
* a corpus of artifacts with objects that show disturbances
[Overview](https://docs.google.com/spreadsheets/d/1sS9bmPFo6UjRysO6Q-bGSOAFOR41m6dyiIOvgg6ajLg/edit#gid=0)

**Creation of the Ground Truth ***

The image data were first subjected to a layout analysis (text region and line recognition) using [Transkribus](https://transkribus.eu/Transkribus/) and then processed with the integrated OCR engine (ABBYY FineReader 11 SDK). The automatically recognized text as well as the lines and text regions were corrected manually (if necessary by using existing Ground Truth data) and finally exported as ALTO and PAGE files. Together with the images in TIF format, these form the content of the zip files.

**If you are interested in further Ground Truth data (e.g. for binarization) please contact us: elisabeth.engl[at]hab.de**

The data are subject to a CC-BY-SA license, for the use of the image data different licenses may exist. Please contact the project ([contact](http://www.ocr-d.de/?q=node/2)) and/or the owning library.
