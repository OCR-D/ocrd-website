---
layout: page
lang: en
lang-ref: module-projects
toc: true
title: Phase II
---

# Module Projects Phase II

In the first project phase, a functional model for the OCR-D workflow was
developed. Full text recognition is seen as a complex process that includes
several upstream and downstream steps in addition to the actual text
recognition. First, a digital image is preprocessed for text recognition by
cropping, deskewing, dewarping, despeckling and binarizing it into a black and
white image. This is followed by layout recognition, which identifies the text
areas of a page down to line level. The recognition of the lines or the
baseline is particularly important for the subsequent text recognition, which
is based on neural networks in all modern approaches. The individual structures
or elements of the fully text-recognized document are then classified according
to their typographic function before the OCR result is improved in the
post-correction, if necessary. Finally the end result is transferred to
repositories for long-term archiving.

From the project proposals for the DFG's module project call in March 2017,
eight projects were approved:

## Scalable methods of text and structure recognition for full text digitization of historical prints: Image Optimisation

<p class="poster-image">
  <a href="/assets/poster/DFKI.pdf">
    <img src="/assets/poster/DFKI.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_German Research Center for Artificial Intelligence (DFKI)_

Project participants: Andreas Dengel, Martin Jenckel, Khurram Hashmi  
GitHub: [mjenckel/OCR-D-LAYoutERkennung](https://github.com/mjenckel/OCR-D-LAYoutERkennung)

DFKI was involved in the OCR-D project with two modules: Image optimization and
layout recognition. In both modules several processors were developed and
integrated into the OCR-D software system.

The first module project _image optimization_ focused on the pre-processing of
the digitized material with the aim of improving the image quality and thus the
performance of the subsequent OCR modules. For this purpose, tools for
binarization, deskewing, cropping and dewarping were implemented. 

The cropping tool based on computer vision is particularly noteworthy for its
performance. It predominantly achieves very good results on the entire project
data. The dewarping tool is also interesting due to its novel architecture.
Generative neural networks are used to generate equalized variants of images
instead of determining explicit transformations for the equalization.

## Scalable text and structure recognition methods for the full text digitization of historical prints: Layout Recognition

<p class="poster-image">
  <a href="/assets/poster/DFKI.pdf">
    <img src="/assets/poster/DFKI.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_DFKI_

Project participants: Andreas Dengel, Martin Jenckel, Khurram Hashmi  
GitHub: [mjenckel/OCR-D-LAYoutERkennung](https://github.com/mjenckel/OCR-D-LAYoutERkennung)

In the second DFKI module project _layout recognition_, the aim was to extract
the document structure, both of individual document pages and the entire
document. On the one hand, the metadata obtained in this way helps to digitize
the document as a whole, on the other hand, the extraction of certain document
structures is necessary. For example, most OCR methods can only process
individual lines of text. The tools developed are used for text-non-text
segmentation, block segmentation and classification, text line detection and
structure analysis.

One focus of development was the combined block segmentation and classification
based on the MaskRCNN architecture known from video and image segmentation.
This tool works with the unprocessed raw data, so that on the one hand no
pre-processing is necessary and on the other hand the full information spectrum
can be used.

<div class="is-clearfix"></div>
## Further development of a semi-automated open source tool for layout analysis and region extraction and classification (LAREX) of early printing

<p class="poster-image">
  <a href="/assets/poster/Wuerzburg.pdf">
    <img src="/assets/poster/Wuerzburg.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_Julius-Maximilians-University of Würzburg_   <br/>
_Institute of Computer Science: Chair of Artificial Intelligence and Applied Computer Science_

Project participants: Frank Puppe, Alexander Gehrke  
GitHub: [ocr-d-modul-2-segmentierung](https://github.com/ocr-d-modul-2-segmentierung)

At the Department of Computer Science VI at the University of Würzburg, LAREX
was developed in the preliminary work. LAREX is a comfortable editor for
annotating regions and layout elements on book pages. In the further
development of the OCR-D module project, the focus was not only on improving
efficient operability but also on expanding automatic procedures.

For this purpose a Convolutional-Neural-Net (CNN) was implemented and trained,
which assigns each pixel of a page scan a classification in different classes
in order to separate image and text. By considering the pixels of only one
class each, a segmentation of the page is then carried out with classical
methods. Another tested approach first used classical segmentation methods and
then classified the segments.

The segmentation method based on CNN output was adapted to the OCR-D
interfaces. Good results were achieved on pure text pages or pages with clearly
separated images. There is potential for improvement especially in the
recognition of decorative initials of older prints and other images close to
the text as well as multi-column layouts.

<div class="is-clearfix"></div>
## NN/FST – Unsupervised OCR-Postcorrection based on Neural Networks and Finite-state Transducers

<p class="poster-image">
  <a href="/assets/poster/Leipzig.pdf">
    <img src="/assets/poster/Leipzig.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_University of Leipzig_ <br/>
_Institut für Informatik: Department of Automatic Language Processing_

Project participants: Gerhard Heyer, Robert Sachunsky  
GitHub: [ASVLeipzig/cor-asv-fst](https://github.com/ASVLeipzig/cor-asv-fst)

A fully automatic post-correction separately from the actual OCR only makes
sense if statistical knowledge about "correct text" and about typical OCR
errors is added _a priori_. Neural networks (NN) as well as weighted finite
transducers (WFST), which can be trained on corresponding additional data, are
suitable for this purpose.

For the implementation of a combined architecture of NN and FST it was decided to implement three modules:

1. a pure NN solution with continuously (_end-to-end_) trained model on the
character level alone - as a deep (multi-layer), bidirectional recurrent
network according to the encoder-decoder scheme (for different input and
output lengths) with an attention mechanism and A*-Beamsearch with
adjustable rejection threshold (against overcorrection), i.e.
post-correction of text lines is treated like machine translation,
2. a NN language model (LM) at the character level - as a deep (multi-layer),
bidirectional recurrent network with interface for graph input and
incremental decoding
3. a WFST component with an error model to be trained explicitly on glyph level
and word model/lexicon, as well as connection to 2. - via WFST composition
of input graph with error and word model according to the sliding window
principle, conversion of the single windows to one hypothesis graph per text
line, and combination of the respective output weights with LM-evaluations
in an efficient search for the best path.

The combination of 3. with 2. thus represents a hybrid solution. But also 1.
can benefit from 2. (if the same network topology is used) by initializing the
weights from a language model trained on larger amounts of pure text (transfer
learning).

Both approaches benefit from a close connection to the OCR search space, i.e. a
transfer of alternative character hypotheses and their confidence (as so far
only possible with Tesseract and realized in cooperation with the module
project of the Mannheim University Library). However, they also deliver good
results on pure full text (with CER reduction of up to 5%), provided that
sufficient suitable training data is available and the OCR itself delivers
useful results (below 10% CER).

Command line interfaces for training and evaluation as well as full OCR-D
interfaces for processing and evaluation are available for all modules.

<div class="is-clearfix"></div>

## Optimized use of OCR processes – Tesseract as a component in the OCR-D workflow

<p class="poster-image">
  <a href="/assets/poster/Mannheim.pdf">
    <img src="/assets/poster/Mannheim.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_University of Mannheim_ <br/>
_University Library Mannheim_

Project participants: Stefan Weil, Noah Metzger  
GitHub: [tesseract-ocr/tesseract/](http://github.com/tesseract-ocr/tesseract/ "http://github.com/tesseract-ocr/tesseract/")

The module project focused on the OCR software Tesseract, which has been
developed by Ray Smith since 1985, since 2005 as open source under a free
license.

The project had two main goals: The integration of Tesseract into the OCR-D
workflow including support of the other module projects by providing
interfaces, and the general improvement of stability, code quality and
performance of Tesseract.

The integration into the OCR-D workflow required much less effort than
originally planned; mainly because most of the work had already been done
outside the module project and the existing Python interface tesserocr could be
used.

For the OCR-D module project of the University of Leipzig, Tesseract was
extended to generate alternative OCR results for the single characters. As
input data for an OCR post-correction model, text recognition can thus be
further improved. A valuable side-effect of the new code are more accurate
character and word coordinates.

With several hundred corrections, the code quality was significantly improved
and a much more stable program flow was achieved. Tesseract is now more
maintainable, requires less memory and is faster than before.

A significant improvement in recognition accuracy for most of the printing
units relevant for OCR-D was achieved by new generic models for Tesseract.
These were trained from September 2019 until January 2020 on the basis of the
data collection [_GT4HistOCR_](https://zenodo.org/record/1344132).

## Automatic post-correction of historical OCR captured prints with integrated optional interactive correction 

<p class="poster-image">
  <a href="/assets/poster/München.pdf">
    <img src="/assets/poster/München.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_Ludwig-Maximilians-University of Munich_<br/>
_Centre for Information and Language Processing (CIS)_

Project participants: Klaus Schulz, Floran Fink, Tobias Englmeier  
GitHub: [https://github.com/cisocrgroup/ocrd-postcorrection](https://github.com/cisocrgroup/ocrd-postcorrection), [https://github.com/cisocrgroup/cis-ocrd-py](https://github.com/cisocrgroup/cis-ocrd-py)

The result of the project is a _A-I-PoCoTo_ system integrated into the OCR-D workflow for fully automatic post-correction of full text recognized historical prints. The system also includes an optional interactive post-correction (_I-PoCoTo_), which is integrated into the interactive post-correction system _PoCoWeb_. The system can thus be used alternatively as a stand-alone tool for collaborative web-based post-correction of OCR documents.
The basis of the fully automatic post-correction is a flexible, feature-based Machine Learning (ML) procedure for fully automatic OCR post-correction with a special focus on avoiding the problem of disimprovement. The system uses the document-dependent profiling technology developed at CIS to detect errors and to generate correction candidates. In addition to various confidence values, the features of the system also use information from additional auxiliary OCRs.
The system logs all correction decisions. Via this protocol mechanism the automatic post correction in _PoCoWeb_ can be checked interactively. You can manually undo individual correction decisions that have been made, and also subsequently execute correction decisions that have not been made.
The entire system is integrated into the OCR-D workflow and follows the conventions valid there.

<div class="is-clearfix"></div>

## Development of a model repository and an automatic font recognition for OCR-D

<p class="poster-image">
  <a href="/assets/poster/Mainz.pdf">
    <img src="/assets/poster/Mainz.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_University Leipzig_<br/>  
_Institute of Computer Science: Chair of Digital Humanities_<br/>
_Friedrich Alexander University Erlangen-Nuremberg_<br/>
_Department of Computer Science: Chair of Computer Science 5: Pattern Recognition_<br/>
_Johannes Gutenberg University Mainz_<br/>
_Gutenberg Institute for World Literature and Writing-Oriented Media: Department of Book Science_

Project participants: Gregory Crane, Nikolaus Weichselbaumer, Saskia Limbach, Andreas Meier, Vincent Christlein, Mathias Seuret, Rui Dong  

GitHub: [OCR-D/okralact](https://github.com/OCR-D/okralact), [https://github.com/seuretm/ocrd_typegroups_classifier](https://github.com/seuretm/ocrd_typegroups_classifier)

The recognition rates of OCR for prints produced before 1800 vary greatly, as
the diversity of historical fonts is either not taken into account at all or
only insufficiently in the training data. Therefore this module project,
consisting of computer scientists and book historians, has set itself three
goals: 

On the one hand, we have developed a tool for the automatic recognition of
fonts in digitised images. Here, we have concentrated especially on broken
fonts besides fracture, which have received little attention so far, but were
widely used in the 15th and 16th centuries: Bastarda, Rotunda, Textura and
Schwabacher. The tool has been trained with 35,000 images and achieves an
accuracy of 98% in determining fonts. Overall, it can not only differentiate
between the above mentioned fonts, but also distinguish between Hebrew, Greek,
Fraktur, Antiqua and Italic. 

In a second step, an online training infrastructure was created (Okralact). It
simplifies the use of different OCR engines (Tesseract, Ocropus, Octopus,
Calamari) and at the same time makes it possible to train specific models for
certain fonts. 

Finally, a model repository has been set up that contains already developed
font-specific OCR models. To lay a foundation here, we have transcribed a total
of about 2,500 lines for Bastarda, Textura and Schwabacher from a variety of
different books. 

The high accuracy of the font recognition tool opens up the possibility of
having the tool even distinguish between the fonts of individual printers in
the future through further training data, which would address several
desiderata of historical research.

<div class="is-clearfix"></div>

## OLA-HD – An OCR-D long-term archive for historical books

<p class="poster-image">
  <a href="/assets/poster/Göttingen.pdf">
    <img src="/assets/poster/Göttingen.png" style="height: 400px" title="Click for full-size PDF version"/>
  </a>
</p>

_Georg-August-University of Göttingen_<br/>
_State and University Library of Lower Saxony_<br/>
_Society for Scientific Data Processing mbH Göttingen_

Project participants: Mustafa Dogan, Kristine Schima-Voigt, Philip Wieder, Triet Doan, Jörg-Holger Panzer  
GitHub: [subugoe/OLA-HD-IMPL](https://github.com/subugoe/OLA-HD-IMPL)

In September 2018 the Digital Library Department of the State and University Library of Lower Saxony and the Gesellschaft für wissenschaftliche Datenverarbeitung Göttingen started the DFG project [_OLA-HD - Ein OCR-D Langzeitarchiv für historische Drucke_](https://www.sub.uni-goettingen.de/projekte-forschung/projektdetails/projekt/ola-hd-ein-ocr-d-langzeitarchiv-fuer-historische-drucke/).

The aim of OLA-HD is to develop an integrated concept for long-term archiving
and persistent identification of OCR objects, as well as a prototypical
implementation. 

In regular exchange with the project partners, the basic requirements for
long-term archiving and persistent identification were determined and recorded
in the form of a specification for technical and economic-organizational
implementation.

With the prototype the user can upload OCR results of a work as OCRD-ZIP into
the system. The system validates the zip file, assigns a PID and sends the file
to the archive manager [(CDSTAR - GWDG Common Data Storage
Architecture)](https://cdstar.gwdg.de/). This writes the Zip file to the
archive (tape storage). Depending on the configuration (file type, file size,
etc.), files are also written to an online storage (hard disk) for fast access.
The user has access to all OCR versions and can download versions as BagIt-Zip
files. All works and versions have their own PIDs. The PIDs are generated by
the European Persistent Identifier Consortium
[(ePIC)](https://www.pidconsortium.net/) service. The different OCR versions of
a work are linked via the PID, so that the system can map the versioning in a
tree structure. 

Users who are not logged in can browse the inventory and preview text and - if
available - images in the file structure or navigate through the different
versions. Users can register and log in via the GWDG portal and manage their
files via a dashboard.

By March 2020, minor optimizations will be made to the user interface and the
concept will be finalized. The concept will describe further expansion stages
that may be useful for transferring the prototype software into a product.

