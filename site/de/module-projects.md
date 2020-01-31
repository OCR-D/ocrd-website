---
layout: page
lang: de
lang-ref: module-projects
---

# Modulprojekte

Aus den Projektanträgen für die Modulprojektausschreibung der DFG im März 2017 wurden acht Projekte bewilligt:

*   [Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Bildoptimierung](# Bildoptimierung)
*   [Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Layouterkennung](# Layouterkennung)
*   [Weiterentwicklung eines semi-automatischen Open-Source-Tools zur Layout-Analyse und Regionen-Extraktion und -Klassifikation (LAREX) von frühen Buchdrucken](# Larex)
*   [NN/FST – Unsupervised OCR-Postcorrection based on Neural Networks and Finite-state Transducers](# NN-FST)
*   [Optimierter Einsatz von OCR-Verfahren – Tesseract als Komponente im OCR-D-Workflow](# Tesseract)
*   [Automatische Nachkorrektur historischer OCR-erfasster Drucke mit integrierter optionaler interaktiver Korrektur](# PoCoTo)
*   [Entwicklung eines Modellrepositoriums und einer Automatischen Schriftarterkennung für OCR-D](# Schriftarterkennung)
*   [OLA-HD – Ein OCR-D-Langzeitarchiv für historische Drucke](# OLA-HD)

<a id=" Bildoptimierung" name=" Bildoptimierung">**Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Bildoptimierung**</a>  
_Deutsches Forschungszentrum für Künstliche Intelligenz (DFKI)_

Das Projekt “Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke” hat die Entwicklung eines vollständigen OCR-Workflows für eine qualitativ hochwertige Massendigitalisierung historischer Drucke des 16\. - 18\. Jhd. als Ziel. Dabei sollen für alle Arbeitsschritte des Workflows innovative Methoden als Werkzeug bereitgestellt werden. Teilaufgabe 1.B “Bildoptimierung” bildet die Grundlage, welche im Anschluss eine hochqualitative OCR ermöglicht. Für die benötigten Bearbeitungsschritte stehen eine Vielzahl von Methoden zur Verfügung, aber nicht alle sind für die speziellen Anforderungen dieses Projekts, für historische Drucke, geeignet. Auf Basis eigener Erfahrungen und Arbeiten mit Bildoptimierungsmethoden plant das DFKI die Identifizierung, Entwicklung und Integrierung geeigneter Algorithmen.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394343055)

<a id=" Layouterkennung" name=" Layouterkennung">**Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Layouterkennung**</a>  
_DFKI_

Git-Hub: [https://github.com/mjenckel/OCR-D-LAYoutERkennung/tree/master](https://github.com/mjenckel/OCR-D-LAYoutERkennung/tree/master)

Das Projekt “Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke” hat die Entwicklung eines vollständigen OCR-Workflows für eine qualitativ hochwertige Massendigitalisierung historischer Drucke des 16\. - 18\. Jhd. als Ziel. Dabei sollen für alle Arbeitsschritte des Workflows innovative Methoden als Werkzeug bereitgestellt werden. Modul 2 “Layouterkennung” ist neben der OCR der wichtigste Bearbeitungsschritt. Eine korrekte Layouterkennung kann nicht nur die Ergebnisse im Anschließenden OCR verbessern, sondern trägt mit Informationen über Layout und Zusammenhang der einzelnen Textelemente, auch maßgeblich zum Verständnis des digitalisierten Dokuments bei. Für die benötigten Bearbeitungsschritte stehen eine Vielzahl von Methoden zur Verfügung, aber nicht alle sind für die speziellen Anforderungen dieses Projekts, für historische Drucke, geeignet. Auf Basis eigener Erfahrungen und Arbeiten im Bereich der Layoutanalyse plant das DFKI die Identifizierung, Entwicklung und Integrierung geeigneter Algorithmen.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394346204)

<a id=" Larex" name=" Larex">**Weiterentwicklung eines semi-automatischen Open-Source-Tools zur Layout-Analyse und Regionen-Extraktion und -Klassifikation (LAREX) von frühen Buchdrucken**</a>  
_Julius-Maximilians-Universität Würzburg  
  Institut für Informatik: Lehrstuhl für Künstliche Intelligenz und angewandte Informatik_

Git-Hub: [https://github.com/ocr-d-modul-2-segmentierung](https://github.com/ocr-d-modul-2-segmentierung)

Ziel des Antrags ist die Weiterentwicklung unseres effizienten, semi-automatischen und leicht zu bedienenden Open Source Segmentierungs-Tool LAREX und seine Einbindung in den Open Source Digitalisierungs-Workflow im OCR-D Funktionsmodell. Das in den Vorarbeiten erstellte Tool LAREX (Layout Analysis and Region EXtraction) ermöglicht sowohl eine Grobsegmentierung mittels Trennung von Text und Nicht-Text als auch eine Feinsegmentierung durch die Erkennung und semantische Klassifikation unterschiedlicher Textblöcke. LAREX basiert auf einer effizienten Implementierung des Connected Component Ansatzes. Es kam bereits bei der Digitalisierung verschiedener früher Drucke zum Einsatz und konnte dabei stets die für eine qualitativ hochwertige Seitensegmentierung benötigte Zeit signifikant reduzieren.Das Hauptziel der Weiterentwicklung von LAREX besteht darin, den Automatisierungsgrad zu erhöhen. Dazu sind eine robustere Segmentierung und eine Weiterentwicklung des Regel- und Constraintsystems vonnöten. Dafür sollen einerseits die Nutzer über eine deklarative Regelsprache und andererseits Lernalgorithmen Anpassungen der Grundeinstellungen an die Besonderheiten einzelner Werke vornehmen und evaluieren können. Weiterhin wird die komfortable Benutzungsoberfläche von LAREX zur Korrektur einzelner Segmentierungsfehler weiterentwickelt, die auch zur Erstellung einer Ground Truth für Lernalgorithmen bzw. zur Evaluation notwendig ist. Das übergeordnete Ziel ist, eine optimale Kombination zwischen manuellen und automatischen Verfahren zu finden. Das Tool und das Vorgehensmodell soll mit zahlreichen Kooperationspartnern gründlich evaluiert werden, insbesondere auch im Gesamtkontext der Digitalisierung von frühen Drucken im OCR-D Funktionsmodell einschl. der anschließenden OCR durch Anbindung von externen Tools.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394329162)

<a id=" NN-FST" name=" NN-FST">**NN/FST – Unsupervised OCR-Postcorrection based on Neural Networks and Finite-state Transducers**</a>  
_Universität Leipzig  
  Institut für Informatik: Abteilung Automatische Sprachverarbeitung_

Git-Hub: [https://github.com/ASVLeipzig/cor-asv-fst](https://github.com/ASVLeipzig/cor-asv-fst)

Im Projekt NN/FST sollen einsatzfähige Software-Lösungen für das Modul 3 Textoptimierung für das OCR-D Funktionsmodell entwickelt werden. Schwerpunkt der Entwicklungen liegen im Bereich 3.B (Nachkorrektur), wobei deren Einsatz im Zusammenhang mit verschiedenen aktuellen OCR-Systemen (Bereich 3.A) evaluiert wird. Als maßgebliche Technologien werden Neuronale Netze (NN) gemeinsam mit endlichen Transduktoren (FST) zur Dekodierung erkannter Textzeilen in einem Noisy-Channel-Modell eingesetzt.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394341797)

<a id=" Tesseract" name=" Tesseract">**Optimierter Einsatz von OCR-Verfahren – Tesseract als Komponente im OCR-D-Workflow**</a>  
_Universität Mannheim  
  Universitätsbibliothek Mannheim_

Git-Hub: [http://github.com/tesseract-ocr/tesseract/](http://github.com/tesseract-ocr/tesseract/ "http://github.com/tesseract-ocr/tesseract/")

Tesseract ist eine freie Software für die Texterkennung (optische Zeichenerkennung, OCR). Diese Software zeichnet sich durch eine mehr als 30-jährige stetige Weiterentwicklung aus. In der Gruppe Open Source Software gehört Tesseract zu den Programmen mit den besten Erkennungsraten.Seit Ende 2016 unterstützt Tesseract auch die Texterkennung mittels künstlicher neuronaler Netze (LSTM) und ist damit technologisch aktuell.Das Projekt erweitert bzw. ergänzt Tesseract um Schnittstellen für die Einbindung in einen OCR Gesamt-Workflow gemäß OCR-D Modulbeschreibung (Kommandozeile, API, REST-basierter Webservice). Darüber hinaus ist unser Ziel, die Stabilität, Performance und praktische Einsetzbarkeit weiter zu verbessern.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394264782)

<a id=" PoCoTo" name=" PoCoTo">**Automatische Nachkorrektur historischer OCR-erfasster Drucke mit integrierter optionaler interaktiver Korrektur**</a>  
_Ludwig-Maximilians-Universität München  
  Centrum für Informations- und Sprachverarbeitung (CIS)_

Git-Hub: [https://github.com/cisocrgroup/ocrd-postcorrection](https://github.com/cisocrgroup/ocrd-postcorrection), [https://github.com/cisocrgroup/cis-ocrd-py](https://github.com/cisocrgroup/cis-ocrd-py)

Bei der Volltextdigitalisierung historischer Drucke mittels OCR besteht nach wie vor ein signifikanter Verbesserungsbedarf, der den allgemeinen Hintergrund der DFG-Ausschreibung ,,Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke`` darstellt. In Modul 3 der Ausschreibung wird speziell die Notwendigkeit eines Systems zur Nachkorrektur OCR-erfasster historischer Texte begründet. In unserer Arbeitsgruppe wurde über mehrere Jahre hinweg ein sehr leistungsfähiges System ,,PoCoTo'' zur interaktiven Nachkorrektur OCR-erfasster historischer Drucke entwickelt. Für die Massendigitalisierung sollten jedoch aus offenkundigen Gründen zunächst alle Möglichkeiten einer vollautomatischen Korrektur ausgeschöpft werden. Das Hauptproblem bei der automatischen Korrektur besteht darin zu vermeiden, dass nicht im Korrekturlexikon erfasste, aber korrekte OCR-Tokens durch vermeintliche Korrekturen ersetzt werden. Zielsetzung des Antrags ist es, von PoCoTo ausgehend ein leistungsfähiges System zur vollautomatischen Korrektur zu entwickeln, das derartige ,,Verschlimmbesserungen`` weitestgehend vermeidet. Hierzu wird die vorhandene Technologie substantiell erweitert. Da man nicht erwarten kann, dass mit einer vollautomatischen Nachkorrektur immer die erforderlichen extrem hohen Qualitätsstandards erreicht werden, soll die vollautomatische Korrektur auch als Vorstufe einer optional nachgeschalteten semi-automatischen oder interaktiven Nachkorrektur nutzbar sein. Verfahren zur semi-automatischen oder interaktiven Nachkorrektur, die die während der automatischen Korrekturphase gewonnenen Daten und Einsichten ausnützen, sollen direkt im System integriert sein.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/393215159)

<a id=" Schriftarterkennung" name=" Schriftarterkennung">**Entwicklung eines Modellrepositoriums und einer Automatischen Schriftarterkennung für OCR-D**</a> Universität Leipzig  
  _Institut für Informatik: Lehrstuhl für Digital Humanities_  
_Friedrich-Alexander-Universität Erlangen-Nürnberg  
  Department Informatik: Lehrstuhl für Informatik 5: Mustererkennung_  
_Johannes Gutenberg-Universität Mainz  
  Gutenberg-Institut für Weltliteratur und schriftorientierte Medien: Abteilung Buchwissenschaft_

Git-Hub: [https://github.com/Doreenruirui/OCRD](https://github.com/Doreenruirui/OCRD "https://github.com/Doreenruirui/OCRD") , [https://github.com/seuretm/ocrd_typegroups_classifier](https://github.com/seuretm/ocrd_typegroups_classifier)

Das Projekt widmet sich dem Problem, dass OCR für die Massenvolltextdigitalisierung historischer Drucke des 16.–18\. Jahrhunderts, die dank VD16, VD17 und VD18 in immer größerer Zahl als Bilddigitalisate vorliegen, mit stark variierenden Erkennungsquoten bisher nur eingeschränkt verwendbar ist. Ein wichtiger Grund ist, dass Erkennungsmodelle entweder auf Basis moderner Korpora trainiert werden, die die Spezifika historischer Drucke nicht abbilden, oder auf Basis ungefilterter historischer Korpora, deren große Bandbreite verwendeter Schriftarten, Zeichensätze etc. ein passgenaues Training ausschließt und damit auch Erkennungsquoten verhindert, wie sie inzwischen für Bilddigitalisate moderner Vorlagen möglich sind. Die Bildung von schriftartspezifischen Korpora auf Basis händischer Zuweisung ist nicht realistisch, da dafür nicht triviale Kenntnisse der Druckgeschichte vonnöten sind und eine derartige Vorgehensweise schlecht skaliert. Aufgrund der repetitiven Aufgabe ist dies auch sehr fehleranfällig. Das Projekt möchte den historisch arbeitenden Geisteswissenschaften ermöglichen, OCR mit überschaubarem Aufwand schriftartspezifisch zu verwenden, d.h. für die Schriftart passgenaue OCR durchzuführen. Dafür verfolgt das Projekt drei Teilziele:Die Entwicklung einer Online-Trainingsinfrastruktur, die es ermöglicht, für diese Schriftartgruppen spezifische Modelle mit überschaubarem Aufwand online und gleichzeitig für verschiedene OCR-Software zu trainieren.Entwicklung eines Tools zur automatischen Erkennung von Schriftarten in Bilddigitalisaten historischer Drucke. Hier wird zunächst mithilfe der im Typenrepertorium der Wiegendrucke vorliegenden Ground Truth ein Algorithmus für die Erkennung von Schriften in Inkunabeln trainiert. In einem zweiten Schritt werden die Schriftarten nach Ähnlichkeit so gruppiert, dass bei möglichst geringer Anzahl von Gruppierungen die OCR-Genauigkeit nicht wesentlich reduziert wird.Bereitstellung eines Modellrepositoriums, in dem erarbeitete schriftartspezifische OCR-Modelle der Community zur Verfügung gestellt werden.  
Qelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394448308)

<a id=" OLA-HD" name=" OLA-HD">**OLA-HD – Ein OCR-D-Langzeitarchiv für historische Drucke**</a>  
_Georg-August-Universität Göttingen  
  Niedersächsische Staats- und Universitätsbibliothek_  
_Gesellschaft für Wissenschaftliche Datenverarbeitung mbH Göttingen_

Git-Hub: [https://github.com/subugoe/OLA-HD-IMPL](https://github.com/subugoe/OLA-HD-IMPL)

Um im Bereich der historisch arbeitenden Wissenschaften hochwertige und umfangreiche Forschung leisten zu können, ist ein möglichst uneingeschränkter Zugriff auf historische Quellen unerlässlich. Durch mehrere Erschließungs- und Digitalisierungsprojekte stehen mittlerweile zahlreiche Digitalisate von historischen Drucken aus dem 16\. bis zum 19\. Jahrhundert zur Verfügung. Insbesondere im Rahmen der „Verzeichnisse Deutscher Drucke” wurde nicht nur die serielle Erschließung, sondern auch die massenhafte Digitalisierung von Titeln vorangetrieben. Diese Werke sind nach nationalbibliographischen Standards katalogisiert worden und zu großen Teilen bereits digitalisiert worden. Der bibliographische Metadatenstandard dieser Digitalisate wird den wissenschaftlichen Anforderungen bereits gerecht. Es ist nun entscheidend, auch die Volltexte der digitalisierten Werke gezielt durchsuchen und weiter verwenden zu können. Die Techniken der Optical-Character-Recognition (OCR) ermöglichen hier das massenhafte Erstellen von Volltexten. Für die unmittelbare Nutzung in Bibliotheken, Archiven und anderen Einrichtungen waren die bisher angewandten Methoden jedoch nicht geeignet, da die Texte zu große orthographische Unterschiede aufweisen. Es wird intensiv an leicht übertragbaren Anwendungen gearbeitet, die eine qualitativ hochwertige Massenvolltexterschließung aller historischen Drucke aus dem o.g. Zeitraum zu ermöglichen. Dies erhöht die Anzahl der OCR-Texte rasant.Für die weitere Nutzung ist eine nachhaltige Archivierung und Identifizierung der Digitalisate, der bibliographischen Metadaten sowie der erschlossenen Volltexte und deren Versionen notwendig. Um dies gewährleisten zu können, muss ein standardisiertes Konzept erstellt werden. Darüber hinaus ist die Verfügbarkeit und die Zitierfähigkeit der OCR-Texte eine wichtige Voraussetzung für die Überprüfbarkeit wissenschaftlicher Ergebnisse. Dies bedeutet, dass die bestehende Archivierung eines Objektes mit seinen Struktur- und Metadaten sowie Images um OCR-Texte ergänzt werden muss. Durch die intellektuelle Erschließung, durch Nachbesserungen, durch die Verbesserungen im OCR-Verfahren oder den Einsatz verschiedener OCR-Techniken entstehen verschiedene Versionen des gleichen Ausgangsmaterials, welche eine neue Herausforderung für die persistente Identifizierung und die Langzeitarchivierung darstellen. Diese Problemstellung enthält Aspekte im Zusammenhang mit dem Forschungsdatenmanagement und erfordert auch die Prüfung von Methoden und Strategien für den Umgang mit Forschungsdaten.Die oben genannten Anforderungen müssen konzeptionell aufbereitet, in einen erweiterten Kontext integriert und als technische Lösung implementiert werden, um die Anforderungen der Datenhalter als auch die der Nutzer realisieren zu können. Basierend auf dieser Ausgangslage definiert dieses Vorhaben die notwendigen Schritte zur Realisierung einer Lösung für die Langzeitarchivierung und eine persistente Identifizierung von OCR-Texten.  
Quelle: [GEPRIS](http://gepris.dfg.de/gepris/projekt/394410994)
