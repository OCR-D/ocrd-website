---
layout: page
toc: true
lang: de
---

# OCR-D Ground Truth Praxis

Repository-URL: https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit

## Werkzeuge
> **Transkribus**
Transkribus ist eine Werkzeug mit der auf Basis des PAGE-Formates Transkribtionen erstellt werden können. Diese Transkribtionen  können für das Training von Texterkennungs-Software genutzt werden. 

![](https://i.imgur.com/rM2L3wm.jpg)


> **Aletheia**
Aletheia ist die Refenenzsoftware des am PRIma-LAB (Pattern Recognition & Image Analysis Research Lab) entwickelten PAGE-Formates. Mit dieser Software werden Transkribtionen erstellt, die für das Training von Texterkennungs-Software genutzt werden können. 

![](https://i.imgur.com/7nSq9J2.jpg)


Beide Werkzeuge können für die Erstellung von Ground Truth genutzt werden.


### Guidelines
#### OCR-D GroundTruth Guidelines
Präsentation: https://ocr-d.github.io/gt/trans_documentation/index.html
Dokumentation: https://github.com/OCR-D/gt-guidelines

#### Page-XML
Dokumentation zum PAGE XML Format for Page Content im Rahmen von OCR-D
https://ocr-d.github.io/gt/trans_documentation/trPage.html
GitHub: https://github.com/PRImA-Research-Lab/PAGE-XML

#### Tools und Helferlein
**Tanskribus** 
Software: https://transkribus.eu
Kurz-Hilfe: https://transkribus.eu/wiki/images/c/cf/Transkribus_in_10_Schritten.pdf


**Aletheia**
Software: https://www.primaresearch.org/tools/Aletheia/Editions
~Hinweis~ Es liegt nur eine Windows-Version vor.


**makeAletheia_mets**
Erstellung einer Mets-Datei (Page Collections-Datei), um einfach mit Aletheia zu arbeiten.
https://github.com/tboenig/makeAletheia_mets


**Transkribus_mets2Aletheia_mets**
Konvertierung einer vorhandenen Transkribus-METS-Datei in eine  Aletheia-METS-Datei.
https://github.com/tboenig/Transkribus_mets2Aletheia_mets


# Workshop

## Aufgabe:
1. **Arbeiten in Transkribus:** Erstellung von GroundTruth auf Basis von Digitalisaten
    * Erstellung einer Transkribtion und der Zuordnung von Seitenregionen.
3. **Arbeiten in Altheia:** Bearbeitung in Aletheia
    * **Alternative Aufgabe:** Öffnen der Datei im PAGE-Viewer 
5. **Arbeiten mit dem GT-OCR-D Repositorium:** Download und Bearbeitung von GroundTruth aus dem GT-OCR-D Repositorium.

### Aufgabe 1:

Voraussetzung: installierter Transkribus (https://transkribus.eu/Transkribus/)
~Hinweis:~ Dazu ist ein Acount bei Transkribus notwendig.

* Starten Sie Transkribus und loggen Sie sich ein.
* Öffnen Sie die Collection ``OCR-D_DHD2019`` Collection.
* Sie finden darin: ``a_gehema_feldapotheke_1688_3``, Öffnen Sie das Dokument.
> ![](https://i.imgur.com/7YGWKQa.jpg)

* Das PAGE-Format bietet eine strukturelle Transkribtion von Regionen -> Zeilen -> Wörtern an. [Zeichen(Glyphen) können ebenfalls mit PAGE transkibiert werden.] 
> ![](https://i.imgur.com/fHhZwRN.png)
* Reduzieren Sie die Anzeigen nur auf die Zeilenebene.
 
> ![](https://i.imgur.com/ZPXHiyv.png)

* Klicken Sie die erste Zeile an und beginnen Sie mit der Transkribtion des Textes.

> ![](https://i.imgur.com/yQM0X9N.jpg)

* Zeichen die sich außerhalb des Tastaturlayouts befinden, können Sie durch das ``Virtual keyboard`` eingeben.

> ![](https://i.imgur.com/1aWmXgo.png)

* Neben der Transkribtion ist die Markierung und Klassifizierung der Seitenregionen vorzunehmen.
siehe: https://ocr-d.github.io/gt//trans_documentation/lyTextregionen.html
* Folgende Regionen sind zu unterscheiden:
    *     Textregion : TextRegion,
    *     Abbildungen, Fotos : ImageRegion,
    *     Buchschmuck, Zeichnungen : GraphicRegion,
    *     Trennlinien, Separatoren : SeparatorRegion,
    *     Tabellen : TableRegion,
    *     Strichzeichnungen : LineDrawingRegion,
    *     Mathematische Formeln : MathsRegion,
    *     Chemische Formeln : ChemRegion,
    *     Noten : MusicRegion,
    *     Werbung : AdvertRegion und
    *     Schmutz, Verfärbungen, Rauschen : NoiseRegion

* Diese Regionen sind unter dem Metadaten->Structural zu finden.
> ![](https://i.imgur.com/4cAL64o.jpg)

* Zum Abschluss der Arbeiten exportieren Sie Ihren Ground Truth.
> ![](https://i.imgur.com/vm5biCO.png)




### Aufgabe 2:

Um den GroundTruth aus Transkribus in Aletheia zu bearbeiten, kann die zur Verfügung gestellte METS-Datei genutzt werden. Jedoch muß diese in das Aletheia-Format konvertiert werden.

**Allgemeine Informationen zu METS:** https://de.wikipedia.org/wiki/Metadata_Encoding_%26_Transmission_Standard
**METS-Standard:** http://www.loc.gov/standards/mets/
**Voraussetzung:** Der *SAXON : The XSLT and XQuery Processor* ist auf Ihrem Rechner installiert.

* Laden Sie sich die entsprechenden Tools (XSL-Transformation) von https://github.com/tboenig/Transkribus_mets2Aletheia_mets herunter
* Entpacken Sie die Zip-Datei.
* Öffnen Sie die Kommandozeile/Terminal
    * **Windows**: 
        * Tippen Sie in das *Programm-Suche-Feld*: ``cmd`` ein. Es öffnet sich ein DOS/Windows Terminal. In diesem können Sie mit dem SAXON Processor arbeiten.
        * Nutzen Sie Ihr Linux-Sub-System (Betrifft nur Nutzer von Windows10).
            * Starten Sie die Linux-App.
            * Um Zugriff auf die Dateien Ihres Rechners zu bekommen nutzen Sie in Ihrem Linux-Subsystem das Kommando ``cd`` für *Change Directory* m ``cd /mnt/[Laufwerks-Angabe]/Users/Path zu den entsprechenden Ordnern/Dateien``
        * Für beide Systemvarianten gilt, passen Sie den Kommandozeilenaufruf an Ihr Dateisystem an. 
```sh
java -jar ../saxon9he.jar -xsl:../xsl/Transkribus_mets2Aletheia_mets.xsl -s:../example/mets.xml -o: ../example/mets_aletheia.metsx
```

      * Schreiben Sie den angpassten Kommandozeilenaufruf in das Kommandozeilenfenster/Terminal und starten Sie die Transformation durch drücken der Eingabetaste (Returntaste).  

* **Linux**
    * Öffnen Sie einen Terminal
    * Passen Sie den Kommandozeilenaufruf an Ihr Dateisystem an.
```
java -jar ../saxon9he.jar -xsl:../xsl/Transkribus_mets2Aletheia_mets.xsl -s:../example/mets.xml -o: ../example/mets_aletheia.metsx
```
  *   Schreiben Sie den angepassten Kommandozeilenaufruf in das Kommandozeilenfenster/Terminal und starten Sie die Transformation durch drücken der Eingabetaste (Returntaste oder Entertaste). 

Hinweis: Wo ist meine Eingabetaste (Returntaste oder Entertaste)?
https://upload.wikimedia.org/wikipedia/commons/a/a5/Enter.png



| Parameter | kurze Erklärung |
| -------- | -------- | 
| -xsl:     | Angabe des XSL-Datei.    | 
| -s:       | Angabe der Datei die transformiert werden soll. |
| -o:       | Angabe der Ausgabedatei. |


### Alternative Aufgabe 2:

Eine PAGE-Datei kann auch im PAGE-Viewer angezeigt werden. Dazu ist eine valide PAGE-Datei notwendig.
Zur Zeit werden PAGE-Dateien in Transkribus mit einigen Erweiterungen ausgeliefert, die zum PAGE-Schema nicht konform sind.
Deshalb müssen diese Erweiterungen vor dem Öffnen mit dem PAGE-Viewer zum Beispiel manuell entfernt werden.

Ausschnitt aus der PAGE-Datei von Transkribus:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<PcGts xmlns="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15 http://schema.primaresearch.org/PAGE/gts/pagecontent/2013-07-15/pagecontent.xsd">
    <Metadata>
        <Creator>OCR_D</Creator>
        <Created>2016-09-20T13:04:41.875+02:00</Created>
        <LastChange>2018-04-23T12:49:58.191+02:00</LastChange>
        <Comments>
                Measurement unit: pixel
                PrimaryLanguage: German
                Language: GermanStandard
                Producer: ABBYY FineReader Engine 11</Comments>
        <TranskribusMetadata docId="6557" pageId="213761" pageNr="1" tsid="3193617" status="GT" userId="2082" imgUrl="..." xmlUrl="..." imageId="205160"/>
    </Metadata>
    [...]
</PcGts>
```

Der Eintrag:
```xml
<TranskribusMetadata docId="6557" pageId="213761" pageNr="1" tsid="3193617" status="GT" userId="2082" imgUrl="..." xmlUrl="..." imageId="205160"/>
```
ist zu löschen.

* Laden Sie eine Transkribus-PAGE-Datei in einen Text oder XML-Editor.
* Markieren und löschen Sie die gesamten Zeile: ```<TranskribusMetadata...```
* Speichern Sie Datei unter einem neuen Namen zum Beispiel: [alter Name]_PAGEViewer.xml
* Öffnen Sie den PAGE-Viewer und laden Sie die bearbeitete PAGE-Datei in den Viewer.

> ![](https://i.imgur.com/heKtm4i.jpg)



### Aufgabe 3:

Das OCR-D-GT-Repositorium speichert, verwaltet und archiviert GroundTruth-Daten. Für das Training und für die Evaluation können aus diesem Repositorium entsprechende Daten verwendet werden. Aber auch GroundTruth-Daten die in verschiedenen Kontexten erstellt wurden können in diesem Repositorium gespeichert und archiviert werden. Möchten Sie Ihren GroundTruth-Korpus zur Verfügung stellen dann nehmen Sie mit OCR-D Kontakt auf. Schreiben Sie eine E-Mail an ocrd@bbaw.de.

* Öffnen Sie die Webseite: https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit.
* In der Tabelle wählen Sie die erste Zeile aus und clicken Sie auf den Link zur zip-Datei in der Spalte URL.
```https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/data/buerger_gedichte_1778.ocrd.zip```
![](https://i.imgur.com/GVOYo6I.png)
* Speichern und entpacken Sie die zip-Datei
* Starten Sie den PAGE-Viewer
* Laden Sie eine PAGE-Datei, die sich im Ordner: ``buerger_gedichte_1778.ocrd-1/data/OCR-D-GT-SEG-BLOCK``  
* Da die Dateien keine Dateiendungen besitzen, werden Sie im Datei-Öffnen-Fenster zuerst nicht angezeigt.


| Windows-Explorer-Ansicht | Datei-Öffnen-Fenster im PAGE-Viewer | 
| -------- | -------- | 
| ![](https://i.imgur.com/aupydja.png)     | ![](https://i.imgur.com/shhrvvq.png)     | 

* Damit Sie alle Dateien im *Select Document File*-Fenster sehen können, geben Sie einen Stern (*) unter *Dateiname* ein und bestätigen die Eingabe mit Enter.
![](https://i.imgur.com/lUW13Y2.png)
* Das Laden der Bilddateien erfolgt auf gleichem Weg.
![](https://i.imgur.com/GN9AT9S.png)
 






[^Gt-Definition]: Matthias Boenig, Maria Federbusch, Elisa Herrmann, Clemens Neudecker, Kay-Michael Würzner: Ground Truth : Grundwahrheit oder Ad-Hoc-Lösung? Wo stehendie Digital Humanities?
http://dhd2018.uni-koeln.de/wp-content/uploads/boa-DHd2018-web-ISBN.pdf#page=221
