---
layout: page
lang: de
lang-ref: glossary.md
toc: true
title: OCR-D Glossar
---

# OCR-D Glossar

> Glossar von Begriffen aus dem Bereich der Bildverarbeitung/OCR und deren Verwendung im Rahmen von OCR-D

## Layout und Typografie

### Border

Aus der [PAGE XML-Dokumentation](https://ocr-d.de/de/gt-guidelines/pagexml/pagecontent_xsd_Complex_Type_pc_BorderType.html)

> Rand der eigentlichen Seite (wenn das gescannte Bild Teile enthält, die nicht zur Seite gehören)

### Glyphe

In OCR-D ist eine Glyphe die atomare Einheit innerhalb eines [Wortes](#wort).

### Grapheme Cluster

Siehe [Glyphe](#glyph)

### Lesereihenfolge (Reading Order)

Die Lesereihenfolge beschreibt die logische Abfolge von [Regionen](#region) innerhalb eines Dokuments, wie sie von einem Menschen gelesen wird. Marginalien, Tabellen, Fußnoten und andere Elemente, die nicht in einer bestimmten Reihenfolge gelesen werden, sind nicht zwingend in der Beschreibung der Lesereihenfolge enthalten.

### Line

Siehe [TextLine](#textzeile)

### PrintSpace

Aus der [PAGE XML-Dokumentation](https://ocr-d.de/de/gt-guidelines/pagexml/pagecontent_xsd_Complex_Type_pc_PrintSpaceType.html)

> Bestimmt die effektive Fläche einer gedruckten Seite auf dem Papier. [,,,]
>
> Sie enthält alle lebenden Elemente (außer Marginalien) wie Absätze und Überschriften sowie Fußnoten, Überschriften, laufende Titel.
>
> Sie enthält keine Seitenzahlen (wenn sie nicht Teil des laufenden Titels sind), Marginalien, Bogensignatur, Kustoden.

### Region

Eine Region wird durch ein Polygon innerhalb einer Seite beschrieben.

### Region type

Die Semantik oder Funktion einer [Region](#region) wie Überschrift, Seitenzahl, Spalte, Tabelle...

### Satzspiegel
Siehe [PrintSpace](#printspace)

### Schriftfamilie

Innerhalb von OCR-D bezieht sich *Schriftfamilie* auf die Gruppierung von Elementen nach Schriftähnlichkeit. Die Semantik einer *Schriftfamilie* bleibt denen überlassen, von denen die Daten erstellt werden.

### Symbol

Siehe [Glyphe](#glyphe)

### Textzeile

Eine Textzeile ist eine Reihe von [Wörtern](#wort) innerhalb einer Text-[Region](#region). (Je nach Ausrichtung der Region oder der Seite und je nach Schreibrichtung der Schrift kann sie horizontal oder vertikal sein).

### Wort

Ein Wort ist eine Folge von [Glyphen](#glyphe) innerhalb einer [Zeile](#textzeile), die keine wortbegrenzenden Leerzeichen enthält. (Das heißt, es schließt Interpunktion ein und ist ein Synonym für _token_ im NLP.)

### Zeile

Siehe [Textzeile](#textzeile)

## Daten

### Ground Truth

Ground Truth (GT) [im Kontext von OCR-D](https://ocr-d.de/de/daten.html) sind
Transkriptionen, spezifische Strukturbeschreibungen und Wortlisten. Diese sind
sind im PAGE XML-Format in Kombination mit dem Originalbild verfügbar.
Wesentliche Teile der GT wurden manuell erstellt.

Wir unterscheiden verschiedene Nutzungsszenarien für GT:


#### Evaluierungsdaten

Evaluierungsdaten dienen der quantitativen und qualitativen Bewertung der Leistung von OCR-Werkzeugen und/oder -Algorithmen. Da diese Daten zur Bewertung genutzt werden, können sie nicht mit dem selben OCR-Werkzeug erstellt werden wie die zu evaluierenden Daten, sondern müssen in einem kontrollierten und nachvollziehbaren Verfahren erstellt werden. Der manuelle Anteil an der Erstellung kann dabei bis zu 100% betragen. Je nach Zweck der Evaluation braucht man entsprechend annotierte Evaluierungsdaten. Wenn man beispielsweise einen Algorithmus zur Segmentierung von Regionen evaluieren möchte, benötigt man Evaluierungsdaten mit annotierten Regionen.

#### Referenzdaten

Mit dem Begriff Referenzdaten bezeichnen wir Daten, die verschiedene Stadien eines OCR/OLR-Prozesses an repräsentativen Materialien veranschaulichen. 
Sie sollen die Bewertung von häufig auftretenden Schwierigkeiten und Herausforderungen bei der Durchführung bestimmter Analysevorgänge unterstützen und werden daher auf allen Ebenen manuell kommentiert.

#### Trainingsdaten

Viele OCR-Tools müssen an den spezifischen Bereich der zu bearbeitenden Werke angepasst werden. Diese Anpassung an den Bereich wird als Training bezeichnet. Die Daten, die zur Steuerung dieses Prozesses verwendet werden, nennt man Trainingsdaten. Es ist wichtig, dass die Teile dieser Daten, die dem Trainingsalgorithmus zugeführt werden, manuell erfasst werden und möglichst fehlerfrei sind.

## Verarbeitungsschritte

### Binarisierung

Binarisierung bedeutet die Umwandlung aller Farb- oder Graustufenpixel eines Bildes in Schwarz oder Weiß.

Controlled Term: `binarized` (`comments` einer mets:file), `preprocessing/optimization/binarization` (`step` in ocrd-tool.json)

Siehe [Felix Niklas' interaktive Demo](http://felixniklas.com/imageprocessing/binarization)

### Border removal

siehe [Cropping](#cropping)

### Cropping

Erkennung des Satzspiegels auf einer Seite, im Gegensatz zu den Rändern. Dies ist eine Form der
[Regionensegmentierung](#regionensegmentierung).

Controlled Term: `preprocessing/optimization/cropping`.

### Deskewing

Ein Bild so drehen, dass die meisten Textregionen aufrecht (d.h. von links nach rechts, von oben nach unten lesbar) und gerade (d.h. nicht schief) liegen.

Controlled Term: `preprocessing/optimization/deskewing`

### Despeckling

Artefakte wie Flecken, Tintenkleckse, Unterstreichungen usw. aus einem Bild entfernen. Wird üblicherweise angewendet, um 
"Salz-und-Pfeffer"-Rauschen zu entfernen, das durch [Binarisierung](#binarisierung) entstanden ist.

Controlled Term: `preprocessing/optimization/despeckling`

### Dewarping

Ein Bild so bearbeiten, dass alle Textzeilen begradigt und alle geometrischen Verzerrungen korrigiert sind.

Controlled Term: `preprocessing/optimization/dewarping`

Siehe [Matt Zuckers Eintrag zu Dewarping](https://mzucker.github.io/2016/08/15/page-dewarping.html).

### Dokumentenanalyse

Die Dokumentenanalyse ist die Erkennung von Strukturen auf Dokumentenebene, um z.B. ein Inhaltsverzeichnis zu erstellen.

### Font-Identifizierung

Erkennung der im Dokument verwendete(n) Schrift(en), entweder vor oder nach einem OCR-Prozess.

Controlled Term: `recognition/font-identification`

### Glyph segmentation

Eine [Textzeile](#textzeile) in [Glyphen](#glyphe) unterteilen.

Controlled Term: `SEG-GLYPH`

### Graustufen-Normalisierung

> ISSUE: [https://github.com/OCR-D/spec/issues/41](https://github.com/OCR-D/spec/issues/41)

Controlled Term:
- `gray_normalized` (`comments` in der Datei)
- `preprocessing/optimization/cropping` (`step` in ocrd-tool.json)

Die Graustufen-Normalisierung ist ähnlich wie die Binarisierung, aber statt eines rein bitonalen
Bildes kann die Ausgabe auch Graustufen enthalten, um zu verhindern, dass versehentlich
Glyphen kombiniert werden, wenn sie sehr nahe beieinander liegen.

### Line recognition

Siehe [OCR](#ocr).

### OCR

Interpretation von Pixelbereichen als [Textregionen](#region), [Zeilen](#textzeile), [Wörter](#wort) und [Zeichen](#glyphe). 
Meint im _engeren Sinne_ die Elementaroperation des Mustererkenners (welche früher auf Zeichen, heute auf ganzen Wörtern oder Zeilen angewandt wird), 
im _weiteren Sinne_ alle dazu vorab nötigen [Verarbeitungsschritte](#verarbeitungsschritte), also auch die [Segmentierung](#segmentierung) in [Satzspiegel](#satzspiegel) 
(d.h. [Cropping](#cropping)), [Regionen](#region) (d.h. [Regionensegmentierung](#regionensegmentierung)) und [Zeilen](#textzeile) (d.h. [Zeilensegmentierung](#zeilensegmentierung)).

### Regionenklassifikation

Bestimmung des [Typs](#region-type) einer erkannten Region.

### Regionensegmentierung

Segmentiert ein Bild in [Regionen](#region). Bestimmt auch, ob es sich um eine Text oder Nicht-Text-Region (z.B. Bilder) handelt.

Controlled Term:
- `SEG-REGION` (`USE`)
- `layout/segmentation/region` (`step` in ocrd-tool.json)

### Segmentierung

Segmentierung bedeutet die Erkennung von Bereichen innerhalb eines Bildes.

Spezifische Segmentierungsalgorithmen werden durch die Semantik der Regionen gekennzeichnet die sie erkennen, und nicht nach der Semantik der Eingabe, d. h. ein Algorithmus, der Regionen erkennt, 
wird [Regionensegmentierung](#regionensegmentierung) genannt.

### Textoptimierung

Die Textoptimierung umfasst die Manipulationen am Text anhand der Schritte
bis hin zur Texterkennung. Dazu gehören die (halb-)automatische Korrektur von
Erkennungsfehlern, orthografische Vereinheitlichung, Korrektur von Segmentierungsfehlern usw.

### Texterkennung

Siehe [OCR](#ocr).

### Wortsegmentierung

Segmentierung einer [Textzeile](#textzeile) in [Wörter](#wort).

Controlled Term:
- `SEG-LINE` (`USE`)
- `layout/segmentation/word` (`step` in ocrd-tool.json)

### Zeilensegmentierung
Segmentiert [Textregionen](#region) in [Textzeilen](#textzeile).

Controlled Term:
- `SEG-LINE` (`USE`)
- `layout/segmentation/line` (`step` in ocrd-tool.json)

## Datenpersistenz

### Forschungsdaten-Repository

Das Forschungsdaten-Repository kann die Ergebnisse aller [Verarbeitungsschritte](#verarbeitungsschritte) während der Dokumentenanalyse enthalten. 
Zumindest enthält es die Endergebnisse jedes verarbeiteten Dokuments und seine vollständige Provenienz. Das Forschungsdaten-Repository muss lokal verfügbar sein.

### Ground-Truth-Repository

Enthält alle [Ground-Truth](#ground-truth)-Daten.

### Modell-Repository

Enthält alle trainierten (OCR-)Modelle für die Texterkennung. Das Modell-Repository muss zumindest lokal verfügbar sein. Idealerweise wird ein öffentlich zugänglicher Modellspeicher
entwickelt werden.

### Software-Repository

Das Software-Repository enthält alle OCR-D-Algorithmen und -Tools, die
während des Projekts entwickelt wurden, einschließlich Tests. Es enthält auch die Dokumentation und
Installationsanweisungen für den Einsatz eines Dokumentenanalyse-Workflows.

### Workspace

Ein Workspace ist eine Repräsentation für ein Dokument im lokalen Dateisystem. 
Er besteht im Wesentlichen aus einem Verzeichnis mit einer Kopie der [METS](https://ocr-d.de/en/spec/mets)-Datei. 
Zusätzlich kann dieses Verzeichnis physische Datendateien und Unterverzeichnisse enthalten, die zu dem Dokument gehören (erforderlich oder durch die OCR-D-Verarbeitung zur Laufzeit erzeugt), 
wie sie von METS über `mets:file/mets:FLocat/@href` und `mets:fileGrp/@USE` referenziert werden. 
Dateien und Unterverzeichnisse ohne Verweis (wie Log- oder Konfigurationsdateien) sind nicht Teil des Workspaces, ebenso wenig wie Verweise auf entfernte Speicherorte. 
Sie können dem Arbeitsbereich hinzugefügt werden, indem sie in der METS-Datei über ihre relativen lokalen Pfadnamen referenziert werden.

## Workflowmodule

Das [OCR-D-Projekt](https://ocr-d.de) hat die verschiedenen Elemente eines OCR-Workflows in sechs abstrakte Module aufgeteilt:
1. [Bildvorverarbeitung](#bildvorverarbeitung)
2. [Layoutanalyse](layoutanalyse)
3. [Texterkennung und -optimierung](#texterkennung-und--optimierung)
4. [Modelltraining](#modelltraining)
5. [Langzeitarchivierung und Persistenz](#langzeitarchivierung-und-persistenz)
6. [Qualitätssicherung](#qualitätssicherung)

### Bildvorverarbeitung 

Manipulation der Eingabebilder für die anschließende [Layoutanalyse](#layoutanalyse) und [Texterkennung](#texterkennung-und--optimierung).

### Langzeitarchivierung und Persistenz

Speicherung der Ergebnisse von OCR und OLR auf unbestimmte Zeit unter Berücksichtigung der Versionierung, mehrerer Durchläufe, Provenienz/Parametrisierung und Bereitstellung des granularen Zugriffs auf diese gespeicherten Snapshots.

### Layoutanalyse

Erkennung von Strukturen innerhalb der Seite.

### Modelltraining

Generierung von Datendateien aus abgeglichenen Ground-Truth-Texten und -bildern zur Konfiguration der Vorhersage von Text- und Layout-Erkennungsprogrammen.

### Texterkennung und -optimierung

Erkennung von Text und Nachkorrektur von Erkennungsfehlern.

### Qualitätssicherung
Bereitstellung von Messgrößen, Algorithmen und Software zur Bewertung der Qualität der [einzelnen Prozesse](#verarbeitungsschritte) innerhalb von OCR-D.

## Komponenten-Architektur

### Messaging

Messagingdienst auf der Grundlage der Publish/Subscribe-Architektur (oder einer ähnlichen Architektur) zur Koordinierung der Netzkomponenten, insbesondere für die Verteilung von Aufgaben und den Lastausgleich sowie für die Übermittlung von [Prozessor](#ocr-d-prozessor)-/[Evaluator](#ocr-d-evaluator)ergebnissen.

### (OCR-D) Applikation

Anwendung, die aus verschiedenen Servern besteht, die [Prozessoren](#ocr-d-prozessor) ausführen können; kann ein Desktop-Computer oder eine Workstation sein, ein verteiltes System, 
das einen Controller und mehrere Verarbeitungsserver umfasst, oder ein HPC-Cluster.

### (OCR-D) Backend

Softwarekomponente eines Servers, die sich mit dem Netzbetrieb befasst; z. B. Python-Bibliothek mit Request-Handlern, die eine Dienstsuche und eine netzfähige Arbeitsbereichsdatenverwaltung implementieren.

### (OCR-D) Controller

OCR-D Server (Implementierung von mindestens *Discovery*-, *Workspace*- und *Workflow*-Diensten), Ausführung von Workflows (ein einzelner Workflow oder mehrere Workflows gleichzeitig), Verteilung von Aufgaben an konfigurierte Verarbeitungsserver, Verwaltung von Workspace-Daten. Sollte auch den Lastausgleich verwalten.

### (OCR-D) Evaluator

Ein Evaluator ist ein Werkzeug, das die einheitliche OCR-D CLI für die Qualitätsbewertung zur Laufzeit implementiert, indem es die Anmerkung eines [Verarbeitungsschrittes](#verarbeitungsschritte) 
(d. h. die Ausgabe eines [Prozessors](#ocr-d-prozessor)) mit einer Qualitätsmetrik bewertet, um eine Metrik zu erhalten, und einen bestimmten Schwellenwert anwendet, um einen vollständigen oder 
teilweisen Erfolg/Fehlschlag zu signalisieren.

### (OCR-D) Module

Softwarepaket/Repository, das einen oder mehrere [Prozessoren](#ocr-d-prozessor) oder [Evaluator](#ocr-d-evaluator) bereitstellt und möglicherweise zusätzliche Funktionsbereiche umfasst (Training, Formatkonvertierung, Erstellung von GT, Visualisierung)

Module können aus mehreren Methoden/Aktivitäten bestehen, die in OCR-D als [Prozessoren](#ocr-d-prozessor) bezeichnet werden. Es gab [acht Modulprojekte](https://ocr-d.de/de/phase2) in der zweiten Phase von OCR-D (2018–2020). In der aktuellen dritten Phase (2021–2024) gibt es [drei Modulprojekte](https://ocr-d.de/de/phase3).

### (OCR-D) Processing-Server

OCR-D-Server (der mindestens *Discovery*- und *Processing*-Dienste implementiert), der einen oder mehrere (lokal installierte) [Prozessoren](#ocr-d-prozessor) oder [Evaluator](#ocr-d-evaluator) 
ausführen kann und Workspacedaten verwaltet; die Implementierer sollten abwägen, ob ein einzelner OCR-D-Processing-Server (mit seitenparalleler Verarbeitung) oder mehrere OCR-D-Processing-Server 
(mit dokumentenparalleler Verarbeitung) oder sogar dedizierte OCR-D-Processing-Server mit GPU/CUDA-Unterstützung am besten für den Anwendungsfall geeignet ist.

### (OCR-D) Prozessor

Ein Prozessor ist ein Werkzeug, das die einheitliche [OCR-D-Befehlszeilenschnittstelle](https://ocr-d.de/en/spec/cli) für die Datenverarbeitung zur Laufzeit implementiert. Das heißt, er führt einen einzelnen [Workflowschritt](#verarbeitungsschritte) oder eine Kombination mehrerer Workflowschritte auf dem [Workspace](https://ocr-d.de/en/user_guide#preparing-a-workspace) (dargestellt durch lokale [METS](https://ocr-d.de/en/spec/mets)) aus, wobei er Eingabedateien für alle oder angeforderte physische Seiten der fileGrp(s) liest und Ausgabedateien für sie in die Output-fileGrp(s) schreibt. Er kann eine Reihe von optionalen oder obligatorischen [Parametern](https://ocr-d.de/en/spec/ocrd_tool) erwarten.

→ [OCR-D Workflow Guide](https://ocr-d.de/en/workflows)

### (OCR-D) Server

Konkrete Implementierung einer Teilmenge von OCR-D-Diensten oder der Netzwerk-Host, der sie bereitstellt.

### (OCR-D) Service

Gruppe von Endpunkten der OCR-D Web-API; discovery/workspace/processing/workflow/...

### OCR-D Web API

Wie in [OCR-D/spec#173](https://github.com/OCR-D/spec/pull/173) vorgeschlagen, definiert die OCR-D-Web-API einheitliche und voneinander abhängige Dienste, die je nach Anwendungsfall auf Netzkomponenten verteilt werden können.

### OCR-D Workflow

Kombination von [Verarbeitungsschritten](#verarbeitungsschritte) über konkrete [Prozessoren](#ocr-d-prozessor) und [Evaluatoren](#ocr-d-evaluator) und deren Parametrisierung als Sequenz oder Verband konfiguriert, abhängig von deren Erfolg oder Misserfolg. Implementiert in der [OCR-D Workflow Runtime Library](#ocr-d-workflow-runtime-library) und serialisierbar in einem noch zu spezifizierenden Format.

Der Begriff *Workflow* wird in anderen Kontexten so verstanden, dass er mehr Funktionen umfasst, wie z.B. manuelle Eingriffe durch den Benutzer. Im Gegensatz zur Terminologie in Workflow-Engines wie Taverna oder Digitalisierungs-Frameworks wie Kitodo ist ein OCR-D-Workflow ein vollautomatischer Prozess.

### (OCR-D) Workflow Engine

Zentrale Softwarekomponente des Controllers, die Arbeitsabläufe, einschließlich Kontrollstrukturen (linear/parallel/inkrementell), ausführt. Wird auch bei CLI-Einsätzen auf einem einzigen Host benötigt (wo es allein auf Interprozesskommunikation und Dateisystemein- und -ausgabe beruhen kann), z. B. `ocrd process`.

### (OCR-D) Workflow Runtime Library

Softwarekomponente eines Servers oder Prozessors, die sich mit der Modellierung von OCR-Systemen befasst; z.B. Python-Bibliothek in [OCR-D/core](https://github.com/OCR-D/core), die Klassen für alle wesentlichen funktionalen Komponenten (`OcrdPage`, `OcrdMets`, `Workspace`, `Resolver`, `Processor`, `ProcessorTask`, `Workflow`, `WorkflowTask` ...) bereitstellt, einschließlich Mechanismen zur Signalisierung und Orchestrierung von Workflows, auf denen Komponenten (vom Prozessor bis zum Controller) implementiert werden können.
