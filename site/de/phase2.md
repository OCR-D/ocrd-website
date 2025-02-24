---
layout: page
lang: de
lang-ref: module-projects
toc: true
title: Phase II
---

# Modulprojekte Phase II

Phase II von OCR-D wurde im März 2017 von der DFG bewilligt.

<!--- lief von
bis, Zeiten unklar, ggf. Abschlussbericht verlinken?, klären i.d. Leitungsrunde
--->

<!--- ggf kurze Zusammenfassung der Ergebnisse

Auf Grundlage des Funktionsmodells aus [Phase I] wurden Bedarfe zur (Weiter-)entwicklung von 
Werkzeugen im OCR-Prozess ermittelt und die Voraussetzungen für ihre Umsetzung geschaffen.

Die Werkzeuge hierfür wurden in der zweiten Projektphase in acht Modulprojekten entwickelt. Um die 
Nutzbarkeit und Interoperabilität der verschiedenen Komponenten zu gewährleisten, wurde vom Koordinationsprojekt mit OCR-D/core eine 
Referenzimplementierung in Python zur Verfügung gestellt. 

Der entstandene OCR-D-Prototyp wurde als Open Source Software zur kostenfreien Nutzung und Weiterentwicklung unter Apache 2.0 
auf GitHub bereitgestellt. In Tests durch neun Pilotbibliotheken wurden die Robustheit des Prototypen bestätigt und gute 
Erkennungsergebnisse erzielt.

--->

<!--- [Modulprojekte aus Phase II](originale phase2 umbenennen) --->

