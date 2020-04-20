---
layout: page
lang-ref: first test
lang: en
---

# Results and findings of the first OCR-D test
## Background
At the turn of the year 2019/2020, the OCR-D software was tested for the first time in nine pilot libraries. This was to ensure the practical acceptance of the software by future, potential users. Therefore the focus was on its functionality and usability in practice. In addition to the partners of the coordination project, two libraries involved in the module projects as well as four other libraries took part in the testing. The findings of this first test run will be incorporated into the further development of the OCR-D prototype.

All pilot libraries have some know-how and experience with OCR, as they have already produced full texts at least at project level or via service providers. The extent to which OCR, which is regarded as important, should be carried out independently in future and firmly anchored in the digitisation workflow, is currently discussed in the libraries. Concerning the target groups of the full texts there are different opinions in the testing institutions. While one third generally name humanities scholars, another third would like to serve a very broad target group (humanities, digital humanities, computer linguistics and economics). The remaining libraries only see relatively few, specialised users (Digital Humanities or Computational Linguistics) as the target group for OCR texts.

The pilot libraries demand the following features of an OCR software:
* High recognition rate of layout and text
* Cost-effective use
* Quick adaptability/troubleshooting
* Modularity
* Output in standard formats
* Connection to existing workflows
* Well documented interfaces
* Word coordinates
* Trainability
* Extensive GT corpora

High quality of text recognition is most important, whereas the other characteristics are only named each by some of the pilot libraries and should be considered as desired but subordinate optional features.


## Evaluation of the software tests
In order to ensure the comparability of the individual tests in the pilot libraries, a questionnaire distributed to the pilot libraries at the beginning of the test. In this questionnaire, the general conditions of the test run, e.g. the technical equipment used and the tested OCR-D processors, as well as the documentation of the software, interfaces, functionality and usability of the software, its possibilities for being integrated into existing workflows and the required output formats are recorded. Furthermore, recognition quality, functionality and usability, open requirements and positive features of the OCR-D software as well as the results of the test were to be described.

During the test phase, the various options for installing the OCR-D software with and without a docker container were tried out and the software was successfully installed on a wide range of differently powerful, partly virtual servers. For non-Intel computers (ARM, PowerPC64) this was more complicated and time consuming, as individual Python packages were not executable on these computers and had to be adapted manually. The complete installation of all available OCR-D processors (``ocrd_all``), which was developed during the test phase, was confirmed as the simplest and least complex variant and was therefore the most recommendable. No pilot library integrated the OCR-D software In a workflow software such as Kitodo, as this would have meant too much work for a simple test run. 

The usage of the numerous OCR-D processors was described as a challenge. Calling the processors was not so much of a problem than understanding their respective areas of application and, in particular, the selecting and combining the processors to form meaningful workflows. For the first test, besides the technical documentation of the software, there was no overall documentation on its use available yet, which is also aimed at users inexperienced in OCR. The requirements and wishes of the testers for such a documentation were taken into account when preparing the manuals, which are now available [in the user area of the OCR-D website](https://ocr-d.de/de/use.html). 

The OCR-D software runs very stable, no library reported any aborts. All of the required output formats are already offered, whereas the few changes, which are still on the interfaces, are already planned for the further development of the prototype.

The recognition quality was only checked on individual pages by the respective pilot libraries, as there is no ground truth available for the test books. Overall, the results of this first test run are promising. The Mannheim University Library has tested OCR-D with a focus on tesseract processors on five prints from the 16th to 19th century. On antiqua prints from the 17th and 18th centuries and a blackletter text from the 19th century, as expected, the best results of - in the case of the antiqua - significantly less than 0.1 CER were achieved for the raw data, whereas the blackletter prints from the 17th century was slightly above 0.1 CER. The greatest challenge was the 16th century bleckletter, where only a CER of just under 0.16 was reached. The BBAW provides a comprehensive insight into their testing, by making their [report and data publicly available](https://github.com/tboenig/ocrd_bbaw_pilotbibliothek).

The OCR-D testers formulate some desiderata especially with regard to documentation, quality and usability of the processors as well as their future scalability. The requirements for the documentation of the OCR-D software have already been implemented to a large extent, though documentation as a whole is regarded as a continuous task which must successively include above all practical experience in the application of the OCR-D software. For the processors, some improvements would still be desirable, especially in layout recognition and post-correction. The corresponding developments of the OCR-D module projects could only be tested to a limited extent due to their development stage or their special technical requirements (GPU). Hopefully, the above mentioned desiderata can be met with their results or with further models. For the use of the OCR-D software in mass digitisation, the runtime of several processors - as originally planned for the third project phase - still needs to be optimised, and the possibilities for parallelisation should also be expanded. 

The testers positively emphasized the modular and transparent structure of the OCR-D software, which distinguishes it in particular from other OCR solutions and allows the its users to confiure optimal workflows for particular use cases. Furthermore, the open source available Python programs can be further developed by experts specialized in their respective fields and can be used for experiments on the OCR workflow without extensive programming work. In case of questions and problems, the developers quickly provide low-threshold support. All in all, it is comparatively easy to initiate the robustly running OCR-D full-text generation process, which is still in need of further optimization but already delivers promising results.
