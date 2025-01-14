---
layout: page
lang-ref: about
lang: en
toc: true
title: The OCR-D project
---

# The OCR-D project

## Background
With the Union Catalogue of Books of the 16th–18th century (VD 16, VD 17, VD 18) published in the German-speaking countries, 
a retrospective national bibliography of early modern writings from the German-speaking countries is being compiled. In order 
to facilitate research access to these texts, great concerted efforts have been and are being undertaken to make fully digitised 
copies or key pages for the recorded titles available in digital form.

In view of the developments and new possibilities in the field of Optical Character Recognition (OCR), experts at a DFG workshop in March 2014 assessed the full-text transformation of VD as an ambitious but achievable goal. Making full texts available for the purpose of full-text search and further processing, for example with tools of the Digital Humanities, is a major desideratum of research, which is to be addressed by a coordinated funding initiative.

OCR is a comprehensive process that typically involves a sequence of several steps in the workflow: Besides the pure recognition of letters and words, techniques such as pre-processing (image optimization and binarization), layout analysis (recognition and classification of structural features such as headings, paragraphs, etc.) and post-processing (error correction) are applied. While most of these steps can also benefit from the use of Deep Neural Networks, so far hardly any free and open standard tools and related best practices have emerged. The full text recognition of historical documents is particularly complicated due to their great variability in font, layout, language and orthography.

## Goals and structure of the OCR-D project
This is where the DFG-funded project OCR-D comes in. Its main goal is the conceptual and technical preparation of the full text transformation of the VD. The task of automatic full-text recognition is broken down into its individual process steps, which can be retraced in the open source OCR-D software. This allows to create optimal workflows for the old prints to be processed and thus to generate scientifically usable full texts.

For this purpose, a coordination project was formed that identified development needs in the first project phase. These were worked on in the [second project phase](phase2) by a total of eight module projects. 
In the current [third project phase](phase3), the focus is on the conceptual preparation for the automatic generation of full texts for VD 16, VD 17 and VD 18. In addition, four implementation projects are working on integrating OCR-D into existing applications and infrastructures, while three module projects are further optimising OCR-D tools.

<p class="figure img" style="max-width: 100%">
	<a href="/assets/Funktionsmodell.svg" style="max-width: 100%">
		<img src="/assets/Funktionsmodell.svg" style="max-width: 100%">
	</a>
</p>

Full-text recognition is understood as a complex process that includes several preprocessing and postprocessing steps in addition
to the actual text recognition (see figure). First, a digital image is prepared for text recognition in preprocessing by binarization, cropping,
deskewing, dewarping and despeckling. This is followed by layout recognition, which identifies the text areas of a page down to line level. 
Especially the recognition of the lines respectively the baseline is important for the following actual text recognition, which in all modern approaches is based on neural networks. 
The individual structures or elements of the full-text recognized document are then classified according to their typographic function and the OCR result is improved in the post-correction process if necessary, before it is transferred to repositories for long-term archiving.

In addition to the envisaged full text transformation of VD titles (16th-19th century), which is technically and conceptually prepared within the OCR-D project, OCR-D pursues the following further objectives:
* the creation of [reference corpora](data) for training and testing
* the development of [standards in the fields of metadata, documentation and ground truth](spec)
* the further development of individual processing steps, with a particular focus on Optical Layout Recognition (OLR)
* the analysis of existing tools and their further development
* the creation of [reusable software packages](http://www.github.com/ocr-d)
* the establishment of quality assurance procedures

## Community
In all steps we welcome a lively exchange with colleagues from other projects and institutions as well as service providers, in order to finally be able to realize a consolidated procedure for the OCR processing of digitized material of the printed German cultural heritage of the 16th–19th century.
To this end, there is already an active community, which you can join via our [chat](https://gitter.im/OCR-D/Lobby) or our [regular open online meetings](community).
Interested parties from academia and practice are just as welcome as private individuals who (would like to) use OCR-D.

On our website you will also find a [collection of (scientific) publications and lectures](publications) on the topic of OCR(-D) by our current and former project participants.

## Results of past project phases
The third phase of OCR-D is currently being finalised. Results of past project phases can be found on these pages at any time:
* [User survey [Phase I]](user_survey)
* [Module projects from Phase II](phase2)
* [Pilot study [Phase II]](initial-tests)
