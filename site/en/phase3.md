---
layout: page
lang-ref: phase3
lang: en
toc: true
---

# OCR-D - Phase III

In February 2020, the DFG published a call for proposals to continue the OCR-D project in [a third project phase](https://ocr-d.de/en/2020/02/25/dfg-call.html). 
The goal of this phase is the implementation of the OCR-D software in institutions that 
maintain and process collections. Four implementation and three module projects were approved by the DFG. 

On 30 July, our kick-off workshop took place, heralding phase III of OCR-D. The team of the Coordination Project introduced [objectives and communications channels of phase III](https://ocr-d.de/assets/kick-off/phase3.pdf), gave an insight into the current [status and plans of the OCR-D software](https://ocr-d.de/assets/kick-off/spec_core_ocrd_all.pdf), the [Web API](https://ocr-d.de/assets/kick-off/web-api.pdf) and the handling of [Ground Truth Data in OCR-D](https://ocr-d.de/assets/kick-off/gt.pdf). Furthermore, the Coordination Project presented Best Practices of [Software Developing in OCR-D](https://ocr-d.de/assets/kick-off/software-development.pdf), including ideas for the community on how to contribute. 
In addition, the [implementation and module projects presented themselves](https://ocr-d.de/assets/kick-off/lightning-talks.pdf) to the interested community and to our [cooperation partners](https://ocr-d.de/en/contact#cooperation-partners).

## Implementation Projects

### Integration of Kitodo and OCR-D for productive mass digitisation 
_UB Braunschweig, SLUB Dresden, UB Mannheim_

With the workflow management system (WMS) Kitodo.Production and the TYPO3-based presentation module Kitodo.Presentation, Kitodo is a widespread and open solution for mass digitization in culture-preserving institutions, which allows suitable operating models for large and small institutions. 
A process for text recognition based on the tools and workflows of OCR-D must therefore be designed as a distributed system that does justice to the flexibility of the various operating models, the complex workflows and the needs-based scalability for small to very large digitization projects.

The project pursues four project goals that build on one another and complement each other, which should ultimately enable the use of OCR-D in mass digitization with Kitodo:

* Construction and documentation of a web-based, scalable OCR-D server
* Development of a quality-based workflow optimization for OCR-D
* Implementation of an OCR module for Kitodo
* Extension of Kitodo.Presentation and DFG-Viewer for OCR on Demand

<br/><br/>
Further information: [Projekt page of the University Library Mannheim](https://www.bib.uni-mannheim.de/en/about/projects-of-the-university-library/ocr-d-kitodo/)

### OPERANDI: OCR-D Performance Optimisation and Integration 
_SUB Göttingen, GWDG_

The aim of the project is the development of an OCR-D-based implementation package for mass full text capture with an improved throughput and better quality of the results. 
The aim is to ensure the implementation package can also be used by other projects and institutions with comparable requirements. 
Two scenarios were identified in the pilot phase. 
In the first scenario, OCR generation is to take place for works that have already been digitised. 
In the second scenario, OCR generation for new works takes place as part of the digitisation process.

<br/><br/>
Further information: [Project page of the Göttingen State and University Library](https://www.sub.uni-goettingen.de/en/projects-research/project-details/projekt/operandi-ocr-d-performance-optimisation-and-integration/)

### OCR4all libraries – full text recognition of historical collections 
_GEI Braunschweig, HCI and ZPD of the University of Würzburg_

<br/><br/>
Further information [Project page of the German Research Foundation](https://gepris.dfg.de/gepris/projekt/460665940?language=en)

### ODEM: OCR-D extension for mass digitization 
_ULB Sachsen-Anhalt_

The University and State Library Saxony-Anhalt has been a partner in the digitization of VD18 holdings for many years now. 
This project is the next step in the development of these holdings, because the 6.13 million digitized pages will be enriched with fulltext information, using the tools developed in the earlier OCR-D project phases. 
The amount of data and the diversity of these holdings already show that this is a project under realistic conditions: In mass digitization, many languages are encountered and individual peculiarities of publications must be considered, when using and developing the OCR-D tools to gain fulltext information to increase their usefulness. 
Since all of these holdings have already been digitized, updating and reformatting the metadata as well as the reuse of already exisiting information, such as structural metadata, for new viewing formats are key focal points of this project.

<br/><br/>
Further information: [Project page of the German Research Foundation](https://gepris.dfg.de/gepris/projekt/460554747?language=en)

## Module Projects

### Workflow for work-specific training based on generic models with OCR-D and ground truth enhancement 
_UB Mannheim_

The goal of this project is to enable institutions (for example, libraries) to retrain the modules of the OCR-D workflow as easily as possible so that better recognition rates can be achieved for specific works.

<br/><br/>
Further information: [Projekt page of the University Library Mannheim](https://www.bib.uni-mannheim.de/en/about/projects-of-the-university-library/ocr-d-modelltraining/)

### Font Group Recognition for Improved OCR 
_JGU Mainz, FAU Erlangen-Nürnberg_

<br/><br/>
Further information: [Project page of the German Research Foundation](https://gepris.dfg.de/gepris/projekt/460605811?language=en)

### OLA-HD Service - A Generic Service for Long-Term Archiving of Historical Prints 
_SUB Göttingen, GWDG_

The primary goal of this project is the development of a productive service for the long-term archiving of historical prints in the context of OCR-D. This OLA-HD Service is based on the corresponding prototype from OCR-D Phase II, expands it according to the requirements of the implementation projects, is integrated into the OCR-D framework and is generically designed and implemented according to the tender requirements.

<br/><br/>
Further information: [Project page of the Göttingen State and University Library](https://www.sub.uni-goettingen.de/en/projects-research/project-details/projekt/ola-hd-service-a-generic-service-for-long-term-archiving-of-historical-prints/)