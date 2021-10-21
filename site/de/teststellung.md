---
layout: page
lang-ref: initial-tests
lang: de
title: Ergebnisse und Erkenntnisse der ersten OCR-D-Teststellung
toc: true
---

# Ergebnisse und Erkenntnisse der ersten OCR-D-Teststellung

## Hintergrund

Um die Jahreswende 2019/2020 wurde die OCR-D-Software erstmals in neun
Pilotbibliotheken getestet. Damit sollte die praktische Akzeptanz der Software
bei künftigen, potentiellen Nutzer\*innen sichergestellt werden, weshalb der Fokus auf
deren Funktionalität und Einsetzbarkeit in der Praxis lag. An der Teststellung
teilgenommen haben neben den Häusern des Koordinierungsprojekts auch zwei an
den Modulprojekten beteiligte Bibliotheken sowie vier weitere Bibliotheken. Die
Erkenntnisse dieses ersten Testlaufs fließen in die Weiterentwicklung des
OCR-D-Prototypen ein.

Alle Pilotbibliotheken verfügen über erste Kenntnisse und Erfahrungen zu OCR,
da sie zumindest auf Projektebene bzw. über Dienstleister bereits Volltexte
erstellt haben. Inwieweit die als wichtig angesehene OCR künftig eigenständig
durchgeführt und fest im Digitalisierungsworkflow verankert werden soll, wird
derzeit noch in den Häusern abgestimmt. Für welche Nutzergruppe Volltexte
erstellt werden, wird von den einzelnen Häusern unterschiedlich angegeben.
Während ein Drittel allgemein GeisteswissenschaftlerInnen nennt, möchte ein
weiteres Drittel eine sehr breite Zielgruppe (Geisteswissenschaft, Digital
Humanities, Computerlinguistik und Wirtschaftswissenschaften) bedienen. Die
übrigen Bibliotheken sehen lediglich einen kleinen Nutzerkreis (Digital
Humanities oder Computerlinguistik) als Zielgruppe der OCR-Texte.

An eine OCR-Software stellen die Pilotbibliotheken die folgenden Anforderungen:
* hohe Erkennungsrate von Layout und Text
* kostengünstiger Einsatz
* schnelle Adaptierbarkeit/Fehlerbehebung
* Modularität
* Ausgabe in Standardformate
* Anbindung an existierende Workflows
* gut dokumentierte Schnittstellen
* Wortkoordinaten
* Trainierbarkeit
* umfangreiche GT Korpora

Am wichtigsten ist die hohe Qualität der Texterkennung, die weiteren Merkmale
werden jeweils nur von einem Teil der Pilotbibliotheken angegeben und dürften
als gewünschte, aber untergeordnete fakultative Merkmale angesehen werden.


## Auswertung der Softwaretests

Um die Vergleichbarkeit der einzelnen Tests in den Pilotbibliotheken
gewährleisten zu können, wurde ein Fragebogen erstellt, der zu Beginn der
Teststellung an die Pilotbibliotheken ausgegeben wurde. In diesem werden die
Rahmenbedingungen des Testlaufs, bspw. die verwendete technische Ausstattung
und die getesteten OCR-D-Prozessoren, sowie die Dokumentation der Software,
Schnittstellen, Funktionalität bzw. Benutzbarkeit der Software, deren
Möglichkeiten zur Einbindung in existierende Workflows und die jeweils
benötigten Ausgabeformate erfasst. Mit Erkennungsqualität, Funktionalität bzw.
Benutzbarkeit, offenen Anforderungen sowie positiven Merkmalen der
OCR-D-Software wurde außerdem nach den Ergebnissen der Teststellung gefragt.

In der Teststellung wurden die verschiedenen Möglichkeiten zur Installation der
OCR-D-Software mit und ohne Docker-Container genutzt und die Software
erfolgreich auf einer breiten Auswahl an unterschiedlich leistungsstarken,
teils virtuellen Servern installiert. Bei Nicht-Intel-Rechnern (ARM, PowerPC64)
war diese komplizierter und zeitaufwändiger, da einzelne Python-Pakete auf
diesen Rechnern nicht ausführbar waren und erst manuell angepasst werden
mussten. Die während der Teststellung entwickelte Gesamt-Installation aller
verfügbarer OCR-D-Prozessoren (``ocrd_all``) wurde als einfachste und
unaufwändigste Variante dabei als am empfehlenswertesten bestätigt. In eine
Workflow-Software wie bspw. Kitodo wurde die OCR-D-Software an keiner
Pilotbibliothek integriert, da der Aufwand für eine Einbindung der Software für
den Testlauf zu hoch gewesen wäre. 

