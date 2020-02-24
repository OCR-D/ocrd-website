# GroundTruth für die Digital Humanities : Workshop

Literatur:
* **Dhd2016**
Matthias Boenig, Kay-Michael Würzner, Arne Binder, Uwe Springmann:
Über den Mehrwert der Vernetzung von OCR-Verfahren zur Erfassung von Texten des 17. Jahrhunderts
http://dhd2016.de/boa.pdf#page=103

* **Dhd2018**
Matthias Boenig, Maria Federbusch, Elisa Herrmann, Clemens Neudecker, Kay-Michael Würzner:
Ground Truth : Grundwahrheit oder Ad-Hoc-Lösung? Wo stehendie Digital Humanities?
http://dhd2018.uni-koeln.de/wp-content/uploads/boa-DHd2018-web-ISBN.pdf#page=221

* **DaTech2019**
Matthias Boenig, Konstantin Baierer, Volker Hartmann:
Labelling OCR Ground Truth for Usage in Repositories

## GroundTruth Definition
"Unter  Ground  Truth  wird  in  diesem  Kontext die Dokumentation ausgewählter Merkmale (Zeichen, Zeilen, Absätze, Spalten, Abbildungen, usw.) der Vorlage in Form einer digitalen Transkription verstanden."[^Gt-Definition]

## Werkzeuge
> Transkribus
![](https://i.imgur.com/rM2L3wm.jpg)



> Aletheia


### Guidelines
#### OCR-D GroundTruth Guidelines
Präsentation: https://ocr-d.github.io/gt/trans_documentation/index.html
Dokumentation: https://github.com/OCR-D/gt-guidelines

#### Page-XML
Dokumentation zum PAGE XML Format for Page Content im Rahmen von OCR-D
https://ocr-d.github.io/gt/trans_documentation/trPage.html
GitHub: https://github.com/PRImA-Research-Lab/PAGE-XML

#### Tools und Helferlein
**makeAletheia_mets**
Erstellung einer Mets-Datei (Page Collections-Datei), um einfach mit Aletheia zu arbeiten.
https://github.com/tboenig/makeAletheia_mets


**Transkribus_mets2Aletheia_mets**
Konvertierung einer vorhandenen Transkribus-METS-Datei in eine  Aletheia-METS-Datei.
https://github.com/tboenig/Transkribus_mets2Aletheia_mets


# Workshop

## Aufgabe:
1. Erstellung von GroundTruth auf Basis von Digitalisaten
2. Bearbeitung in Altheia
3. Download und Bearbeitung von GroundTruth aus dem GT-OCR-D Repositorium.

### Aufgabe 1:

Voraussetzung: installierter Transkribus (https://transkribus.eu/Transkribus/)
~Hinweis:~ Dazu ist ein Acount bei Transkribus notwendig.

* Starten Sie Transkribus und loggen Sie sich ein.
* Öffnen Sie die Collection ``OCR-D_DHD2019`` Collection
* Sie finden darin: ``a_gehema_feldapotheke_1688_3``, Öffnen Sie das Dokument.
![](https://i.imgur.com/7YGWKQa.jpg)

* Das Page-Format bietet die Transkribtion von Regionen -> Zeilen -> Wörtern an. [Zeichen(Glyphen) können ebenfalls mit Page transkibiert werden.] ![](https://i.imgur.com/fHhZwRN.png)
* Reduzieren Sie die Anzeigen nur auf die Zeileneben. 
![](https://i.imgur.com/ZPXHiyv.png)
* Klicken Sie die erste Zeile an und transkribieren Sie den Text.
![](https://i.imgur.com/yQM0X9N.jpg)
* Zeichen die sich außerhalb des Tastaturlayout befinden können Sie durch das ``Virtual keyboard`` eingeben.
![](https://i.imgur.com/1aWmXgo.png)












### Aufgabe 2:

### Aufgabe 3:








[^Gt-Definition]: Matthias Boenig, Maria Federbusch, Elisa Herrmann, Clemens Neudecker, Kay-Michael Würzner: Ground Truth : Grundwahrheit oder Ad-Hoc-Lösung? Wo stehendie Digital Humanities?
http://dhd2018.uni-koeln.de/wp-content/uploads/boa-DHd2018-web-ISBN.pdf#page=221
