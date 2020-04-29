---
layout: page
lang-ref: about
lang: en
title: The OCR-D project
---

# The OCR-D project

## Background
With the Union Catalogue of Books of the 16th–18th century (VD16, VD17, VD18) published in the German-speaking countries, a retrospective national bibliography of early modern writings from the German-speaking countries is being compiled. In order to facilitate research access to these texts, great concerted efforts have been and are being undertaken to make fully digitised copies or key pages for the recorded titles available in digital form.

In view of the developments and new possibilities in the field of Optical Character Recognition (OCR), experts at a DFG workshop in March 2014 assessed the full-text transformation of VD as an ambitious but achievable goal. Making full texts available for the purpose of full-text search and further processing, for example with tools of the Digital Humanities, is a major desideratum of research, which is to be addressed by a coordinated funding initiative.

OCR is a comprehensive process that typically involves a sequence of several steps in the workflow: Besides the pure recognition of letters and words, techniques such as pre-processing (image optimization and binarization), layout analysis (recognition and classification of structural features such as headings, paragraphs, etc.) and post-processing (error correction) are applied. While most of these steps can also benefit from the use of Deep Neural Networks, so far hardly any free and open standard tools and related best practices have emerged. The full text recognition of historical documents is particularly complicated due to their great variability in font, layout, language and orthography.

## Goals and structure of the OCR-D project
This is where the DFG-funded project OCR-D comes in. Its main goal is the conceptual and technical preparation of the full text transformation of the VD. The task of automatic full-text recognition is broken down into its individual process steps, which can be retraced in the open source OCR-D software. This allows to create optimal workflows for the old prints to be processed and thus to generate scientifically usable full texts.

For this purpose, a coordination project was formed by the Berlin-Brandenburg Academy of Sciences and Humanities, the Herzog-August Library Wolfenbüttel, the Berlin State Library and the Karlsruhe Institute of Technology. In the first project phase, the project identified development needs, which are currently being addressed by a total of eight OCR-D module projects in the second project phase.

![](/assets/Funktionsmodell.png)

Full-text recognition is understood as a complex process that includes several preprocessing and postprocessing steps in addition
to the actual text recognition (see Fig. 1). First, a digital image is prepared for text recognition in preprocessing by binarization, cropping,
deskewing, dewarping and despeckling. This is followed by layout recognition, which identifies the text areas of a page down to line level. Especially the recognition of the lines respectively the baseline is important for the following actual text recognition, which in all modern approaches is based on neural networks. The individual structures or elements of the full-text recognized document are then classified according to their typographic function and the OCR result is improved in the post-correction process if necessary, before it is transferred to repositories for long-term archiving.

For the individual process steps, tools of [eight module-projects](module-projects) are developed. Furthermore, already existing Open Source tools or tools developed in other projects can be integrated into the OCR-D framework through the modular structure of OCR-D and thus synergies can be used.

In addition to the envisaged full text transformation of VD titles (16th-19th century), which is technically and conceptually prepared within the OCR-D project, OCR-D pursues the following further objectives:
* the creation of [reference corpora](data) for training and testing
* the development of [standards in the fields of metadata, documentation and ground truth](spec)
* the further development of individual processing steps, with a particular focus on Optical Layout Recognition (OLR)
* the analysis of existing tools and their further development
* the creation of [reusable software packages](http://www.github.com/ocr-d)
* the establishment of quality assurance procedures

In all steps we welcome a lively exchange with colleagues from other projects and institutions as well as service providers, in order to finally be able to realize a consolidated procedure for the OCR processing of digitized material of the printed German cultural heritage of the 16th–19th century.
