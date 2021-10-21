---
layout: page
lang-ref: about
lang: de
toc: true
title: Das OCR-D-Projekt
---

# Das OCR-D-Projekt

## Hintergrund

Mit den Verzeichnissen der im deutschen Sprachraum erschienenen Drucke des 16.–18. Jahrhunderts (VD 16, VD 17, VD 18) wird eine retrospektive Nationalbibliografie des frühneuzeitlichen Schriftguts aus dem deutschsprachigen Raum erstellt. Um der Forschung die Zugänglichkeit zu diesen Texten zu erleichtern, wurden und werden große, konzertierte Anstrengungen unternommen, Volldigitalisate oder Schlüsselseiten zu den einzelnen verzeichneten Titeln digital bereitzustellen.

Mit Blick auf die Entwicklungen und neuen Möglichkeiten im Bereich der Optical Character Recognition (OCR) haben Experten im März 2014 im Rahmen eines DFG-Workshops die Volltexttransformation der VD als ambitioniertes, aber erreichbares Ziel eingeschätzt. Die Verfügbarmachung von Volltexten zum Zweck der Volltextsuche und Weiterbearbeitung, bspw. mit Werkzeugen der Digital Humanities, ist ein großes Desiderat der Forschung, das durch eine koordinierte Förderinitiative zu bearbeiten ist.

OCR ist ein umfassender Prozess, der typischerweise eine Abfolge von mehreren Schritten im Workflow beinhaltet: Neben der reinen Erkennung von Buchstaben und Wörtern werden Techniken wie die Vorverarbeitung (Bildoptimierung und Binarisierung), die Layoutanalyse (Erkennung und Klassifizierung von Strukturmerkmalen wie Überschriften, Absätzen usw.) und die Nachbearbeitung (Fehlerkorrektur) angewendet. Während die meisten dieser Schritte auch von der Nutzung von Tiefen Neuronalen Netzen profitieren können, sind bisher kaum freie und offene Standardwerkzeuge und damit verbundene Best Practices entstanden. Die Volltexterkennung historischer Dokumente wird insbesondere durch deren große Variabilität in Schriftart, Layout, Sprache und Orthographie erschwert.

## Ziele und Aufbau des OCR-D-Projekts
Hier setzt das DFG-geförderte Projekt OCR-D an, dessen Hauptziel die konzeptionelle und technische Vorbereitung der Volltexttransformation der VD ist. Die Aufgabe der automatischen Volltexterkennung wird in ihre einzelnen Prozessschritte zerlegt, die in der Open Source OCR-D-Software nachvollzogen werden können. Dies ermöglicht es, optimale Workflows für die zu prozessierenden alten Drucke zu erstellen und damit wissenschaftlich verwertbare Volltexte zu generieren.

Dazu wurde ein Koordinationsprojekt gebildet, das in der ersten Projektphase Entwicklungsbedarfe identifizierte. Diese wurden in der [zweiten Projektphase](phase2) von insgesamt acht Modulprojekten bearbeitet. In der derzeitigen [dritten Projektphase](phase3) steht die konzeptionelle Vorbereitung für die automatische Generierung von Volltexten für die Verzeichnisse der im deutschen Sprachraum erschienenen Drucke des 16., 17. und 18. Jahrhunderts im Fokus. Außerdem arbeiten vier Implementierungsprojekte daran, OCR-D in bestehende Anwendungen und Infrastrukturen zu integrieren, während drei Modulprojekte OCR-D-Werkzeuge weiter optimieren.

<p class="figure img" style="max-width: 100%">
	<a href="/assets/Funktionsmodell.svg" style="max-width: 100%">
		<img src="/assets/Funktionsmodell.svg" style="max-width: 100%">
	</a>
</p>

Volltexterkennung wird dabei als ein komplexer Prozess aufgefasst, der neben der eigentlichen Texterkennung mehrere vor- und nachgelagerte Schritte einschließt (vgl. Abbildung). Zunächst wird ein Bilddigitalisat im Preprocessing für die Texterkennung aufbereitet, indem es nach Bedarf in ein Schwarz-Weiß-Bild umgewandelt (Binarization), zugeschnitten (Cropping), begradigt (Deskewing), entzerrt (Dewarping) und von Flecken bereinigt (Despeckling) wird. Im Anschluss erfolgt die Layouterkennung, die die Textbereiche einer Seite bis auf Zeilenebene identifiziert. Besonders die Erkennung der Zeilen bzw. der Grundlinie ist wichtig für die anschließende eigentliche Texterkennung, die in allen modernen Ansätzen auf Neuronalen Netzen beruht. Danach werden die einzelnen Strukturen bzw. Elemente des volltexterkannten Dokuments ihrer typografischen Funktion nach klassifiziert und das OCR-Ergebnis ggf. in der Nachkorrektur verbessert, bevor es in Repositorien zur Langzeitarchivierung überführt wird.

Neben der anvisierten Volltexttransformation von VD-Titeln (16.–19. Jahrhundert), die im Rahmen des OCR-D-Projekts technisch und konzeptionell vorbereitet wird, verfolgt OCR-D die folgenden weiteren Ziele:
*   die Erstellung von [Referenzkorpora](data) zum Trainieren und Testen
*   die Erarbeitung von [Standards in den Bereichen Metadaten, Dokumentation und Ground Truth](spec)
*   die Weiterentwicklung einzelner Verarbeitungsschritte, wobei der Fokus insbesondere auf der Optical Layout Recognition (OLR) liegt
*   die Analyse vorhandener Tools und deren Weiterentwicklung
*   die Erstellung [nachnutzbarer Softwarepakete](http://www.github.com/ocr-d)
*   die Erstellung von Verfahren der Qualitätssicherung

## Community
In allen Schritten begrüßen wir einen regen Austausch mit Kolleginnen und Kollegen aus anderen Projekten und Einrichtungen sowie Dienstleistern, um schließlich ein konsolidiertes Verfahren zur OCR-Verarbeitung von Digitalisaten des gedruckten deutschen Kulturerbes des 16.–19. Jahrhunderts realisieren zu können. 
Zu diesem Zweck gibt es bereits eine aktive Community, die unter anderem über unseren [Chat](https://gitter.im/OCR-D/Lobby) oder unsere [regelmäßig stattfindenden Onlinemeetings](community) erreicht werden kann. 
Interessierte aus Wissenschaft und Praxis sind ebenso willkommen wie Privatpersonen, die OCR-D nutzen (möchten).

Auf unserer Website finden Sie außerdem eine [Sammlung von (wissenschaftlichen) Publikationen und Vorträgen](publications) zum Thema OCR(-D) unserer aktuellen und ehemaligen Projektbeteiligten.

## Ergebnisse vergangener Projektphasen
Derzeit befindet sich OCR-D in der dritten Projektphase. Ergebnisse der vergangenen Projektphasen können Sie auf diesen Seiten jederzeit nachlesen:
* [Nutzer*innenumfrage [Phase I]](user_survey)
* [Modulprojekte aus Phase II](phase2)
* [Pilotstudie [Phase II]](teststellung)