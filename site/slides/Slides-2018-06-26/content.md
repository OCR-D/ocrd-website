layout: true
  
<div class="my-header"></div>

<div class="my-footer">
  <table>
    <tr>
      <td>OCR-D-Entwicklerworkshop 2018</td>
      <td style="text-align:right"><a href="https://ocr-d.de">Stand der OCR-D Eigenentwicklungen</a></td>
    </tr>
  </table>
</div>

---

class: title-slide

# Stand OCR-D Eigenentwicklungen

| Konstantin Baierer                                                                  | Kay-Michael Würzner                           |
| :-------------------------------------------:                                       | :-------------------------------------------: |
| [konstantin.baierer @sbb.spk-berlin.de](mailto:konstantin.baierer@sbb.spk-berlin.de) | [wuerzner @bbaw.de](mailto:wuerzner@bbaw.de)   |

---

# Überblick

  - Integrationskonzept
  - Specs und Toolkits
  - Wanderungen durch GitHub

---

# Integrationskonzept

  * **Fokus: Kommandozeile**
  * Einfachster Weg, Tools in verschiedenen Programmiersprachen zu verbinden
  * Installierbar
  * Isolierbar
  * Deploybar

---

# Spezifikation und Werkzeugkasten

  * Spezifikation
    * Richtlinien und Konventionen zu Datenformaten
    * Anforderungen an Schnittstellen
    * Testbare Aussagen um Abläufe möglichst normativ zu gestalten
  * Werkzeugkasten
    * Verifizieren der Spezifikation durch Implementieren des OCR-D-Frameworks
    * Verifizieren des OCR-D-Frameworks durch Referenzimplementierungen

---

# OCR-D Github Org

* Öffentliches Software-Repository:

  * Spezifikationen und Dokumentation `spec`, `docs`
  * Framework `core`, `assets`
  * Referenzimplementierungen => `ocrd_*`
  * Varia (Slides, Forks, Tests...)

---

# [`spec`](https://github.com/OCR-D/spec)

* Richtlinien und Anforderungen:

  * Ein- und Ausgabeformate
  * Schnittstellenanforderungen
  * Perspektivisch: Deployment (Swagger, Docker, ...)

* Fokus: **Normativ**

> Aktuell in https://ocr-d.github.io/

---

# [`docs`](https://github.com/OCR-D/docs)

* Anleitungen und Rezepte

  * Cookbook
  * Metadokumentation
  * Beispiele

* Fokus: **Anwendung**

---
 
# [`core`](https://github.com/OCR-D/core)

  * Umsetzung der Spezifikationen als Python-Toolkit
  * API für Formate (PAGE, METS)
  * Kommandozeilenschnittstelle zur Pythonschnittstelle zur Spezifikation
  * Perspektivisch: Wrapping als Web-Service

---

# [`assets`](https://github.com/OCR-D/assets)

  * Autoritative Testdaten
    * Primärdaten (Bilder, Texte)
    * Prozessdaten
  * Kontinuierliche Integration (Unit Tests)
  * Integrierter Webserver

---

# Referenzimplementierungen

  * Test von Grundfunktionalitäten des OCR-Workflows
  * Illustration des Integrationskonzepts
  * Wird kontinuierlich erweitert
  * Beispiele:
    * [`ocrd_tesserocr`](https://github.com/OCR-D/ocrd_tesserocr)
    * [`ocrd_kraken`](https://github.com/OCR-D/ocrd_kraken)
    * [`ocrd_ocropy`](https://github.com/OCR-D/ocrd_ocropy)

---

# Varia

  * Entwicklung und Integration in teaminternem monorepo
  * [`ocrd-train`](https://github.com/OCR-D/ocrd-train)
    * Trainieren von tesseract4 mit Makefile
  * [Präsentationen](https://ocr-d.github.io/slides/) des OCR-D-Teams
  * Forks, u.a. [`PAGE-XML`](https://github.com/OCR-D/PAGE-XML)

---

class: title-slide

# Keep in touch

  * Github: https://github.com/OCR-D
  * Issues: https://github.com/OCR-D/spec/issues
  * Gitter: https://gitter.im/OCR-D/Lobby
