---
layout: page
lang: de
lang-ref: data
toc: true
title: Daten
---

# Daten

## Die Referenzdaten

Die Referenzdaten umfassen ein Ground-Truth-Korpus und weitere Spezialkorpora.
Das Ground-Truth-Korpus umfasst Seiten aus Publikationen aus dem Zeitraum 1500–1900. 
Der Inhalt des Korpus basiert auf einer gezielten Auswahl aus dem
Bestand des DFG-Projektes [„Deutsches Textarchiv“](http://www.deutschestextarchiv.de), der [Digitalisierten
Sammlungen der Staatsbibliothek zu Berlin](http://digital.staatsbibliothek-berlin.de/) und der [Wolfenbütteler Digitalen
Bibliothek der Herzog August Bibliothek](http://www.hab.de/de/home/bibliothek/digitale-bibliothek-wdb.html). Bestände von Projekten und digitalen
Sammlungen anderer Bibliotheken sowie zusätzliche Ground-Truth-Daten, die
zusammen mit Modulprojekten erarbeitet werden, können in Abstimmung mit dem
OCR-D-Koordinierungsgremium in das Korpus als spezielle Erweiterungen
aufgenommen werden. Sollten zusätzliche Annotationen oder Texte notwendig sein,
können diese in Abstimmung erstellt werden.

## Annotationstiefe, Textgenauigkeit und Artefakte

Das Ground-Truth-Korpus bietet drei Annotationstiefen an:

* Strukturregionen, Textzeilen, Wortkoordinaten
* Strukturregionen, Textzeilen
* Textzeilen

[Zur Übersicht](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit)

Die Spezialkorpora umfassen:

* Spezialkorpus von Daten geringerer Textgenauigkeit (schmutzige OCR), kann für einzelne Vergleiche und Evaluationen herangezogen werden.
* Spezialkorpus Artefakte: Dieses Korpus beinhaltet ausschließlich Objekte die Störungen aufweisen.
[Zur Übersicht](https://docs.google.com/spreadsheets/d/1sS9bmPFo6UjRysO6Q-bGSOAFOR41m6dyiIOvgg6ajLg/edit#gid=0)

## Erstellung des Ground Truth

Die Image-Daten wurden mittels Transkribus und Aletheia zunächst einer Layout-Analyse
unterzogen und anschließend automatisiert segmentiert. Der so automatisch segmentierte Text (Wörter) sowie die Zeilen und Textregionen wurden manuell bearbeitet. Abschließend wurde ein Datenpaket aus den Daten im PAGE-Format, den digitalen Bildern und einem METS-Metadatensatz als Bagit-Datei gepackt.

**Wenn Sie Interesse an weiteren Ground-Truth-Daten haben (bspw. zur
Binarisierung) schreiben Sie uns bitte: [hinrichsen[at]hab.de](mailto:hinrichsen@hab.de)**

Die Daten unterliegen einer CC-BY-SA-Lizenz, für die Verwendung der Bilddaten
können abweichende Lizenzen vorliegen. Bitte [kontaktieren Sie](contact) diesbezüglich das
Projekt und/oder die besitzende Bibliothek.

# OCR-D Forschungsdatenrepositorium
Der OCR-D-Forschungsdatenspeicher sammelt alle Versionen von Dokumenten und (Zwischen-)Ergebnissen, die während der Dokumentenanalyse erstellt wurden. Es enthält mindestens die Endergebnisse jedes verarbeiteten Dokuments. Während der Aufnahme werden viele Metadaten über das Dokument extrahiert und für die Suche/Filterung zur Verfügung gestellt (z.B. Identifizierer, Titel, Klassifikation(en), Genre(s), semantische Bezeichnung(en), verwendete Prozessor(en), Text). In Zukunft wird es möglicherweise auch Exportoptionen für bestimmte Werkzeuge geben.

# OCR-D Ground Truth Repositorium
Ebenso gibt es ein öffentlich zugängliches OCR-D Repositorium, das alle von OCR-D bereitgestellten Ground Truth Daten enthält. 
* Weitere Informationen über das Metadatenformat finden Sie unter [https://github.com/OCR-D/gt-labelling](https://github.com/OCR-D/gt-labelling)
* Das Repository selbst ist unter [https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search](https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search) verfügbar.
