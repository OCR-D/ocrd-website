---
layout: page
toc: true
lang: de
title: "OCR-D: Anforderungsprofil für die Dokumentation der Modulprojekte"
---

# OCR-D: Anforderungsprofil für die Dokumentation der Modulprojekte

# ![](https://avatars0.githubusercontent.com/u/26362587?s=200&v=4) ![](https://www.dita-ot.org/images/dita-logo.png =100x) ![](https://upload.wikimedia.org/wikipedia/commons/4/48/Markdown-mark.svg =100x)


**Allgemein:**  Die Dokumentation der Tools und Schnittstellen betrifft sowohl die Anwendung selbst (Anwendungsdokumentation) als auch deren Anwendung von Nutzern (Benutzerdokumentation).
Das OCR-D: Anforderungsprofil für die Dokumentation der Modul Projekte stellt nicht eine DITA-Einführung oder DITA-Dokumentation dar, das gleiche betrifft die Markdown Auszeichnungssprache. In dieser Dokumentation werden ergänzende Informationen sowie unmittelbare Anforderungen für eine OCR-D konforme Dokumentation dargelegt. 

**Adressaten der Dokumentation:**
Es sollen sowohl Techniker, die vor allem Informationen zur **Anwendung** benötigen (Installation, Wartung sowie Integration im Umfeld der eigenen Werkzeuge), als auch **Benutzer**, die das Werkzeug nutzen möchten bzw. mit der Anwendung ein bestimmtes Ergebnis erzielen möchten im Rahmen der *Anwendungsdokumentation* und *Benutzerdokumentation* informiert werden. 


**Stil:** Der Stil der Dokumentation sollte verständlich und in kurzen Sätzen abgefasst sein. Die Dokumentation muss alle Aspekte der Anwendung und Benutzung umfassend beinhalten.

**Format:** Die Dokumentation ist entweder im xmlbasierten DITA-Format oder im Auszeichnungsformat Markdown (Markdown-DITA-Syntax) abzufassen.

**Software:** Zur Erstellung der Dokumentation wird ein Editor  (empfohlen wird ein Editor, mit XML-Unterstützung) sowie das DITA-OT (Open Toolkit) benötigt. Nähere Information finden sich unter: https://www.dita-ot.org/



# Die Erstellung der Dokumentation

Die Erstellung der Dokumentation erfolgt stufenweise. 

