https://www.bb2018.uni-rostock.de/fileadmin/uni-rostock/Tagungen/BB2018/Bibliotheca_Baltica_-_Rostock_2018_Information.pdf

# An open-source framework for integrating multi-source layout and text recognition tools into scalable OCR workflows

---

# Overview

- The situation
- The OCR-D process
- Open-source framework
- Multi-source tools
- Scalable workflows

---

# The situation

- Users want text data
  - huge amounts (i.e. everything)
  - high quality
  - including structural information
  - easily accessible (i.e. machine readable)
- Libraries provide text data
  - large amounts
  - low quality
  - some manually annotated structural entities
  - complicated access methods

---

# The OCR-D process

- Started in ...
- Running since ...
- Partners ...
- Requirements analysis ...
- Module project bid ...

> [name=kmw] Hier die Tatsache erwähnen, dass die DFG praktisch Softwareentwicklung hin zu einem „produktiven“ Workflow mit vergleichsweise großem Aufwand fördert

---

# layout and text recognition

- OCR is more than character recognition
- Segmentation, better evaluation ...
- dfg praxisrichtlinien 

=> more than sandwiched PDF but rich structured ...

---

# Multi-source tools

- various tools integrated within the OCR-D project
- but also **existing** tools and tools developed outside the OCR-D projects
    - ocropy
    - kraken
    - calamari
    - dh-segment

=> Thin compatibility layer to wrap for OCR-D compliance

python vs bashlib

erst python vorstellen, dann limitationen, dann bashlib


---

# Open Source

> [name=kba] Commit graph oder Network oder so

----

# Adaptiveness

Workflows with individual steps tailored to the source material & quality requirements ....

---

# Scalable workflows

> [name=kba] Docker als Deploymentoption, Taverna? Kitodo als eine moegliche Anschlussarchitektur

---


