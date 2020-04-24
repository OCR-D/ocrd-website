# OCR-Modelle

Für die Texterkennung wird ein geeignetes OCR-D-Modul und ein dazu passendes
Sprach-/Schriftmodell benötigt. Diese Seite gibt einen Überblick über die
wichtigsten Modelle und Modell-Repositorien.

## ocrd-tesserocr-recognize

Dieser Prozessor verwendet Tesseract (ab Version 4.1) für die Texterkennung. Tesseract benötigt
_Sprach-_ oder _Schriftmodelle_. Dies sind Dateien in einem speziellen Format (`*.traineddata`). Sie enthalten
mindestens eine Liste mit dem Erkennungs-Zeichensatz ("unicharset") und die Gewichte des neuronalen Erkennungs-Modells ("lstm"), optional auch noch Wörterbücher ("wordlist"/"dawg") und weitere Komponenten.
Sprachmodelle sind im Zeichensatz und im Wörterbuch auf eine Muttersprache (z. B. `deu` = Deutsch) beschränkt.
Schriftmodelle dagegen enthalten einen umfangreicheren Zeichensatz und Wörterbücher aus mehreren Sprachen mit der gleichen Schrift (z. B. `Latin` = lateinische Schrift mit Englisch, Deutsch, Französisch,
Spanisch, Italienisch, ...).

Für Tesseract gibt es mehr als 100 Sprach- und Schriftmodelle, die von Google mittels synthetischer Daten
(d.h. per Rasterung großer Mengen von Text mit vielen verschiedenen Vektorfonts) erzeugt ("trainiert")
wurden. Daneben gibt es aber auch noch weitere Modelle von anderen Anbietern, und man kann auch eigene
Modelle entweder komplett neu oder auf Basis vorhandener Modelle erstellen. Eigenes Training wird durch
[tesstrain](https://github.com/tesseract-ocr/tesstrain) gut unterstützt.

Die Modelle von Google gibt es jeweils in drei Varianten:

[`tessdata_fast`](https://github.com/tesseract-ocr/tessdata_fast) Diese Variante wird auch von den meisten
Linux-Distributionen angeboten und ist besonders schnell bei der Texterkennung. Sie verwendet neuronale Netzwerke.

[`tessdata_best`](https://github.com/tesseract-ocr/tessdata_best) Diese Variante braucht deutlich mehr Zeit bei der
Texterkennung, kann aber im Einzelfall(nicht generell!) bessere Ergebnisse liefern. Sie verwendet neuronale Netzwerke.
Eigenes Training neuer Modelle auf Basis vorhandener Modelle setzt ebenfalls diese Variante voraus.

[`tessdata`](https://github.com/tesseract-ocr/tessdata) Diese Variante ist ähnlich schnell wie tessdata_fast, enthält
aber zusätzlich zu den neuronalen Netzwerken auch noch die musterbasierte Zeichenerkennung von Tesseract 3.
Man kann damit also zwei unterschiedliche Texterkennungsmethoden kombinieren, was in Einzelfällen zu besseren Ergebnissen
führen kann.

### Schrift- und Sprachmodelle für historische Drucke

Die folgenden Modelle für Tesseract gibt es:

  * `deu_frak` Älteres Sprachmodell für deutsche Fraktur. Dieses Modell war mit Tesseract 3 gebräuchlich, ist aber heute nicht mehr zu empfehlen.
  * `deu` Sprachmodell für deutsche Antiqua, das aber auch etwas Fraktur erkennen kann.
  * `frk` Sprachmodell für deutsche Fraktur, das aber auch etwas Antiqua erkennen kann.
  * `Latin` Schriftmodell für lateinische Antiqua-Schriften, das aber auch etwas Fraktur erkennen kann.
  * `Fraktur` Schriftmodell für Fraktur-Schriften, das aber auch Antiqua-Schriften ganz gut erkennt. Fehler beim
    Erzeugen dieses Modells haben zur Folge, dass es kein Paragraphzeichen kennt und die Ligaturen `ch` und `ck`
    häufig als Kleiner- und Größerzeichen "erkennt".

Weitere Frakturmodelle. Ausgehend von Fraktur sind mit Hilfe von [GT4HistOCR](https://zenodo.org/record/1344132)
weitere Modelle der [UB Mannheim](https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/Fraktur_5000000/)
erzeugt worden, die für ein breites Spektrum historischer Drucke gute Ergebnisse liefern.

Schrift- und Sprachmodelle können in Tesseract auch kombiniert werden, was in
der Regel noch bessere Ergebnisse bringt, allerdings dann auch mehr Zeit
kostet.
