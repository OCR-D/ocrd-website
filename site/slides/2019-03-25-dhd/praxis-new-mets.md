---
layout: page
lang: de
toc: true
---
# Praxis: OCR von willkürlichen Bildern

Der Fokus von OCR-D ist auf Massendigitalisierung historischer Bestände.
Deswegen wird konsequent immer METS verwendet.

Um mit willkürlichen Bildern innerhalb OCR-D zu arbeiten, müssen wir daher METS
erzeugen.

Als Beispiel verwenden wir die [erste Seite der englischen Ausgabe des Kommunistischen Manifests](https://github.com/OCR-D/assets/blob/master/data/communist_manifesto/data/OCR-D-IMG/OCR-D-IMG_0015) (Quelle: https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Manifesto_of_the_Communist_Party.djvu/page15-2745px-Manifesto_of_the_Communist_Party.djvu.jpg).

## Neues METS erzeugen

Der `workspace` Unterbefehl erlaubt es, neues METS zu initiieren (`init`):

```sh
$ ocrd workspace init communist_manifesto
22:58:38.321 INFO ocrd.resolver - Writing /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/communist_manifesto/mets.xml
22:58:38.322 INFO ocrd.workspace - Saving mets '/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/communist_manifesto/mets.xml'
/home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/communist_manifesto

$ find communist_manifesto
communist_manifesto
communist_manifesto/mets.xml
```

## Verzeichnis für Bild anlegen

Per Konvention heisst die Dateigruppe mit dem unkomprimierten Bild innerhalb von OCR-D immer `OCR-D-IMG`:

```sh
$ cd communist_manifesto
$ mkdir OCR-D-IMG
```

## Bild herunterladen

```sh
$ curl 'https://raw.githubusercontent.com/OCR-D/assets/master/data/communist_manifesto/data/OCR-D-IMG/OCR-D-IMG_0015' > OCR-D-IMG/OCR-D-IMG_0015.png
```

## Bild zum METS hinzufügen

Dateien können mit dem `add` Unterbefehl von `ocrd workspace` hinzugefügt werden.

Dafür sind eine Reihe von Parametern notwendig, die Sie der Hilfe entnehmen können:

```sh
$ ocrd workspace add --help
Usage: ocrd workspace add [OPTIONS] LOCAL_FILENAME

  Add a file LOCAL_FILENAME to METS in a workspace.

Options:
  -G, --file-grp TEXT  fileGrp USE  [required]
  -i, --file-id TEXT   ID for the file  [required]
  -m, --mimetype TEXT  Media type of the file  [required]
  -g, --page-id TEXT   ID of the physical page
  --force              If file with ID already exists, replace it
  --help               Show this message and exit.
```

Wir fügen also die Datei hinzu:

```sh
$ ocrd workspace add -g P0015 -G OCR-D-IMG -i OCR-D-IMG_0015 -m image/png OCR-D-IMG/OCR-D-IMG_0015.png
```

Und überprüfen ob sie wirklich hinzugefügt wurde:

```sh
$ ocrd workspace find
OCR-D-IMG/OCR-D-IMG_0015
```

## Eindeutigen Identifier hinzufügen

Nun setzen wir noch einen eindeutigen Identifier:
```sh
$ ocrd workspace set-id '1234567890'
```

## Validieren

Wir können nun überprüfen, ob das Verzeichnis den Anforderungen von OCR-D
genügt. Dazu verwenden wir den `validate` Unterbefehl von `ocrd workspace`.
Bei der Validierung überspringen wir die Untersuchung der Auflösung, da
diese aus technischen Gründen häufig nicht gegeben ist, was zu Fehlern führt, die keine sind.

```sh
$ ocrd workspace validate --skip pixel_density mets.xml
<report valid="true">
</report>
```

## Fertig!

Das Verzeichnis ist nun in einer Form, dass es mit OCR-D Werkzeugen weiterverarbeitet werden kann.

Im Ergebnis sollte das von Ihnen erstellte Verzeichnis [dem Beispieldatensatz im OCR-D/assets Repository](https://github.com/OCR-D/assets/tree/master/data/communist_manifesto/data) entsprechen.
