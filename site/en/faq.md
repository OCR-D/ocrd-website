---
layout: page
lang: en
lang-ref: faq
toc: true
title: FAQ
---
# FAQ

## General

### Where can I start my journey into the OCR-D ecosphere?

### Who is the target audience of OCR-D?

OCR-D's primary target audience are libraries and archives, digitizing
historical prints at scale.

### Where can I get support on OCR-D?

* Open an issue at the [OCR-D/core repository](https://github.com/OCR-D/core)
* Chat with OCR-D project members and other OCR-D users in [OCR-D's chat room](https://gitter.im/OCR-D/Lobby).
* Join us at our [regular calls](https://ocr-d.de/en/community).
* Send an email to [eckert[at]hab.de](mailto:eckert@hab.de?subject=Request%20via%20OCR-D.de)

### What is the difference between OCR-D and ABBYY?

ABBYY is a software developer producing the ABBYY Recognition Server which
offers layout detection and text recognition with a pay-per-page pricing model.
OCR-D is a project that integrates a wide variety of solutions for the full
gamut of possible OCR workflow steps. ABBYY is simple to use but offers few
options for customization whereas OCR-D workflows can be fine-tuned for best
recognition of specific corpora. OCR-D has a strong focus on historical prints,
trainable layout detection and text recognition and open interfaces to
accommodate future developments, whereas ABBYY performs more strongly for modern
print. Finally, OCR-D is a community effort with a strong focus on transparency
and Free Software.

### What is the difference between OCR-D and Tesseract?

[Tesseract](https://github.com/tesseract-ocr/tesseract) is the leading Free
Software OCR solution and tightly integrated into OCR-D in both a technical and
organizational sense. Technically, Tesseract has been wrapped as
[`ocrd_tesserocr`](https://github.com/OCR-D/ocrd_tesserocr), an OCR-D-compliant
processor that is more powerful than the command line tool bundled with
Tesseract. Organizationally, Tesseract maintainers and contributors have been
part of the OCR-D project from the beginning and the originally OCR-D-developed
Tesseract training tool
[`tesstrain`](https://github.com/tesseract-ocr/tesstrain) has been adopted by
the wider Tesseract community.

### What is the difference between OCR-D and TRANSKRIBUS?

[TRANSKRIBUS](https://transkribus.eu) is a software platform and server
infrastructure to make it easier for Digital Humanities practitioners to
collaborate on Handwriting Text Recognition. Apart from the different use cases
- historical prints for OCR-D, historical manuscripts for TRANSKRIBUS - there
are differences in philosophy: All components of OCR-D are freely available as
Apache-licensed Free Software whereas some core components of TRANSKRIBUS,
particularly the recognition engine, are proprietary. TRANSKRIBUS is a
server-client architecture with an Eclipse-based graphical user interface at
its core whereas OCR-D's focus is on mass digitization and command line
interaction.

<!--- ### What is the difference between OCR-D and ocr4all? --->

### Is OCR-D production-ready?

Yes! Several libraries in Germany (e.g. Staatsbibliothek Berlin, ULB Göttingen, ULB Sachsen-Anhalt) are already using OCR-D at a large scale, with over 10 million pages digitized already.

### Which formats are supported by OCR-D?

OCR-D is primarily based around METS as a container format and PAGE-XML for
layout detection and text recognition results. Other OCR formats such as ALTO,
hOCR or ABBYY FineReader XML are supported through conversion with
[`ocrd_fileformat`](https://github.com/OCR-D/ocrd_fileformat).

The preferred image format within OCR-D is TIFF but PNG and JPEG are also
supported. JPEG2000 is not currently supported but can be added in the future
if there is demand for it.

### Why does OCR-D need METS files? How can I process images without METS?

The processes within OCR-D are designed around METS for the simple reason that it is
such an ubiquitous and well-defined format used in libraries and archives
around the world. By relying on a container format instead of just images,
processors can make use of more information and can store detailed results in a
well-defined fashion.

If the data to be processed isn't already described by a METS file, the `ocrd` command line
tool offers simple ways to create new METS files or augment existing ones.

### How much does it cost to deploy OCR-D?

OCR-D is Free Software, licensed under the terms of the Apache 2.0 license and
will be free to use and adapt in perpetuity.

<!--- ### How are the full texts produced by OCR-D presented to the (library) user? Are they integrated into the library catalog and can therefore be used for full text search in the catalog? --->

### What are the system requirements for OCR-D-software?

The [`OCR-D/core`](https://github.com/OCR-D/core) framework is fairly light
compared with other interoperability platforms. System requirements therefore
depend on the actual processors to be used and the scale of the operation. It
is possible to use OCR-D on commodity hardware such as desktop PCs and laptops
but can also be deployed to massive servers or even single-board computers.

However, OCR workflows can be very memory-intensive, in particular when working
with large neural network models that have to be loaded into memory. We recommend
at least 16 GB of RAM to support even the most demanding workflow steps.

Another bottleneck for OCR workflows is input/output. We recommend storing data
on SSD instead of HDD.

## CLI

### How can I find out the version of OCR-D software?

To find the version of the OCR-D/core framework installed, run the `ocrd` CLI
with the `--version` flag:

```sh
$ ocrd --version
ocrd, version 2.2.2
```

All OCR-D processors also support the `--version` flag, e.g.:

```sh
ocrd-tesserocr-recognize --version
Version 0.7.0, ocrd/core 2.2.2
```

### How do I get help on `ocrd` CLI commands?

Every command and subcommand of the `ocrd` CLI tool supports the `--help`
option to print a description, arguments and options:

```sh
ocrd --help
ocrd workspace --help
ocrd workspace add --help
```

### How do I get help on OCR-D processors?

All OCR-D-compliant processors support the `-h/--help` flag as well:

```sh
$ ocrd-tesserocr-recognize --help
```

### How can I specify parameters on the command line?

Parameters to an OCR-D-compliant processor must be specified in the JSON syntax. The JSON data
can be passed to a processor with the `-p` CLI option, which can be either the filename of a file containing the JSON data or the JSON data itself:

```sh
ocrd-tesseract-recognize -I IN -O OUT -p '{"model": "Fraktur"}'
# same effect:
echo  '{"model": "Fraktur"}' > /tmp/params.json
ocrd-tesseract-recognize -I IN -O OUT -p /tmp/params.json
```

### How do I specify multiple input/output file groups?

You can specify multiple file group names for both input and output by joining
the names with a comma (`,`).

```
ocrd-tesserocr-recognize -I DEFAULT,REGIONS -O OCR-TESSSERACT
```

This would instruct `ocrd-tesserocr-recognize` to take images from the
`DEFAULT` group and region-segmented layout information from the `REGIONS`
group.

<!--- ### How to configure logging? --->

### How to stop tensorflow logging spam

> [@bertsky](https://github.com/OCR-D/core/pull/599)
>
> Another thing that needs to be added to tame TF is
> `os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'` – before the tensorflow module
> gets imported.

To achieve the same, run this before executing a TF-based processor in the
shell (or even add it to your `$HOME/.bashrc` to set this permanently):

```sh
export TF_CPP_MIN_LOG_LEVEL=3
```

<!--- ## OCR-D module project software -->

<!--- ### Where can I find official OCR-D module project software? --->

<!--- ### Which third-party OCR-D-compatible software exists? --->

<!--- ### Which processors are available? --->

<!--- ## Workflows and processors --->

<!--- ### How can I define workflows? --->

<!--- ### Where can I find sample workflows to experiment with? --->

<!--- ### How to handle failing workflows? --->

<!--- ### Why do some processors have multiple input or output file groups? --->

<!--- ### Where can I learn about the input and output file groups of a processor? --->

<!--- ### How can I validate my workflow is correctly wired? --->

<!--- ### Where can I learn about the parameters of a processor? --->

<!--- ## `ocrd_all` --->

<!--- ### What is `ocrd_all`? --->

<!--- ### How to update `ocrd_all`? --->

<!--- ### How to debug `ocrd_all` problems? --->

<!--- ### I used `sudo` and now everything is broken --->

<!--- ## Training --->

<!--- ### I want to train a custom OCR model. Where do I start? --->

<!--- ## OCR-D-Ground Truth --->

<!--- ### Which of the three transcription levels specified in the Transcription Guidelines was used for the GT of OCR-D? --->

<!--- ### Are the three transcription levels designed hierarchically? Meaning, does level 3 include level 2 and level 1? --->

<!--- ### I want to make some GT myself. Which level should I use? Can I mix levels? --->

<!--- ### I have some transcriptions of early modern books, but I didn't stick to the OCR-D GT guidelines. Would my transcriptions still be useful for OCR-D? --->
