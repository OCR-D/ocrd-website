---
layout: page
lang: de
lang-ref: decisions
toc: true
title: Entscheidungen in OCR-D
---

# Entscheidungen in OCR-D

In einem Softwareprojekt, insbesondere in einem stark verteilten Projekt wie OCR-D,
müssen Entscheidungen getroffen werden über die verwendete Technologie, das Zusammenspiel der Schnittstellen
und darüber, wie die Software als Ganzes konzipiert ist.

In diesem Dokument werden solche Entscheidungen über Schlüsselaspekte von OCR-D 
zum Nutzen aller OCR-D-Akteure diskutiert.

## Terminologie

* *aktuell* bezieht sich auf den **13. Dezember 2022**, die letzte Änderung dieses Dokuments
* *Q1-Q4* bezieht sich auf die Jahresquartale
* *Zielversion* ist die Version, für die wir hauptsächlich testen und entwickeln
* *Unterstützte Version* bedeutet, dass wir diese Version testen und Kompatibilität sicherstellen

## Allgemeine Entscheidungen

* [Q1 2023] Wir werden so bald wie möglich auf Ubuntu 22.04 und Python 3.7 aktualisieren. [OCR-D/core#956](https://github.com/OCR-D/core/pull/956)
* [Q1 2023] Wechsel zu Slim Containern in `ocrd_all`.
* [Q1 2023] Python API Änderungen (seitenweise Prozessierung) [OCR-D/core#322](https://github.com/OCR-D/core/issues/322)

## Workflow-Format

* [Q3 2022] Wir verwenden Nextflow. Die gesamte `.nf`-Datei (Nextflow-Datei) als Workflow-Format, Workflow-Server 
und Verarbeitungs-Server einschließlich [Web-API-Implementierung](https://github.com/OCR-D/ocrd-webapi-implementation) 
ist Teil der [Implementierungsprojekte](phase3).  Weitere Details sind [in der nextflow spec](spec/nextflow) zu finden.

## Web-API

* [2022] Das OCR-D Koordinierungsprojekt stellt die [Web API spec](spec/web_api) zur Verfügung.
  Nur der [REST API wrapper](https://github.com/OCR-D/core/pull/884) eines einzelnen Prozessors wird von OCR-D Core bereitgestellt.

## QUIVER

* [2022] Wir werden eine Webanwendung, [QUIVER](https://github.com/OCR-D/quiver-back-end) (für QUalIty oVERview), 
entwickeln, in in der verschiedene Informationen über OCR-D Prozessoren bereitgestellt werden:
  * eine allgemeine Übersicht über die Projekte (d.h. GitHub Repositories), z.B. ob ihre `ocrd-tool.json` gültig ist, wann ihre letzte Version gemacht wurde usw.
  * ein Abschnitt über Workflows, in dem wir verschiedene Workflows für verschiedene Korpora [benchmarken](#benchmarking).
  * eine allgemeine Übersicht über die verfügbaren Prozessoren

### Benchmarking

* [2022] Um das Benchmarking durchzuführen, werden wir mehrere Korpora mit unterschiedlichen Eigenschaften (Schriftart, Erstellungsdatum, Layout, ...) erstellen und 
verschiedene Workflows mit diesen als Input laufen lassen. Das Ergebnis wird dann in der Registerkarte QUIVER-Workflow angezeigt.
Die Korpora werden zur besseren Transparenz öffentlich zugänglich sein.
* [2022] [Relevante Metriken] (https://github.com/OCR-D/spec/pull/225) für das Minimal Viable Product (MVP) werden sein:
  * CER
  * WER
  * Bag of Words
  * Lesereihenfolge
  * IoU
  * CPU-Zeit
  * Wandzeit
  * E/A
  * Speichernutzung
  * Festplattennutzung
* [2022] Das Benchmarking wird in regelmäßigen Abständen automatisch ausgeführt, um zu messen, ob Änderungen an den Prozessoren das Ergebnis verbessern.
Dies kann über CI, GitHub Actions oder als CRON Job auf einem separaten Server erfolgen.

## OCR-D/core

### METS-Server

Der aktuelle Ansatz zur Dateiverwaltung erfordert Prozessoren, die auf eine einzelne
METS-Datei auf der Festplatte zugreifen, was die Dateiverwaltung zu einem Engpass für Arbeitsabläufe macht.

Um dieses Problem zu lösen, [werden wir einen HTTP-Server entwickeln](https://github.com/OCR-D/core/pull/966), der asynchronen und
parallelen Zugriff auf das METS im **Q4 2022** ermöglicht.

### Dezentrale Ressourcenliste

Derzeit wird eine Liste der Prozessorressourcen zentral in OCR-D/core geführt.

In **Q3 2022** haben wir Mechanismen implementiert, die es Entwicklern von Prozessoren ermöglichen,
ihre eigene, separate Ressourcenliste zu führen,
indem Ressourcenlisten in der `ocrd-tool.json` des Prozessors gespeichert werden und die Ressourcen in ihrem eigenen Modulverzeichnis gebündelt werden.

Bis **Q1 2023** sollten wir alle Prozessoren aktualisiert haben und die
zentrale Liste auf eine weitgehend leere Liste reduziert haben.

### Seitenweise Prozessierung

Derzeit iterieren die Prozessoren durch die Dateien eines Workspace indem sie eine Schleife durch
alle Dateien in der/den Eingabedateigruppe(n) selbst durchführen.

In **Q1 2023** werden wir die Prozessor-API überarbeiten und den derzeitigen Ansatz der
Prozessoren, die in einer "process"-Methode iterieren, verwerfen und den Prozessoren ermöglichen,
einzelne Seiten in einer `process_page`-Methode zu verarbeiten.

<!--
   -## Prozessoren
   -
   -In diesem Abschnitt skizzieren wir unsere Pläne mit den verschiedenen Prozessorprojekten.
   -
   -**Hinweis** Derzeit nur anybaseocr als Beispiel
   -
   -### [ocrd_anybaseocr](https://github.com/OCR-D/ocrd_anybaseocr)
   -
   -`ocrd_anybaseocr` ist ein ziemlich komplexes Projekt mit mehreren Prozessoren,die an verschiedenen Problemen 
   -mit verschiedenen Technologien arbeiten. Einige der Prozessoren sind
   -leistungsfähig, einige sind zu experimentell, um empfohlen zu werden. Die ursprünglichen 
   -Entwickler sind aus dem Projekt ausgestiegen, daher ist es wichtig für die Wartbarkeit durch die
   -Community, dass wir sie überarbeiten.
   -->

## ocrd_all Docker deployment


* Unser aktueller Zielcontainer ist ein **fat container**, mit **maximum**,
  **medium** und **minimum** Versionen, die eine abnehmende Anzahl von Prozessoren
  enthalten.
* Wir werden Prozessorprojekte einzeln wrappen und in **Q1 2023** auf **slim container** umstellen.

## Unterstützte Python-Versionen

* Unsere aktuelle Zielversion für Python ist **3.7**, wir unterstützen **3.6** und **3.7** vollständig, 
spätere Versionen teilweise.
* :Achtung: Wir können derzeit nicht über **3.7** hinaus aktualisieren, 
da es keine [tensorflow v1.15.x](#tensorflow) vorgefertigten Images gibt. 
Wir müssen untersuchen, wie wir dieses Problem bis **Q4 2022** beheben können.
* Wir werden die Zielversion für Python auf **3.10** in **Q1 2023** ändern, wenn wir das Tensorflow-Problem gelöst haben.
* Die Unterstützung für **3.6** wird in **Q4 2022** enden. Wir werden Python 3.6 danach nicht mehr testen und einbinden.
* Wir beginnen mit der Unterstützung von **3.11** in **Q1 2023**.
* Wir werden **3.12** ab **Q2 2023** unterstützen (:Achtung: wird keine distutils mehr haben)
* Die Unterstützung für **3.7** wird in **Q2 2023** enden.
* Unterstützung für **3.8** wird in **Q3 2023** enden.
* Unterstützung für **3.9** wird in **Q4 2023** enden.

## Basis-OS-Image

* Unser aktuelles Basis-Image für das Deployment ist **Ubuntu 18.04**, 
wir unterstützen **Ubuntu 18.04**, **20.04** und **22.04**.
* Wir werden das Basis-Image auf **Ubuntu 20.04** im **Q4 2022** ändern.
* Wir werden das Basis-Image auf **Ubuntu 22.04** im **Q1 2023** ändern.
* Der Support für **Ubuntu 18.04** wird im **Q1 2023** enden.
* Der Support für **Ubuntu 20.04** wird im **Q2 2024** enden.

## Software-Bibliotheken

### [calamari](https://github.com/OCR-D/ocrd_calamari)

* Unsere derzeit unterstützte calamari-Version ist **1.x**.
* Wir werden in **Q1 2023** auf **2.x** umsteigen.

* Die Unterstützung für **1.x** wird in **Q1 2022** enden.

### [pillow](https://pillow.readthedocs.io/)

* Wir unterstützen derzeit Pillow **5.x** bis **v9.x**.

### [tensorflow](https://github.com/tensorflow/tensorflow)

* Unsere Zielversion ist **2.5.0**.
* Wir unterstützen derzeit **1.15.x**, **2.4.0** und **2.5.0**.
  Obwohl wir die Abkehr von **1.15.x** dringend empfehlen, haben wir aufgrund der
  Logistik der Aktualisierung der trainierten Modelle keinen festes
  Stichtag.

### [torch](https://pytorch.org/)

* Unsere aktuelle Zielversion ist **1.10.x**.

### [bash]

* Wir verwenden bash-Skripte für Entwicklungsaufgaben und für die bashlib-Bibliothek in OCR-D.
* Unsere derzeitige Zielversion ist **4.4**.