---
layout: page
lang-ref: phase3
lang: de
title: OCR-D - Phase III
toc: true
---

# OCR-D - Phase III

Im Februar 2020 hat die DFG eine Ausschreibung zur Fortsetzung des OCR-D Projektes in [einer dritten Projektphase veröffentlicht](https://ocr-d.de/de/2020/02/25/dfg-ausschreibung.html). 
Ziel dieser Phase ist die Implementierung der OCR-D-Software in bestandshaltenden und 
-verarbeitenden Einrichtungen. Vier Implementierungs- und drei Modulprojekte wurden von der 
DFG bewilligt. 

Am 30. Juli fand unser Kick-off-Workshop statt, der Phase III einläutete.
Das Team gab eine Einführung in die [Ziele und öffentlichen Kommunikationskanäle von OCR-D in Phase III](https://ocr-d.de/assets/kick-off/phase3.pdf), in [Status und Pläne der OCR-Software](https://ocr-d.de/assets/kick-off/spec_core_ocrd_all.pdf) und der [Web-API](https://ocr-d.de/assets/kick-off/web-api.pdf) und in den Umgang mit [Ground Truth Daten in OCR-D](https://ocr-d.de/assets/kick-off/gt.pdf). Zudem gab das Koordinierungsprojekt einen Einblick in die bisherige Praxis der [Softwareentwicklung in OCR-D](https://ocr-d.de/assets/kick-off/software-development.pdf) mit Möglichkeiten, mitzuwirken.
Außerdem [präsentierten sich unsere Implementierungs- und Modulprojekte](https://ocr-d.de/assets/kick-off/lightning-talks.pdf) gegenseitig sowie unseren [Kooperationspartnern](https://ocr-d.de/de/contact.html#kooperationspartner).

## Implementierungsprojekte

### Integration von Kitodo und OCR-D zur produktiven Massendigitalisierung 
_UB Braunschweig, SLUB Dresden, UB Mannheim_

Kitodo ist mit dem Workflowmanagementsystem (WMS) Kitodo.Production und dem TYPO3-basierten Präsentationsmodul Kitodo.Presentation eine weit verbreitete und offene Lösung für die Massendigitalisierung in kulturbewahrenden Einrichtungen, die für große und kleine Institutionen passende Betriebsmodelle erlaubt. Ein auf den Werkzeugen und Workflows von OCR-D basierendes Verfahren zur Texterkennung muss deshalb als verteiltes System konstruiert werden, das der Flexibilität der verschiedenen Betriebsmodelle, der komplexen Workflows sowie der bedarfs-gerechten Skalierbarkeit für kleine bis sehr große Digitalisierungsprojekte gerecht wird.

Das Projekt verfolgt vier aufeinander aufbauende und sich komplementär ergänzende Projektziele, die im Ergebnis den Einsatz von OCR-D in der Massendigitalisierung mit Kitodo ermöglichen sollen:

* Aufbau und Dokumentation eines web-basierten, skalierbaren OCR-D-Servers
* Entwicklung einer qualitätsbasierten Workflow-Optimierung für OCR-D
* Implementierung eines OCR-Moduls für Kitodo
* Erweiterung von Kitodo. Presentation und DFG-Viewer um OCR on Demand

<br/><br/>
Weitere Informationen: [Projektseite der Universitätsbibliothek Mannheim](https://www.bib.uni-mannheim.de/ihre-ub/projekte-der-ub/ocr-d-kitodo/)

### OPERANDI - OCR-D Performanzoptimierung und Integration. Ein Implementierungspaket der OCR-D-Software für die Massendigitalisierung
_SUB Göttingen, GWDG_

Das Ziel von OPERANDI ist die Entwicklung und der Aufbau eines auf OCR-D basierenden Implementierungspaketes zur Massenvolltexterfassung mit verbessertem Durchsatz, bei besserer Qualität der Ergebnisse. Zugleich wird das Ziel verfolgt, dass das Implementierungspaket auch von anderen Vorhaben und Einrichtungen mit vergleichbaren Anforderungen nachgenutzt werden kann. Im Rahmen der Pilotierung wurden zwei Szenarien identifiziert. Im ersten Szenario soll die OCR-Erzeugung für bereits digitalisierte Werke stattfinden, was in einer Massenvolltexterfassung mündet. Im zweiten Szenario erfolgt die OCR-Erzeugung für neue zu digitalisierende Werke im Rahmen des Digitalisierungsprozesses.

<br/><br/>
Weitere Informationen: [Projektseite der Niedersächsischen Staats- und Universitätsbibliothek Göttingen](https://www.sub.uni-goettingen.de/projekte-forschung/projektdetails/projekt/operandi-ocr-d-performance-optimisation-and-integration/)


### OCR4all libraries – Volltexterkennung historischer Sammlungen 
_GEI Braunschweig, HCI und ZPD der Universität Würzburg_

<br/><br/>
Weitere Informationen: [Projektseite der Deutschen Forschungsgemeinschaft](https://gepris.dfg.de/gepris/projekt/460665940?language=de)

### ODEM: OCR-D Erweiterung für Massendigitalisierung 
_ULB Sachsen-Anhalt_

Die Universitäts- und Landesbibliothek Sachsen-Anhalt ist bereits seit vielen Jahren Partner bei der Digitalisierung von VD18-Beständen. Dieses Projekt stellt die nächste Weiterentwicklung dieses Bestandsaufbaus dar, in dem die 6,13 Millionen Seiten mittels der in den OCR-D Projektphasen entwickelten Tools um Volltexte angereichert werden. Die Datenmenge und große Diversität der Bestände zeigen bereits, dass es sich bei diesem Projekt um eine Implementierung unter Realbedingungen handelt: In der Massendigitalisierung gibt es eine Vielzahl von auftretenden Sprachen und individuellen Besonderheiten bei Publikationen, die nun mithilfe der OCR-D-Tools, die zu diesem Zweck weiterentwickelt und ergänzt werden, um Volltext ergänzt und so besser nutzbar gemacht werden sollen. Da es sich um bereits digitalisierte Bestände handelt, ist insbesondere die Aktualisierung und Anpassung der Metadaten sowie die Weiternutzung vorhandener Informationen, wie etwa der Strukturierung, für die neu erstellten Ausgabeformate ein zentraler Aspekt dieses Projekts.

<br/><br/>
Weitere Informationen: [Projektseite der Deutschen Forschungsgemeinschaft](https://gepris.dfg.de/gepris/projekt/460554747?language=de)


## Modulprojekte

### Workflow für werkspezifisches Training auf Basis generischer Modelle mit OCR-D sowie Ground Truth Aufwertung 
_UB Mannheim_

Ziel dieses Projektes ist, dass Einrichtungen (zum Beispiel Bibliotheken) möglichst einfach die Module des OCR-D-Workflows nachtrainieren können, so dass bessere Erkennungs­raten für spezifische Werke erreicht werden können.

<br/><br/>
Weitere Informationen: [Projektseite der Universitätsbibliothek Mannheim](https://www.bib.uni-mannheim.de/ihre-ub/projekte-der-ub/ocr-d-modelltraining/)

### Erkennung von Schriftartgruppen zur OCR Verbesserung
_JGU Mainz, FAU Erlangen-Nürnberg_

<br/><br/>
Weitere Informationen: [Projektseite der Deutschen Forschungsgemeinschaft](https://gepris.dfg.de/gepris/projekt/460605811?language=de)

### OLA-HD Service - Ein generischer Dienst für die Langzeitarchivierung historischer Drucke 
_SUB Göttingen, GWDG_

Das primäre Projektziel ist die Entwicklung eines produktiven Dienstes für die Langzeitarchivierung von historischen Drucken im Rahmen von OCR-D. Dieser OLA-HD Service baut auf dem entsprechenden Prototypen aus der OCR-D Phase II auf, erweitert diesen gemäß der Anforderungen der Implementierungsprojekte, wird in das OCR-D Framework integriert und wird entsprechend der Ausschreibungsanforderungen generisch konzipiert und umgesetzt.

<br/><br/>
Weitere Informationen: [Projektseite der Niedersächsischen Staats- und Universitätsbibliothek Göttingen](https://www.sub.uni-goettingen.de/projekte-forschung/projektdetails/projekt/ola-hd-service-ein-generischer-dienst-fuer-die-langzeitarchivierung-historischer-drucke/)


