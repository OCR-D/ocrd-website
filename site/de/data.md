---
layout: page
lang: de
lang-ref: data
---

#Daten

## Die Referenzdaten

Die Referenzdaten umfassen ein Ground-Truth-Korpus und weitere Spezialkorpora.
Das Ground-Truth-Korpus umfasst Seiten aus Publikationen aus dem Zeitraum 1500
- 1900. Der Inhalt des Korpus basiert auf einer gezielten Auswahl aus dem
Bestand des DFG-Projektes „Deutsches Textarchiv“, der Digitalisierten
Sammlungen der Staatsbibliothek zu Berlin und der Wolfenbütteler Digitalen
Bibliothek der Herzog August Bibliothek. Bestände von Projekten und digitalen
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

[Zur Übersicht](http://www.ocr-d.de/sites/all/GTDaten/IndexGT.html) (Die Liste wird stetig erweitert.)

Die Spezialkorpora umfassen:

* Spezialkorpus von Daten geringerer Textgenauigkeit (schmutzige OCR), kann für einzelne Vergleiche und Evaluationen herangezogen werden.
* Spezialkorpus Artefakte: Dieses Korpus beinhaltet ausschließlich Objekte die Störungen aufweisen.
[Zur Übersicht](https://docs.google.com/spreadsheets/d/1sS9bmPFo6UjRysO6Q-bGSOAFOR41m6dyiIOvgg6ajLg/edit#gid=0)

## Erstellung des Ground Truth

Die Image-Daten wurden mittels Transkribus zunächst einer Layout-Analyse
(Textregion- und Zeilenerkennung) unterzogen und anschließend mit der
integrierten OCR-Engine (ABBYY FineReader 11 SDK) prozessiert. Der so
automatisch erkannte Text sowie die Zeilen und Textregionen wurden manuell
nachkorrigiert (ggf. unter Verwendung von vorhandenen Ground-Truth-Daten) und
schließlich als ALTO- und PAGE-Dateien exportiert. Diese bilden zusammen mit
den Images im TIF-Format den Inhalt der zip-Dateien.

Wenn Sie Interesse an weiteren Ground-Truth-Daten haben (bspw. zur
Binarisierung) schreiben Sie uns bitte: elisabeth.engl[at]hab.de

Die Daten unterliegen einer CC-BY-SA-Lizenz, für die Verwendung der Bilddaten
können abweichende Lizenzen vorliegen. Bitte [kontaktieren Sie](contact) diesbezüglich das
Projekt und/oder die besitzende Bibliothek.

# OCR-D Forschungsdatenrepositorium
Der OCR-D-Forschungsdatenspeicher sammelt alle Versionen von Dokumenten und (Zwischen-)Ergebnissen, die während der Dokumentenanalyse erstellt wurden. Es enthält mindestens die Endergebnisse jedes verarbeiteten Dokuments. Während der Aufnahme werden viele Metadaten über das Dokument extrahiert und für die Suche/Filterung zur Verfügung gestellt (z.B. Identifizierer, Titel, Klassifikation(en), Genre(s), semantische Bezeichnung(en), verwendete Prozessor(en), Text). In Zukunft wird es möglicherweise auch Exportoptionen für bestimmte Werkzeuge geben.

# OCR-D Ground Truth Repositorium
Ebenso gibt es ein öffentlich zugängliches OCR-D Repositorium, das alle von OCR-D bereitgestellten Ground Truth Daten enthält. 
* Weitere Informationen über das Metadatenformat finden Sie unter https://github.com/OCR-D/gt-labelling
* Das Repository selbst ist unter https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search verfügbar.

Similarly, there is a publicly available OCR-D repository, which contains all ground truth data provided by OCR-D. 
* For further information about the metadata format, see https://github.com/OCR-D/gt-labelling
* The repository itself is available at https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search
