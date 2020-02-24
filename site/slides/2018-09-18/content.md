layout: true
  
<div class="my-header"></div>

<div class="my-footer">
  <table>
    <tr>
      <td style="text-align:left"><a href="http://ocr-d.github.io/2018-09-18">http://ocr-d.github.io/2018-09-18</a></td>
      <td style="text-align:right"><a href="http://ocr-d.github.io/2018-09-18">OCR MP VC 2018-09-18</a></td>
    </tr>
  </table>
</div>

---

class: title-slide

# OCR-D MP VC

| |
| :-------------------------------------------:                                        |
| Elisa Herrmann
| Kay Würzner |
| Matthias Boenig |
| Volker Hartmann |
| Clemens Neudecker |
| Konstantin Baierer |

## [http://ocr-d.github.io/2018-09-18](http://ocr-d.github.io/2018-09-18)

---

# Coordination project updates

* Extension granted
* Quality assurance proposal submitted

---

# Ground Truth

* Call for tenders complete
* High-Quality ground truth in wided variety of literature
* Changed requirements => re-processing of existing GT in Q4 2018

---

# JLCL Special Issue

* Publication date ~ October 15th
* GT4HistOCR: [paper on arxiv](https://arxiv.org/abs/1809.05501), [data on zenodo](https://zenodo.org/record/1344132)

---

# Data storage

* OCR-D research data repository
* Long-term preservation archive
* Ground truth repository
* Model repository
* Font repository
* Software repository

---

# Software Best Practices

MUST:
* Publish on GitHub
* Test scripts (use [OCR-D/assets](https://github.com/OCR-D/assets) for test data)
* Minimal documentation
* [Dockerfile](https://ocr-d.github.io/docker)

NICE
* [Semantic Versioning](http://semver.org/) and [releases](https://github.com/OCR-D/spec/releases)
* [Changelog](https://github.com/OCR-D/spec/blob/master/CHANGELOG.md)
* [Continuous Integration](https://github.com/OCR-D/core/blob/master/.travis.yml)

---

# Minimal Documentation

* One file [`LICENSE` with text of Apache 2.0 license in root](https://github.com/OCR-D/core/blob/master/LICENSE)
* One file `README.md` with short description
* One file [`ocrd-tool.json` with formal description of repository and tools](https://ocr-d.github.io/ocrd_tool)

 

* Documentation on Documentation in Q4 2018

---

# GitHub Updates

* Many fixes in [spec](https://github.com/OCR-D/spec), [core](https://github.com/OCR-D/core), [assets](https://github.com/OCR-D/assets)
* [ocrd-train](https://github.com/OCR-D/ocrd-train) for training tesseract
* Current versions:
  * spec: 2.3.0
  * core: 0.8.2
  * assets: rolling

---

# Technical issues

* Serialization of processed results
  * OCRD-ZIP now based on BagIt, [spec#70](https://github.com/OCR-D/spec/pull/70)
  * OCRD-GITZIP, [spec#73](https://github.com/OCR-D/spec/pull/70)
* Discrepancies in METS/PAGE data, [core#176](https://github.com/OCR-D/core/issues/176)
* Modelling inline segmentation/order ambiguity, [spec#72](https://github.com/OCR-D/spec/issues/72), [assets#13](https://github.com/OCR-D/assets/issues/13), [assets#12](https://github.com/OCR-D/assets/issues/12)
* Modelling parameters representing files, [spec#69](https://github.com/OCR-D/spec/issues/69)
* ...

 

Please open/comment issues and let's [chat on gitter](https://gitter.im/OCR-D/Lobby).

---

# Progress reports by MP

Your turn :)

---

# Our questions for you

* Have GT requirements changed or new ones come up?
* How far along are alpha version implementing interfaces?
* Who will be using OCR-D/core? Those who do: Is it helpful?
* Are the specs clear? Too detailed? Not detailed enough?
* Have you been publishing articles recently?
* Satisfied with communication channels?

---

# Save the Dates!

* Bibliotheca Baltica, Oct 4/5. [Doodle for OCR-D meetup](https://doodle.com/poll/gbrwatuv3genbpfn)
* [DHd2019, CfP](https://dhd2019.org/call-for-papers/) Deadline September 30

---

# Vielen Dank

<center>
<img src="figures/end-man.png" height="400"/>
</center>

<center>
https://ocr-d.de
</center>

<center>
https://ocr-d.github.io
</center>

<center>
https://gitter.im/OCR-D/Lobby
</center>