Die *erste Stufe* bildet die Dokumentation des Werkzeuges in Form der ocrd_tool.json (siehe https://ocr-d.github.io/ocrd_tool).

In der *zweiten Stufe* werden manuell u. a. Funktionen, Parameter, Fehlerbehandlungen der Anwendung in Form einzelner Dateien entsprechend den folgenden Formatvorgaben abgefasst.

## Strukturvorgaben

Die Dokumentation sollte wie folgt strukturell aufgebaut sein. Auf Grund der Adressaten der Dokumentation können Schwerpunkte unterschiedlich gesetzt werden.

Zum Beispiel wird der Schwerpunkt auf die *Benutzerdokumentation* gelegt, sollte auf folgende Punkte geachtet werden:
1. Was kann man mit dem Tool machen? Welches Ergebnis ist von der Anwendung zu erwarten.
2. Wie wird die Anwendung bedient?
3. Welche Probleme und Fehlermeldungen können auftreten.


Bei der Abfassung ist folgendem allgemeinem Aufbau zu folgen. 

<table border="0">
<tr><th>Strukturvorgaben</th><th>Erstellung</th><th>Vorlagen</th></tr>
<tr><td>1. Tool name</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
<tr><td>2. Release notes</td><td><i>manuell erstellen</i></td><td>releaseNote.md</td></tr>
<tr><td>3. Installation</td><td><i>manuell erstellen</i></td><td>installation.md</td></tr>
<tr><td>4. Simple tool description</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
<tr><td>5. Description</td><td><i>manuell erstellen</i></td><td>Description.md</td></tr>
<tr><td>6. Option</td><td><i>manuell erstellen</i></td><td>Option.md</td></tr>
<tr><td>7. Input format description</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>InputFormatDescription.md</td></tr>
<tr><td>8. Parameters</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
<tr><td>9. Output format description</td><td><i>manuell erstellen</i></td><td>OutputFormatDescription.md</td></tr>
<tr><td>10. Troubleshooting</td><td><i>manuell erstellen</i></td><td>Troubleshooting.dita</td></tr>
<tr><td>11. Resources</td><td><i>manuell erstellen</i></td><td>Resources.md</td></tr>
<tr><td>12. Glossar</td><td><i>manuell erstellen</i></td><td>Glossar.dita</td></tr>
<tr><td>13. Authors</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
<tr><td>14. Reporting</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
<tr><td>15. Copyright</td><td>Inhalt der <i>ocrd_tool.json</i></td><td>Markdown-Datei aus <i>ocrd_tool.json</i> generiert</td></tr>
</table>

## Die Dokumentation schreiben

Das unmittelbare Schreiben stellt die *zweite Stufe* der Dokumentation dar. 
Anhand der Strukturvorgaben ist zu sehen, dass die Dokumentation nicht aus einer homogenen in sich geschlossenen Beschreibung besteht. Sondern einzelne Aspekte u. a. der Name des Werkzeuges, der Installations- und Bedienungsteil, Fehlerbetrachtungen und eventuell weiterführende Hinweise Bestandteile oder Themenbereiche (Topics) der Dokumentation sind. Sowohl zur Schreibunterstützung als auch zum Lesen, der Veröffentlichung sowie der späteren Pflege werden vom OCR-D Projekt diese spezifischen Formatvorgaben vorgenommen. 


### DITA
"Die Darwin Information Typing Architecture (DITA) ist ein topic- und xmlbasiertes Dateiformat."[^1] DITA ist ein OASIS-Standard (Organization for the Advancement of Structured Information Standards).[^2] DITA ist ein Format, das die Dokumentation bei der Erstellung, Verbreitung und (Wieder)verwendung unterstützen soll.

[^1]:siehe: Seite „Darwin Information Typing Architecture“. In: Wikipedia, Die freie Enzyklopädie. Bearbeitungsstand: 5. April 2018, 15:34 UTC. URL: https://de.wikipedia.org/w/index.php?title=Darwin_Information_Typing_Architecture&oldid=175806494 (Abgerufen: 23. Mai 2018, 10:40 UTC)
[^2]: siehe https://de.wikipedia.org/wiki/Organization_for_the_Advancement_of_Structured_Information_Standards





#### Topics
Mit Hilfe von Topics werden in sich inhaltlich geschlossene spezifische Bestandteile der Dokumentation gegliedert und typisiert. Allgemein beinhaltet ein Topic immer die Angabe eines Titels (`<title>`), den sogenannten Textkörper (u. a. `<body>`) sowie beispielsweise einzelne Absätze (`<p>`) oder Listen (`<ul>`,  `<ol>`). Das Topic wird in der Regel in einer Datei gespeichert.


Folgende Topic-Typen stehen für die OCR-D Dokumentation zur Verfügung. Die einzelnen Topic-Typen basieren auf eigenen formalen Dokumentspezifikationen. Die kurzen Beschreibungen in der Tabelle basieren auf der DITA-Spezifikation 1.3.[^3]
[^3]: siehe http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/dita-v1.3-errata01-os-part3-all-inclusive-complete.html#dita_ref_topic

| Topic-Typ | Beschreibung | Konkordanz zur OCR-D Strukturvorgaben |Verweis|
| -------- | -------- | -------- | -------- |
| General task | Das *general task-Topic* beinhaltet allgemein abgefasste Handlungsanweisungen. Diese können in einzelnen Abschnitten <steps> angeordnet werden. Im Unterschied zum *strict task-Topic* können in diesem <steps-informal> verwendet werden. Die <steps-informal> beschreiben in einem umfangreichen Absatz den einzelnen Schritt mit dem jeweiligen Kontext.  |3. Installation (alternative Möglichkeit)|http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-generic-task-topic.html#dita_generic_task_topic |
| Task topic (strict task) | Das *task topic (strict task)* beinhaltet die Handlungsanweisungen die notwendig sind zur Bedienung des jeweiligen Werkzeuges. Dabei werden die einzelnen notwendigen Schritte klar in einzelnen <step> dokumentiert. Ein Schritt-Element <step> beinhaltet immer ein Komanndozeilen-Element <cmd>. |3. Installation|http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-task-topic.html#dita_task_topic|
| Concept |Das *concept-Topic* beinhaltet maßgebende Informationen, die zur Bedienung des Werkzeuges notwendig sind. Das Topic kann dabei notwendiges Hintergrundwissen für die Bedienung und den Umgang mit dem Werkzeug bieten sowie Definitionen oder Erklärungen enthalten. |4. Simple tool description| http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-concept-topic.html#dita_concept_topic|
| Reference |Das *reference-Topic* konzentriert sich auf die unmittelbaren Informationen des Werkzeuges oder einer spezifischen Schnittstelle. Mit dem Reference-Topic soll der Nutzer schnell und präzise informiert werden. | 5. Input format description, 6. Input Parameters, 7. Output format description, 8. Setting Parameters | http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-reference-topic.html#dita_ref_topic|
| Troubleshooting |Das *troubleshooting-Topic* beinhalt Anweisungen zur Fehlerbehandlung. Dabei wird zuerst der Fehler oder die Symtome <condition> beschrieben und im darauf folgenden Lösungsteil der Grund <cause> für den Fehler benannt und abschließend die Lösung <remedy> des Fehlers dokumentiert. |8. Troubleshooting|http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-troubleshooting-topic.html#dita-troubleshooting-topic |
| Glossary entry | Im *glossary entry-Topic* wird die Bedeutung eines Begriffes oder Vorgehens definiert. Im <glossBody> kann der zu definierende Term näher beschrieben werden. | 11. Glossar |http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-glossary-topic.html#glossaryArch|
| Glossary group | Im *glossary group-Topic* können die einzelnen Glossary entry-Topic zusammengefasst werden.| 11. Glossar | http://docs.oasis-open.org/dita/dita/v1.3/errata01/os/complete/part3-all-inclusive/archSpec/technicalContent/dita-glossarygroup-topic.html|

### Markdown DITA syntax
Alternativ zum DITA-XML-Markup kann Markdown zur Abfassung folgender Topic-Typen für das Schreiben der Dokumentation genutzt werden. Die einfache Auszeichnungssprache Markdown im Besonderen *Markdown-DITA-Syntax* ist entsprechend der Dokumentation des DITA-Open Toolkit http://www.dita-ot.org/3.0/topics/markdown-dita-syntax-reference.html zu verwenden.

Folgende Topics werden in Markdown unterstützt:
* concept
* task (im Besonderen das Task topic: *strict task*)
* reference

Die Topic-Typen:
* troubleshooting
* glossary group
* glossary entry

sind ausschließlich in DITA zu schreiben.

#### Beispiele für Topics in der jeweiligen spezifischen Syntax in *Markdown-DITA-Syntax* oder *DITA*

##### **Beispiel:** für ein Topic *concept* in *Markdown-DITA-Syntax*

```markdown
# Simple tool description {#toolDescription .concept}

"A command-line interface or command language
interpreter (CLI), also known as command-line user interface,
console user interface and character user interface (CUI), is
a means of interacting with a computer program where the user
(or client) issues commands to the program in the form of
successive lines of text (command lines)." Source: Wikipedia
contributors. (2018, June 5). Command-line interface. In
Wikipedia, The Free Encyclopedia. Retrieved 12:45, June 6,
2018, from [Wikipeadia](https://en.wikipedia.org
/w/index.php?title=Command-line_interface&oldid=844566807)
```

##### **Beispiel:** für ein Topic *task* in *Markdown-DITA-Syntax*

```markdown
# Installation {#installation .task}

1.    erster Schritt
2.    zweiter Schritt

```


##### **Beispiel:** für ein Topic *reference* in *Markdown-DITA-Syntax*

```markdown
# Release Note {#releaseNote .reference}

The Command Line Interface (CLI) is a maintenance
release that fixes issues reported in OCR-D.

## Requirements
The CL can be used with all operating systems.
```

##### **Beispiel:** für ein Topic *troubleshooting* in *DITA*

```xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE troubleshooting 
PUBLIC "-//OASIS//DTD DITA 1.3 Troubleshooting//EN" "troubleshooting.dtd">
<troubleshooting id="Troubleshooting">
    <title>Troubleshooting</title>
    <troublebody>
        <condition>
            <title>Condition</title>
            <p></p>
        </condition>
        <troubleSolution>
            <cause>
                <title>Cause</title>
                <p></p>
            </cause>
            <remedy>
                <title>Remedy</title>
                <responsibleParty></responsibleParty>
                <steps>
                    <step>
                        <cmd></cmd>
                    </step>
                </steps>
            </remedy>
        </troubleSolution>
    </troublebody>
</troubleshooting>
```


##### **Beispiel:** für ein Topic *glossary group* in *DITA*

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE glossgroup 
PUBLIC "-//OASIS//DTD DITA Glossary Group//EN" "glossgroup.dtd">
<glossgroup id="Glossar">
    <title>Glossar</title>
    <glossentry id="txtline">
        <glossterm>Textline</glossterm>
        <glossdef>A TextLine is a block of text without line break.
        </glossdef>
    </glossentry>
    <glossentry id="gt">
        <glossterm>Ground Truth</glossterm>
        <glossdef>Ground truth (GT) in the context of OCR-D are
        transcriptions, specific structure descriptions and word lists.
        These are essentially available in PAGE XML format in
        combination with the original image. Essential parts of 
        the GT were created manually.
        </glossdef>
</glossgroup>
```

##### **Beispiel:** für ein Topic *glossary entry* in *DITA*

```xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE glossentry 
PUBLIC "-//OASIS//DTD DITA Glossary//EN" "glossary.dtd">
<glossentry id="gt">
    <glossterm>Ground Truth</glossterm>
    <glossdef>Ground truth (GT) in the context of OCR-D are
    transcriptions, specific structure descriptions and word lists.
    These are essentially available in PAGE XML format in combination
    with the original image. Essential parts of the GT were created
    manually.
    </glossdef>
</glossentry>
```

### Technische Organisation der Dokumenation

Technisch organisiert und zusammengefasst wird die DITA-Dokumentation mit einer sogenannten DITA-Map. Die DITA-Map ähnelt einem Inhaltsverzeichnis, die die Topics auflistet. Die Topics sind in einzelnen Dateien gespeichert.

#### Beispiel DITA-Map ocr-d.ditamap


```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "map.dtd">
<map>
<title>Titel der Dokumentation</title>
    <topicref href="releaseNote.md"/>
    <topicref href="installation.md"/>
    <topicref href="simpletoolDescription.md"/>
    <topicref href="toolDescription.md"/>
    <topicref href="Option.md"/>
    <topicref href="InputFormatDescription.md"/>
    <topicref href="Parameters.md"/>
    <topicref href="OutputFormatDescription.md"/>
    <topicref href="Troubleshooting.dita"/>
    <topicref href="Glossar.dita"/>
    <topicref href="Authors.md"/>
    <topicref href="Reporting.md"/>
    <topicref href="Copyright.md"/>
</map>

```

### Die Verwendung des DITA-Open Toolkits zur Publikation der Dokumentation

Für die Generierung der Dokumentation ist die Kommandozeilen-Anwendung des DITA-Open Toolkits (http://www.dita-ot.org/3.0/topics/build-using-dita-command.html) zu verwenden.

Mit dieser Anwendung können verschiedene Formate der Dokumentation erstellt werden. Für die finale Dokumentation (Publikation) des OCR-D Moduls ist nur das Format DITA gefordert. Wird die Dokumentation in DITA geschrieben ist die Nutzung der Kommandozeilen-Anwendung nicht notwendig. Bei der Verwendung mit Markdown ist eine Konvertierung mit der Kommandozeilen-Anwendung  notwendig.

Aber auch zur Korrektur oder zur Vollständigkeitskontrolle ist eine Konvertierung in ein Präsentationsformat von Nutzem. Es können u. a. folgende Präsentionsformate erstellt werden:
* html5
* pdf
* troff
* xhtml

#### Beispiel Kommandoaufruf für DITA-OT
1.  Für die Erstellung einer *DITA-Ausgabe* aus der `ocr-d.ditamap` Datei

```sh
dita --input=ocr-d.ditamap --format=dita --output=output/dita     
```

2.  Für die Erstellung einer *html5-Ausgabe* aus der `ocr-d.ditamap` Datei

```sh
dita --input=ocr-d.ditamap --format=html5 --output=output/html5
```


### Impressum und und Datenschutzerklärung

Folgendes Impressum ist der Dokumentation anzufügen:

#### Impressum und Datenschutzerklärung

Nachstehend finden Sie die gesetzlich geregelten Pflichtangaben zur Anbieterkennzeichnung sowie rechtliche Hinweise zur Dokumentation des Modulprojektes: XXX des OCR-D Projektes.

**Anbieter**

Anbieter dieser Internetpräsenz ist im Rechtssinne XXX


    [es folgt die Adresse]

    [es folgt der Vertreter]

Das Modul-Projekt wird vertreten durch XXX.

    [es folgt der Redaktionsverantwortliche mit Angabe der Persion und Adresse]



### Lizenz der Dokumentation

Die Dokumentation liegt unter dem xmlbasierten Format DITA [http://docs.oasis-open.org/dita/dita/v1.3/dita-v1.3-part3-all-inclusive.html] vor und kann unter der Creative Commons-Lizenz CC BY-SA 4.0 DE (https://creativecommons.org/licenses/by-sa/4.0/de/) genutzt werden.


<!--### Speicherung der Dokumentation-->