[Pilotstudie](https://ocr-d.de/de/teststellung)

## Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Bildoptimierung

<p class="poster-image">
  <a href="/assets/poster/DFKI.pdf">
    <img src="/assets/poster/DFKI.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Deutsches Forschungszentrum für Künstliche Intelligenz (DFKI)_

Das DFKI war als Projektpartner im OCR-D Projekt mit zwei Modulen vertreten:
Bildoptimierung und Layouterkennung. In beiden Modulen wurden mehrere
Prozessoren entwickelt und in das OCR-D-Softwaresystem integriert.

Das erste Modul-Projekt _Bildoptimierung_ fokussierte sich auf die
Vorverarbeitung der Digitalisate mit dem Ziel, die Bildqualität und somit auch
die Performanz der nachfolgenden OCR-Module zu verbessern. Dafür wurden
Werkzeuge für die Binarisierung, das Deskewing, das Cropping und das Dewarping
implementiert. 

Das auf Computer Vision basierte Cropping-Werkzeug ist als besonders performant
hervorzuheben. Es erzielt auf den gesamten Projektdaten vorwiegend sehr gute
Ergebnisse. Auch das Dewarping-Werkzeug ist aufgrund seiner neuartigen
Architektur interessant. Mit Hilfe generativer neuronaler Netze werden
entzerrte Varianten von Bildern generiert, anstatt explizite Transformationen
für die Entzerrung zu bestimmen.

## Skalierbare Verfahren der Text- und Strukturerkennung für die Volltextdigitalisierung historischer Drucke: Layouterkennung  

<p class="poster-image">
  <a href="/assets/poster/DFKI.pdf">
    <img src="/assets/poster/DFKI.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_DFKI_

GitHub: [mjenckel/OCR-D-LAYoutERkennung/tree/master](https://github.com/mjenckel/OCR-D-LAYoutERkennung/tree/master)

Im zweiten Modul-Projekt des DFKI _Layouterkennung_ galt es, die
Dokumentstruktur, sowohl einzelner Dokumentseiten als auch im Gesamtdokument,
zu extrahieren. Die dabei gewonnenen Metadaten helfen zum einen, das Dokument
als Ganzes zu digitalisieren, zum anderen ist das Extrahieren bestimmter
Dokumentstrukturen notwendig. Die meisten OCR-Methoden können z.B. nur einzelne
Textzeilen verarbeiten. Die entwickelten Werkzeuge dienen der
Text-Nicht-Text-Segmentierung, der Blocksegmentierung und -klassifizierung, der
Textzeilenerkennung sowie der Strukturanalyse.

Ein Entwicklungsschwerpunkt war die kombinierte Blocksegmentierung und
-klassifizierung, welche auf der, aus der Video- und Bildsegmentierung
bekannten, MaskRCNN-Architektur basiert. Dieses Werkzeug arbeitet mit den
unbearbeiteten Rohdaten, sodass einerseits keine Vorverarbeitung notwendig ist
und andererseits das volle Informationsspektrum ausgenutzt werden kann.

## Weiterentwicklung eines semi-automatischen Open-Source-Tools zur Layout-Analyse und Regionen-Extraktion und -Klassifikation (LAREX) von frühen Buchdrucken

<p class="poster-image">
  <a href="/assets/poster/Wuerzburg.pdf">
    <img src="/assets/poster/Wuerzburg.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Julius-Maximilians-Universität Würzburg_ <br/>
_Institut für Informatik: Lehrstuhl für Künstliche Intelligenz und angewandte Informatik_

GitHub: [ocr-d-modul-2-segmentierung](https://github.com/ocr-d-modul-2-segmentierung)

Am Lehrstuhl für Informatik VI der Uni Würzburg wurde in den Vorarbeiten LAREX
entwickelt, ein komfortabler Editor zur Annotation von Regionen und
Layout-Elementen auf Buchseiten. Bei der Weiterentwicklung im
OCR-D-Modulprojekt lag der Schwerpunkt neben der Verbesserung der effizienten
Bedienbarkeit vor allem auch in dem Ausbau der automatischen Verfahren.

Hierzu wurde ein Convolutional-Neural-Net (CNN) implementiert und trainiert,
welches jedem Pixel eines Seitenscans eine Einordnung in verschiedene Klassen
zuweist, um so Bild und Text zu trennen. Unter Betrachtung der Pixel je nur
einer Klasse wird anschließend mit klassischen Verfahren eine Segmentierung der
Seite durchgeführt. Ein weiterer getesteter Ansatz nutzte zuerst klassische
Segmentierungsverfahren und ordnete die Segmente anschließend ein.

Das auf der CNN-Ausgabe basierende Segmentierungsverfahren wurde an die
OCR-D-Schnittstellen angepasst. Auf reinen Textseiten oder Seiten mit deutlich
abgetrennten Bildern wurden gute Ergebnisse erzielt. Verbesserungspotential
besteht vor allem bei der Erkennung von Zierinitialen älterer Drucke und
weiteren nah am Text liegenden Bildern sowie mehrspaltigen Layouts.

<div class="is-clearfix"></div>
## NN/FST – Unsupervised OCR-Postcorrection based on Neural Networks and Finite-state Transducers

<p class="poster-image">
  <a href="/assets/poster/Leipzig.pdf">
    <img src="/assets/poster/Leipzig.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Universität Leipzig_  <br/>
 Institut für Informatik: Abteilung Automatische Sprachverarbeitung_

GitHub: [ASVLeipzig/cor-asv-fst](https://github.com/ASVLeipzig/cor-asv-fst)

Eine vollautomatische Nachkorrektur separat von der eigentlichen OCR ist immer
nur dann sinnvoll, wenn dabei statistisches Wissen über “richtigen Text” und
über typische OCR-Fehler _a priori_ hinzukommt. Dafür eignen sich neuronale
Netze (NN) ebenso wie gewichtete endliche Transduktoren (WFST), die auf
entsprechenden zusätzlichen Daten trainiert werden können.

Für die Umsetzung einer kombinierten Architektur aus NN und FST wurde
entschieden, drei Module zu implementieren:
1. eine reine NN-Lösung mit durchgehend (_end-to-end_) trainiertem Modell
  allein auf Zeichenebene – als tiefes (mehrschichtiges), bidirektionales
  rekurrentes Netzwerk nach dem Encoder-Decoder-Schema (für verschiedene
  Eingabe- und Ausgabelänge) mit Attention-Mechanismus und A*-Beamsearch mit
  einstellbarer Rückweisungsschwelle (gegen Überkorrektur), d.h. die
  Nachkorrektur von Textzeilen wird wie maschinelle Übersetzung behandelt,
2. ein NN-Sprachmodell (LM) auf Zeichenebene – als tiefes (mehrschichtiges),
  bidirektionales rekurrentes Netzwerk mit Schnittstelle für Graph-Eingabe
  und inkrementeller Dekodierung,
3. eine WFST-Komponente mit explizit zu trainierendem Fehlermodell auf
  Zeichenebene und Wortmodell/Lexikon, sowie Anbindung an 2. – per
  WFST-Komposition von Eingabegraph mit Fehler- und Wortmodell nach
  Sliding-Window-Prinzip, Konversion der Einzelfenster zu einem
  Hypothesengraph pro Textzeile, und Kombination der jeweiligen
  Ausgabegewichte mit LM-Bewertungen in einer effizienten Suche nach dem
  besten Pfad.

Die Kombination von 3. mit 2. stellt also eine hybride Lösung dar. Aber auch 1.
kann von 2. profitieren (sofern die gleiche Netzwerk-Topologie benutzt wird),
indem die Gewichte aus einem auf größeren Mengen reinem Text trainierten
Sprachmodell initialisiert werden (Transfer-Learning).

Beide Ansätze profitieren von einer engen Anbindung an den OCR-Suchraum, d.h.
eine Übergabe alternativer Zeichen-Hypothesen und ihrer Konfidenz (wie bisher
nur mit Tesseract möglich und in Zusammenarbeit mit dem Modulprojekt der UB
Mannheim realisiert). Sie liefern aber auch auf reinem Volltext bereits gute
Ergebnisse (mit CER-Reduktion von bis zu 5%), sofern genügend passende
Trainingsdaten zur Verfügung stehen und die OCR ihrerseits brauchbare
Ergebnisse (unterhalb 10% CER) liefert.

Für alle Module stehen Kommandozeilen-Schnittstellen für Training und
Evaluierung, sowie volle OCR-D-Schnittstellen für Prozessierung und Evaluierung
zur Verfügung.

<div class="is-clearfix"></div>

## Optimierter Einsatz von OCR-Verfahren – Tesseract als Komponente im OCR-D-Workflow

<p class="poster-image">
  <a href="/assets/poster/Mannheim.pdf">
    <img src="/assets/poster/Mannheim.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Universität Mannheim_<br/>
_Universitätsbibliothek Mannheim_

GitHub: [tesseract-ocr/tesseract/](http://github.com/tesseract-ocr/tesseract/ "http://github.com/tesseract-ocr/tesseract/")

Im Fokus des Modulprojekts stand die OCR-Software Tesseract, die seit 1985 von
Ray Smith entwickelt wurde, seit 2005 als Open Source unter einer freien
Lizenz.

Das Projekt umfasste zwei Hauptziele: Die Einbindung von Tesseract in den
OCR-D-Workflow inklusive Unterstützung der anderen Modulprojekte durch die
Bereitstellung von Schnittstellen, sowie die allgemeine Verbesserung der
Stabilität, Codequalität und Performance von Tesseract.

Die Einbindung in den OCR-D-Workflow erforderte wesentlich weniger Aufwand als
ursprünglich geplant; hauptsächlich, weil die meiste Arbeit bereits außerhalb
des Modulprojekts geleistet war und dabei die schon vorhandene
Python-Schnittstelle tesserocr genutzt werden konnte.

Für das OCR-D-Modulprojekt der Universität Leipzig wurde Tesseract um die
Generierung von alternativen OCR-Ergebnissen für die Einzelzeichen erweitert.
Als Eingabedaten für ein OCR-Postkorrektur-Modell lässt sich damit die
Texterkennung weiter verbessern. Ein wertvoller Nebeneffekt des neuen Codes
sind genauere Zeichen- und Wortkoordinaten.

Mit mehreren hundert Korrekturen konnte die Codequalität signifikant gesteigert
und ein deutlich stabilerer Programmfluss erreicht werden. Tesseract ist jetzt
wartbarer, braucht weniger Speicher und ist schneller als zuvor.

Eine wesentliche Verbesserung der Erkennungsgenauigkeit für die meisten der für
OCR-D relevanten Druckwerke konnte durch neue generische Modelle für Tesseract
erreicht werden. Diese wurden ab Septem-ber 2019 bis Januar 2020 auf Basis der
Datensammlung [_GT4HistOCR_](https://zenodo.org/record/1344132) trainiert.

<div class="is-clearfix"></div>

## Automatische Nachkorrektur historischer OCR-erfasster Drucke mit integrierter optionaler interaktiver Korrektur

<p class="poster-image">
  <a href="/assets/poster/München.pdf">
    <img src="/assets/poster/München.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Ludwig-Maximilians-Universität München_<br/>
_Centrum für Informations- und Sprachverarbeitung (CIS)_

GitHub: cisocrgroup/ocrd-postcorrection](https://github.com/cisocrgroup/ocrd-postcorrection), [cisocrgroup/cis-ocrd-py](https://github.com/cisocrgroup/cis-ocrd-py)

Das Ergebnis des Projekts ist ein in den OCR-D-Workflow integriertes System
_A-I-PoCoTo_ zur vollautomati-schen Nachkorrektur OCR-erfasster historischer
Drucke. Das System beinhaltet zudem eine optional nachge-schaltete interaktive
Nachkorrektur (_I-PoCoTo_), die in das interaktive Nachkorrektursystem
_PoCoWeb_ einge-bunden ist. Das System kann damit auch alternativ als
Stand-Alone-Tool zur gemeinschaftlichen webbasierten Nachkorrektur von
OCR-Dokumenten eingesetzt werden.

Die Grundlage der vollautomatischen Nachkorrektur ist ein flexibles,
featurebasiertes Machine-Learning (ML) Verfahren zur vollautomatischen
OCR-Nachkorrektur mit einem besonderen Fokus auf die Vermeidung der
Verschlimmbesserungsproblematik. Zur Erkennung von Fehlern und für die
Erzeugung von Korrekturkandida-ten verwendet das System die am CIS entwickelte
dokumentenabhängige Profilierungstechnologie. Die Fea-tures des Systems
verwenden neben verschiedenen Konfidenzwerten insbesondere auch Informationen
aus zusätzlichen Hilfs-OCRs.

Das System protokolliert sämtliche Korrekturentscheidungen. Über diesen
Protokollmechanismus kann die automatische Postkorrektur in _PoCoWeb_
interaktiv überprüft werden. Dabei können sowohl einzelne getätigte
Korrekturentscheidungen manuell rückgängig gemacht werden, als auch nicht
getätigte Korrekturentschei-dungen nachträglich ausgeführt werden.

Das gesamte System ist in den OCR-D-Workflow eingebunden und folgt den dort
gültigen Konventionen.

<div class="is-clearfix"></div>

## Entwicklung eines Modellrepositoriums und einer Automatischen Schriftarterkennung für OCR-D

<p class="poster-image">
  <a href="/assets/poster/Mainz.pdf">
    <img src="/assets/poster/Mainz.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Universität Leipzig_<br/>
_Institut für Informatik: Lehrstuhl für Digital Humanities_<br/>
_Friedrich-Alexander-Universität Erlangen-Nürnberg_ <br/>
_Department Informatik: Lehrstuhl für Informatik 5: Mustererkennung_<br/>
_Johannes Gutenberg-Universität Mainz_<br/>
 Gutenberg-Institut für Weltliteratur und schriftorientierte Medien: Abteilung Buchwissenschaft_

GitHub: [OCR-D/okralact](https://github.com/OCR-D/okralact), [seuretm/ocrd_typegroups_classifier](https://github.com/seuretm/ocrd_typegroups_classifier)

Die Erkennungsquoten von OCR für Drucke, die vor 1800 produziert wurden,
variieren sehr stark, da die Diversität historischer Schriftarten in den
Trainingsdaten entweder gar nicht oder nur unzureichend berücksichtigt wird.
Daher hat sich dieses Modulprojekt, bestehend aus Informatiker*innen und
Buchhistoriker*innen, drei Ziele gesteckt: 

Zum einen haben wir ein Tool zur automatischen Erkennung von Schriftarten in
Bilddigitalisaten entwickelt. Hier haben wir uns besonders auf gebrochene
Schriften neben der Fraktur konzentriert, die bisher wenig Beachtung gefunden
haben, jedoch im 15. und 16. Jahrhundert weit verbreitet waren: Bastarda,
Rotunda, Textura und Schwabacher. Das Tool wurde mit 35.000 Bildern trainiert
und erreicht eine Genauigkeit von 98% bei der Bestimmung von Schriftarten.
Insgesamt kann es nicht nur zwischen den o.g. Schriftarten differenzieren,
sondern auch Hebräisch, Griechisch, Fraktur, Antiqua und Kursiv unterscheiden. 

In einem zweiten Schritt wurde eine Online-Trainingsinfrastruktur geschaffen
(Okralact). Sie vereinfacht die Benutzung verschiedener OCR-engines (Tesseract,
Ocropus, Kraken, Calamari) und ermöglicht es zugleich, spezifische Modelle für
bestimmte Schriftarten zu trainieren. 

Zum Abschluss wurde ein Modellrepositorium eingerichtet, das bereits
erarbeitete schriftartspezifische OCR-Modelle enthält. Um hier einen Grundstock
zu legen, haben wir insgesamt ca. 2.500 Zeilen für Bastarda, Textura und
Schwabacher aus einer Vielzahl verschiedener Bücher transkribiert. 

Die hohe Genauigkeit des Tools zur Erkennung der Schriftarten eröffnet die
Möglichkeit, in Zukunft durch weitere Trainingsdaten das Tool sogar zwischen
den Schriften einzelner Drucker unterscheiden zu lassen, was mehrere Desiderate
der historischen Forschung adressieren würde.

<div class="is-clearfix"></div>

## OLA-HD – Ein OCR-D-Langzeitarchiv für historische Drucke

<p class="poster-image">
  <a href="/assets/poster/Göttingen.pdf">
    <img src="/assets/poster/Göttingen.png" style="height: 400px" title="Klicken für PDF-Version in Originalgröße"/>
  </a>
</p>

_Georg-August-Universität Göttingen_  <br/>
_Niedersächsische Staats- und Universitätsbibliothek_   <br/>
_Gesellschaft für Wissenschaftliche Datenverarbeitung mbH Göttingen_ <br/>

GitHub: [subugoe/OLA-HD-IMPL](https://github.com/subugoe/OLA-HD-IMPL)

Im September 2018 starteten die Abteilung Digitale Bibliothek der
Niedersächsischen Staats- und Universi-tätsbibliothek und die Gesellschaft für
wissenschaftliche Datenverarbeitung Göttingen das DFG-Projekt [_OLA-HD – Ein
OCR-D Langzeitarchiv für historische
Drucke_](https://www.sub.uni-goettingen.de/projekte-forschung/projektdetails/projekt/ola-hd-ein-ocr-d-langzeitarchiv-fuer-historische-drucke/).

Ziel von OLA-HD ist die Entwicklung eines integrierten Konzepts für die
Langzeitarchivierung und persistente Identifizierung von OCR-Objekten, sowie
eine prototypische Implementierung. 

Im regelmäßigen Austausch mit den Projektpartnern wurden die
Basis-Anforderungen für die Langzeitarchivierung und persistente Identifikation
ermittelt und in Form einer Spezifikation zur technischen und
wirtschaftlich-organisatorischen Umsetzung festgehalten.

Mit dem Prototypen kann der Anwender OCR-Ergebnisse eines Werkes als OCRD-ZIP
in das System laden. Das System validiert die Zip-Datei, vergibt eine PID und
schickt die Datei an den Archiv-Manager [(CDSTAR – GWDG Common Data Storage
Architecture)](https://cdstar.gwdg.de/). Dieser schreibt die Zip-Datei in das
Archiv (Bandspeicher). Abhängig von der Konfiguration (Datei-Typ, Datei-Größe
etc.) werden Dateien zusätzlich in ein Online Storage geschrieben (Festplatte),
um einen schnellen Zugriff zu ermöglichen. Der Nutzer hat Zugriff auf alle
OCR-Versionen und kann Versionen als BagIt-Zip Dateien herunterladen. Alle
Werke und Versionen haben eigene PIDs. Die PIDs werden vom European Persistent
Identifier Consortium [(ePIC)](https://www.pidconsortium.net/) Service
generiert. Die verschiedenen OCR-Versionen eines Werkes sind über die PID
verknüpft, sodass das System die Versionierung in einer Baumstruktur abbilden
kann. 

Nicht angemeldete Anwender können den Bestand durchsuchen und in der
Dateistruktur eine Vorschau von Text und – sofern vorhanden – Bild erhalten
bzw. über die verschiedenen Versionen navigieren. Die Anwender können sich über
das GWDG-Portal registrieren und anmelden und können über ein Dashboard ihre
Dateien verwalten.

Bis März 2020 werden kleinere Optimierungen am User-Interface vorgenommen und
das Konzept finalisiert. Im Konzept werden weitere Ausbaustufen beschrieben,
die sinnvoll sein können, um die prototypische Soft-ware in ein Produkt zu
überführen.