Als Herausforderung wurde die Verwendung der zahlreichen OCR-D-Prozessoren
beschrieben. Hier bereitete weniger deren Aufruf Probleme, als das Verständnis
von deren jeweiligem Einsatzbereich und insbesondere Auswahl sowie
Zusammenstellung der Prozessoren zu sinnvollen Workflows. Für die erste
Teststellung lag neben der technischen Dokumentation der Software noch keine
Gesamtdokumentation zu deren Nutzung vor, die sich auch an im OCR-Bereich
unerfahrene Anwender richtet. Die Anforderungen und Wünsche der Tester an eine
solche Dokumentation wurden noch in der Ausarbeitung der inzwischen [im
Nutzerbereich der OCR-D-Website eingestellten
Anleitungen](https://ocr-d.de/de/use) berücksichtigt. 

Die OCR-D-Software läuft insgesamt sehr stabil, Abbrüche wurden von keiner
Bibliothek gemeldet. Die benötigten Ausgabeformate werden bereits alle
angeboten, wohingegen die wenigen noch erforderlichen Arbeiten im Bereich der
Schnittstellen für die Weiterentwicklung des Prototyps eingeplant sind.

Die Erkennungsqualität wurde von den jeweiligen Pilotbibliotheken nur an
einzelnen Seiten überprüft, da zu den Testbüchern kein Ground Truth vorliegt.
Insgesamt sind die Ergebnisse dieses ersten Testlaufs vielversprechend. Die UB
Mannheim hat OCR-D mit Fokus auf die Tesseract-Prozessoren bspw. an fünf
Drucken des 16. bis 19. Jahrhunderts getestet. An Antiqua-Drucken des 17. und 18.
Jahrhunderts sowie einem Fraktur-Text aus dem 19. Jahrhundert konnten
erwartungsgemäß die besten Ergebnisse von - im Falle der Antiqua deutlich -
unter 0,1 CER bei den Rohdaten erzielt werden, wohingen der Frakturdruck aus
dem 17. Jahrhundert leicht über 0,1 CER lag. Die größte Herausforderung stellte
die Fraktur aus dem 16. Jahrhundert dar, bei der lediglich ein CER von knapp
unter 0,16 erreicht werden konnte. Einen umfassenden Einblick in ihre
Teststellung gibt die BBAW, deren [Bericht und Daten öffentlich
einsehbar](https://github.com/tboenig/ocrd_bbaw_pilotbibliothek) sind.

Desiderate formulieren die OCR-D-Tester insbesondere bei Dokumentation,
Qualität bzw. Benutzbarkeit der Prozessoren sowie perspektivisch deren
Skalierbarkeit. Die benannten Anforderungen an die Dokumentation der
OCR-D-Software wurden bereits weitgehend umgesetzt, wobei Dokumentation
insgesamt als kontinuierliche Aufgabe aufgefasst wird in die sukzessive vor
allem auch praktische Erfahrungen in der Anwendung der OCR-D-Software
einfließen müssen. Im Bereich der Prozessoren wären v.a. zu Layouterkennung und
Nachkorrektur noch Verbesserungen wünschenswert. Die entsprechenden
Entwicklungen der OCR-D-Modulprojekte konnten durch ihr Entwicklungsstadium
bzw. ihre speziellen technischen Anforderungen (GPU) nur bedingt getestet
werden. Mit deren Ergebnissen oder auch weiteren Modellen können die oben
genannten Desiderate hoffentlich bedient werden. Für den Einsatz der
OCR-D-Software in der Massendigitalisierung ist die Laufzeit mehrerer
Prozessoren - wie ursprünglich für die dritte Projektphase geplant - noch zu
optimieren, außerdem sollten die Möglichkeiten zur Parallelisierung ausgebaut
werden. 

Positiv von den Testern hervorgehoben wird der modulare und transparente Aufbau
der OCR-D-Software, der diese besonders auszeichnet und die Konfiguration
optimaler Workflows für konkrete Anwendungsfälle erlaubt. Außerdem können die
Open Source verfügbaren Python-Programme bei Bedarf von jeweils darauf
spezialisierten Experten weiterentwickelt werden und ohne aufwändige
Programmierarbeiten für Experimente zum OCR-Workflow genutzt werden. Bei Fragen
und Problemen leisten die Entwickler rasch niedrigschwelligen Support.
Insgesamt ist es vergleichsweise einfach möglich, die robust laufende, wenn
auch noch weiter zu optimierende OCR-D-Volltexterstellung anzustoßen, die
bereits vielversprechende Ergebnisse liefert.


