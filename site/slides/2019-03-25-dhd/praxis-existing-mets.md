---
layout: page
lang: de
toc: true
---

# Praxis: OCR von digitalisierten Beständen

Der Einfachheit halber verwenden wir ein Beispiel aus dem [Bestand an Testdaten
innerhalb von OCR-D](https://github.com/OCR-D/assets), da diese weniger umfangreich
sind. Prinzipiell funktionieren die OCR-D Werkzeuge aber mit allen METS-Dateien, die
auch im DFG-Viewer angezeigt werden können.

## Ist `ocrd` installiert?

```sh
$ ocrd --help
Usage: ocrd [OPTIONS] COMMAND [ARGS]...

  CLI to OCR-D

Options:
  --version                       Show the version and exit.
  -l, --log-level [OFF|ERROR|WARN|INFO|DEBUG|TRACE]
                                  Log level
  --help                          Show this message and exit.

Commands:
  bashlib    Work with bash library
  ocrd-tool  Work with ocrd-tool.json JSON_FILE
  process    Process a series of tasks
  workspace  Working with workspace
  zip        Bag/Spill/Validate OCRD-ZIP bags
```

Falls dieser Befehl nicht klappt, überprüfen Sie ob die [Software richtig installiert wurde](./setup-time).

## METS herunterladen

Wir verwenden eine auf 2 Seiten reduzierte Erstausgabe von Kant "Kritik der reinen Vernunft" aus dem Bestand
des Deutschen Textarchivs, die in GitHub liegt: https://github.com/OCR-D/assets/blob/master/data/kant_aufklaerung_1784/data/mets.xml

Dazu nutze den `workspace` Unterbefehl von `ocrd`, der es erlaubt, mit METS zu
interagieren, ohne das XML direkt bearbeiten zu müssen.

Der Unterbefehl `clone` erlaubt das Herunterladen von METS und ggf. enthaltenen Dateien.

Mit dem Parameter `--download` werden auch alle referenzierten Dateien mit heruntergeladen (das entfernte Verzeichnis wird "geklont")

```sh
$ ocrd workspace clone --download "https://raw.githubusercontent.com/OCR-D/assets/master/data/kant_aufklaerung_1784/data/mets.xml" kant
20:47:48.914 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/mets.xml'
/home/ich/kant

$ find kant
kant
kant/OCR-D-IMG
kant/OCR-D-IMG/INPUT_0017
kant/OCR-D-IMG/INPUT_0020
kant/OCR-D-GT-ALTO
kant/OCR-D-GT-ALTO/PAGE_0020_ALTO
kant/OCR-D-GT-ALTO/PAGE_0017_ALTO
kant/OCR-D-GT-PAGE
kant/OCR-D-GT-PAGE/PAGE_0017_PAGE
kant/OCR-D-GT-PAGE/PAGE_0020_PAGE
kant/mets.xml
```

Das METS liegt nun als `mets.xml` im Unterverzeichnis `kant`, die Bilder in
Unterverzeichnissen, die Dateigruppen repräsentieren.

**TIPP** Kopieren sie das geklonte Verzeichnis an diesem Punkt. Dann müssen Sie nicht
alle Dateien neu laden, falls im weiteren Ablauf etwas schief läuft:

```sh
$ cp -r kant kant.BAK
```

## METS untersuchen

Die METS-Datei könenn wir nun untersuchen.

### Welche Dateigruppen gibt es?

```sh
$ cd kant
$ ocrd workspace list-group
OCR-D-IMG
OCR-D-GT-PAGE
OCR-D-GT-ALTO
```

Es gibt also drei Dateigruppen, wobei wir uns für die Bilder interessieren, die in `OCR-D-IMG` gelistet sind.

### Welche Seiten gibt es?

Physische Seiten werden in METS in einer `structMap` aufgelistet. Wir können uns die IDs der Seiten ausgeben lassen:

```sh
$ ocrd workspace list-page
PHYS_0017
PHYS_0020
```

Es gibt zwei Seiten.

### Dateien auflisten

Wir können uns die enthaltenen Dateien auflisten lassen mit dem `find` Unterbefehl:

```sh
$ ocrd workspace find
OCR-D-IMG/INPUT_0017
OCR-D-IMG/INPUT_0020
OCR-D-GT-PAGE/PAGE_0017_PAGE
OCR-D-GT-PAGE/PAGE_0020_PAGE
OCR-D-GT-ALTO/PAGE_0017_ALTO
OCR-D-GT-ALTO/PAGE_0020_ALTO
```

Es gibt sechs Dateien: Für jede der zwei Seiten Dateien für jede der drei Dateigruppen.

Standardmäßig wird nur die Datei-ID ausgegeben, weitere Felder können über den
Parameter `-k` angegeben werden (`ocrd workspace find --help` liefert weitere
Informationen):

```sh
$ ocrd workspace find -k url -k mimetype -k pageId -k ID
OCR-D-IMG/INPUT_0017    image/tiff      PHYS_0017       INPUT_0017
OCR-D-IMG/INPUT_0020    image/tiff      PHYS_0020       INPUT_0020
OCR-D-GT-PAGE/PAGE_0017_PAGE    application/vnd.prima.page+xml  PHYS_0017       PAGE_0017_PAGE
OCR-D-GT-PAGE/PAGE_0020_PAGE    application/vnd.prima.page+xml  PHYS_0020       PAGE_0020_PAGE
OCR-D-GT-ALTO/PAGE_0017_ALTO    application/alto+xml    PHYS_0017       PAGE_0017_ALTO
OCR-D-GT-ALTO/PAGE_0020_ALTO    application/alto+xml    PHYS_0020       PAGE_0020_ALTO
```

<!-- ## Herunterladen der Bild-Dateien -->

<!-- Prinzipiell kann `ocrd` auch mit entfernten Bildern arbeiten.  -->

## Anatomie eines `ocrd-*` Kommandozeilenaufrufs

Alle OCR-D Werkzeuge folgen einer einheitlichen Aufrufsyntax, die [Teil der
Spezifikationen ist](https://ocr-d.github.io/cli).

```sh
ocrd-* \
  -m mets.xml         \ # Pfad zur METS-Datei
  -I INPUT-GROUP      \ # Eingabe-Dateigruppe
  -O OUTPUT-GROUP     \ # Ausgabe-Dateigruppe
  -l DEBUG|INFO|ERROR \ # Optional: Logging Detail Level
  -p parameter.json   \ # Optional: Parameter-Datei
  -g PAGE-ID          \ # Optional: ID einer Seite falls nur eine Seite verarbeitet werden soll
```

## Binarisierung mit `ocrd-kraken-binarize`

Der erste Schritt für die OCR ist die Binarisierung des Bildes, bei der alle
Farben durch schwarz oder weiss ersetzt werden.

Dafür gibt es verschiedene Implementierungen im OCR-D-Ökosystem, wir verwenden
hier die Binarisierung von kraken.

```sh
$ ocrd-kraken-binarize -m mets.xml -I OCR-D-IMG -O OCR-D-IMG-BIN
19:49:28.847 INFO processor.KrakenBinarize - INPUT FILE 0 / <OcrdFile mimetype=image/tiff, ID=INPUT_0017, url=OCR-D-IMG/INPUT_0017, local_filename=---]/>
19:49:28.868 INFO processor.KrakenBinarize - pcgts <ocrd_models.ocrd_page_generateds.PcGtsType object at 0x7effeb96aeb8>
19:49:28.868 INFO processor.KrakenBinarize - About to binarize page 'None'
19:49:28.871 INFO kraken.binarization - Binarizing /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/OCR-D-IMG/INPUT_0017
19:49:32.928 INFO processor.KrakenBinarize - INPUT FILE 1 / <OcrdFile mimetype=image/tiff, ID=INPUT_0020, url=OCR-D-IMG/INPUT_0020, local_filename=---]/>
19:49:32.931 INFO processor.KrakenBinarize - pcgts <ocrd_models.ocrd_page_generateds.PcGtsType object at 0x7effeb8ac5f8>
19:49:32.931 INFO processor.KrakenBinarize - About to binarize page 'None'
19:49:32.933 INFO kraken.binarization - Binarizing /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/OCR-D-IMG/INPUT_0020
19:49:36.986 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/mets.xml'
```

Damit werden alle Dateien in der `OCR-D-IMG` Dateigruppe binarisiert, das
Ergebnis wird in die Dateigruppe `OCR-D-IMG-BIN` geschrieben.

## Zeilensegmentierung mit Ocropy

Als nächsten Schritt müssen die Zeilen bestimmt werden, damit OCR angewandt werden kann.

Auch dafür gibt es verschiedene Implementierungen innerhalb von OCR-D, wir verwenden die Zeilensegmentierung von Ocropus.

```sh
$ ocrd-ocropy-segment -m mets.xml -I OCR-D-IMG-BIN -O OCR-D-SEG-LINE
19:52:45.364 INFO processor.ocropySegment - INPUT FILE 0 / <OcrdFile mimetype=image/png, ID=OCR-D-IMG-BIN_0001, url=OCR-D-IMG-BIN/OCR-D-IMG-BIN_0001, local_filename=---]/>
19:52:45.365 INFO processor.ocropySegment - downloaded_file <OcrdFile mimetype=image/png, ID=OCR-D-IMG-BIN_0001, url=OCR-D-IMG-BIN/OCR-D-IMG-BIN_0001, local_filename=/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/OCR-D-IMG-BIN/OCR-D-IMG-BIN_0001]/>
19:52:45.383 INFO processor.ocropySegment - pcgts <ocrd_models.ocrd_page_generateds.PcGtsType object at 0x7fcf0fab2208>
19:52:50.705 INFO processor.ocropySegment - INPUT FILE 1 / <OcrdFile mimetype=image/png, ID=OCR-D-IMG-BIN_0002, url=OCR-D-IMG-BIN/OCR-D-IMG-BIN_0002, local_filename=---]/>
19:52:50.705 INFO processor.ocropySegment - downloaded_file <OcrdFile mimetype=image/png, ID=OCR-D-IMG-BIN_0002, url=OCR-D-IMG-BIN/OCR-D-IMG-BIN_0002, local_filename=/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/OCR-D-IMG-BIN/OCR-D-IMG-BIN_0002]/>
19:52:50.706 INFO processor.ocropySegment - pcgts <ocrd_models.ocrd_page_generateds.PcGtsType object at 0x7fcf0fa66358>
19:52:55.739 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/mets.xml'
```

Ausgehend von den binarisierten Bilder in der Dateigruppe `OCR-D-IMG-BIN` erzeugen wir PAGE-XML mit Segmentierungsinformation in der Dateigruppe und dem lokalen Verzeichnis `OCR-D-SEG-LINE`.

Das PAGE-XML sieht ausschnittsweise so aus:


```xml
<pc:Page imageFilename="OCR-D-IMG-BIN/OCR-D-IMG-BIN_0002" imageWidth="1456" imageHeight="2084">
    <pc:TextRegion>
        <pc:TextLine id="line_0002">
            <pc:Coords points="103,136 122,136 122,188 103,188"/>
        </pc:TextLine>
        <pc:TextLine id="line_0003">
            <pc:Coords points="126,125 166,125 166,185 126,185"/>
        </pc:TextLine>
        <pc:TextLine id="line_0004">
            <pc:Coords points="166,124 209,124 209,168 166,168"/>
      </pc:TextLine>
      <!-- ... -->
```

Wir können uns das Ergebnis auch im PAGE Viewer visualisieren:

![](/2019-03-25-dhd/figures/page-viewer.png)

Die Zeilenerkennung ist nicht perfekt (Artefakte im Randbereich, ueberlange
Zeilen), aber gut genug, um OCR durchzuführen.

## Texterkennung mit tesseract

Das Projekt `ocrd_tesserocr` bindet tesseract über die `tesserocr`
Python-Bindings an OCR-D an.

Der Aufruf ist analog zu Binarisierung und Segmentierung:

```sh
$ ocrd-tesserocr-recognize -m mets.xml -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS
21:09:52.910 INFO processor.TesserocrRecognize - Using model 'eng' in /usr/share/tesseract-ocr/4.00/tessdata/ for recognition at the line level
21:09:52.910 INFO processor.TesserocrRecognize - INPUT FILE 0 / <OcrdFile mimetype=application/vnd.prima.page+xml, ID=OCR-D-SEG-LINE_0001, url=OCR-D-SEG-LINE/
OCR-D-SEG-LINE_0001.xml, local_filename=---]/>
21:09:53.071 INFO processor.TesserocrRecognize - Recognizing text in page 'None'
21:10:24.127 INFO processor.TesserocrRecognize - INPUT FILE 1 / <OcrdFile mimetype=application/vnd.prima.page+xml, ID=OCR-D-SEG-LINE_0002, url=OCR-D-SEG-LINE/
OCR-D-SEG-LINE_0002.xml, local_filename=---]/>
21:10:24.357 INFO processor.TesserocrRecognize - Recognizing text in page 'None'
21:11:09.617 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/mets.xml'
```

Das Ergebnis ist allerdings nicht optimal. Ausschnitt aus `kant/OCR-D-OCR-TESS/OCR-D-OCR-TESS_0002`:

```xml
 <pc:TextLine id="line_0006">
     <pc:Coords points="529,410 1342,410 1342,468 529,468"/>
     <pc:TextEquiv conf="0.47">
         <pc:Unicode>geenegerc wogpe35tro rappucb धाम es Bgrenbeire ﺪﺷﺭ</pc:Unicode>
     </pc:TextEquiv>
 </pc:TextLine>
```

Das liegt daran, dass wir nicht angegeben haben, welches Modell verwendet werden soll. Standardmäßig verwendet
tesseract daher `eng`, das Modell für englischsprachige Antiqua. Für deutsche Fraktur benötigen wir das
Modell `frk`, das im [tesseract-Modell-GitHub-Repository](https://github.com/tesseract-ocr/tessdata_best) zu finden ist.

```sh
$ cd /usr/share/tesseract-ocr/4.00/tessdata/
$ sudo wget 'https://github.com/tesseract-ocr/tessdata_best/raw/master/frk.traineddata'
```

Nun führen wir den befehl noch einmal aus aber geben als Parameter das zu verwendende Modell mit an:

```sh
$ ocrd-tesserocr-recognize -m mets.xml -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS-FRK -p <(echo '{"model": "frk"}')
21:09:52.910 INFO processor.TesserocrRecognize - Using model 'frk' in /usr/share/tesseract-ocr/4.00/tessdata/ for recognition at the line level
21:09:52.910 INFO processor.TesserocrRecognize - INPUT FILE 0 / <OcrdFile mimetype=application/vnd.prima.page+xml, ID=OCR-D-SEG-LINE_0001, url=OCR-D-SEG-LINE/
OCR-D-SEG-LINE_0001.xml, local_filename=---]/>
21:09:53.071 INFO processor.TesserocrRecognize - Recognizing text in page 'None'
21:10:24.127 INFO processor.TesserocrRecognize - INPUT FILE 1 / <OcrdFile mimetype=application/vnd.prima.page+xml, ID=OCR-D-SEG-LINE_0002, url=OCR-D-SEG-LINE/
OCR-D-SEG-LINE_0002.xml, local_filename=---]/>
21:10:24.357 INFO processor.TesserocrRecognize - Recognizing text in page 'None'
21:11:09.617 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/kant/mets.xml'
```

Vergleichen wir die Erkennung der Textzeile:

```xml
<pc:TextLine id="line_0006">
    <pc:Coords points="529,410 1342,410 1342,468 529,468"/>
    <pc:TextEquiv conf="0.9">
        <pc:Unicode>gewiegelt worden ; ſo ſchädlich iſt es Vorurtheile zu</pc:Unicode>
    </pc:TextEquiv>
</pc:TextLine>
```

Das sieht nicht nur korrekt aus, auch tesseract ist sich sicherer: Konfidenz `0.9.` vs `0.47` oben.

## "In einem Rutsch"

Die einzelnen Prozessschritte nacheinander auszuführen wie beschrieben ist mühselig. Wenn an einem
Punkt im Ablauf etwas schief läuft, muss der gesamte Vorgang abgebrochen werden. Daher bietet `ocrd`
einen Modus, in dem ein kompletter Ablauf von Prozesschritten angegeben werden kann. Wenn innerhalb
des Prozesses ein Fehler auftritt, endet der Gesamtprozess mit der Fehlermeldung.

Die Syntax entsprocht weitgehend dem individuellen Aufruf mit der Einschränkung dass `ocrd-` weggelassen
wird:

```sh
$ ocrd process -m mets.xml \
  'kraken-binarize -I OCR-D-IMG -O OCR-D-IMG-BIN' \
  'ocropy-segment -I OCR-D-IMG-BIN -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS'
```

## Aufgabe

Wenden Sie die gelernten Schritte an auf die erste Seite des Kommunistischen Manifests.
Die URL der METS-Datei: [https://raw.githubusercontent.com/OCR-D/assets/master/data/communist_manifesto/data/mets.xml](https://raw.githubusercontent.com/OCR-D/assets/master/data/communist_manifesto/data/mets.xml)

Falls Sie Python 3.7 verwenden und deshalb ocrd_kraken nicht installieren konnten: Hier ist ein OCRD-ZIP
der Aufgabe bis einschliesslich Binarisierung: [binarized.zip](/2019-03-25-dhd/binarized.zip)
