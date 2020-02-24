---
layout: page
lang: de
toc: true
---
# Praxis: OCRD-ZIP erzeugen

[OCRD-ZIP](https://ocr-d.github.io/ocrd_zip) ist das Austauschformat, in dem
Workspaces archiviert werden. Dies ist das Format, mit dem alle Repostorien
arbeiten (Ground Truth, Forschungsdaten, Langzeitarchivierung).

OCRD-ZIP basiert auf dem [BagIt] Standard, der in der Archiv-Community verbreitet ist
und von der Library of Congress gepflegt wird.

Ein OCRD-ZIP ist ein ZIP-Archiv, das neben den OCR-Daten auch Metadaten enthält,
bspw. Prüfsummen für die enthaltenen Dateien und Provenienzinformationen.

## Dateistruktur

Siehe [Folien vom OCR-D Entwicklerworkshop Februar 2019](http://kba.cloud/2019-02-27-ocrd-dev-ws/#/2/10)

## Erzeugen von OCRD-ZIP

OCRD-ZIP kann aus bestehenden Verzeichnissen mit dem `zip` Unterbefehl von `ocrd` verarbeitet werden.

Zum Erzeugen von OCRD-ZIP verwenden wir den `bag` Unterbefehl:

```sh
$ ocrd zip --skip-zip --id foo out
23:29:30.973 INFO ocrd.workspace_bagger - Bagging /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo to /home/kba/build/github.com/OCR-D/mono
repo/slides/2019-03-25-dhd/foo/out (temp dir /tmp/ocrd-bagit-n_ag6g3e)
23:29:30.974 INFO ocrd.workspace_bagger - Resolving OCR-D-IMG/OCR-D-IMG_0015 (partial)
23:29:30.974 INFO ocrd.workspace_bagger - Resolved /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/OCR-D-IMG/OCR-D-IMG_0015
23:29:30.984 INFO bagit - Using 1 processes to generate manifests: sha512
23:29:30.984 INFO bagit - Generating manifest lines for file data/mets.xml
23:29:30.985 INFO bagit - Generating manifest lines for file data/OCR-D-IMG/OCR-D-IMG_0015
23:29:31.014 INFO bagit - Creating /tmp/ocrd-bagit-n_ag6g3e/tagmanifest-sha512.txt
23:29:31.018 INFO ocrd.workspace_bagger - Created bag at /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out
```

Das Ergebnis liegt also nun im Verzeichnis out:

```sh
$ find out
out
out/tagmanifest-sha512.txt
out/bagit.txt
out/manifest-sha512.txt
out/data
out/data/OCR-D-IMG
out/data/OCR-D-IMG/OCR-D-IMG_0015
out/data/mets.xml
out/bag-info.txt
```

## Validieren

Um sicherzugehen, dass das OCRD-ZIP auch den Vorgaben entspricht, könen wir den `validate` Unterbefehl von `ocrd zip` verwenden.

```sh
$ ocrd zip validate --skip-unzip out
23:33:11.823 INFO bagit - Verifying checksum for file /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out/data/mets.xml
23:33:11.824 INFO bagit - Verifying checksum for file /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out/data/OCR-D-IMG/OCR-D-IMG_0015
23:33:11.846 INFO bagit - Verifying checksum for file /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out/bagit.txt
23:33:11.846 INFO bagit - Verifying checksum for file /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out/manifest-sha512.txt
23:33:11.847 INFO bagit - Verifying checksum for file /home/kba/build/github.com/OCR-D/monorepo/slides/2019-03-25-dhd/foo/out/bag-info.txt
OK
```

Das OCRD-ZIP ist also valide und kann ins Repository!

## Aufgabe

Erstellen Sie aus einem der Verzeichnisse aus den vorherigen Aufgaben ein OCRD-ZIP.

Validieren Sie das OCRD-ZIP
