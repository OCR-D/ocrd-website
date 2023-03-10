---
layout: page
lang: en
lang-ref: decisions.md
toc: true
title: Decisions in OCR-D
---

# Decisions in OCR-D

In a software project, especially a highly distributed one like OCR-D,
decisions need to be made on the technology used, how interfaces should
interoperate and how the software as a whole is designed.

In this document, such decisions on key aspects of OCR-D are discussed for the
benefit of all OCR-D stakeholders.

## Terminology

* *current* refers to **December 13, 2022**, the last change of this document
* *Q1-Q4* refers to yearly quarters
* *target version* is the version we mainly test and develop for
* *supported version* means that we test this version and ensure compatibility

## General decisions

* [Q1 2023] We will update to Ubuntu 22.04 and Python 3.7 as soon as possible. [OCR-D/core#956](https://github.com/OCR-D/core/pull/956)
* [Q1 2023] Switch to Slim Containers in `ocrd_all`
* [Q1 2023] Python API changes (Pagewise processing) [OCR-D/core#322](https://github.com/OCR-D/core/issues/322)

## Workflow format

* [Q3 2022] We use Nextflow. The whole `.nf` file (Nextflow file) as the workflow
  format workflow server and processing 
  server including [web API implementation](https://github.com/OCR-D/ocrd-webapi-implementation) is part of the
  [implementation projects](phase3). Further details can be found [in the nextflow spec](nextflow).

## Web API

* [Q3 2022] Switch to the new architecture with message queue.
  * Processing Broker and Processing Server will be provided via OCR-D Core.
* [2022] OCR-D Coordination Project provides the [Web API spec](web_api). Only
  the [REST API wrapper](https://github.com/OCR-D/core/pull/884) of a single processor is provided by OCR-D Core.

## QUIVER

* [2022] We will create a web application, [QUIVER](https://github.com/OCR-D/quiver-back-end) (for QUalIty oVERview), in
  which some information about OCR-D processors are provided:
  * a general overview of the projects (i.e. GitHub repositories), e.g. if their `ocrd-tool.json` is valid, when their last release has been made etc.
  * a workflow section where we [benchmark](#benchmarking) different workflows for different corpora.
  * a general overview of the available processors

### Benchmarking

* [2022] To execute the benchmarking, we will create several corpora with different characteristics (font, creation date, layout, …) and 
run different workflows with these as input. The result is then displayed in the QUIVER workflow tab.
The corpora will be publicly available for better transparency.
* [2022] [Relevant metrics](https://github.com/OCR-D/spec/pull/225) for the mininum viable product (MVP) will be:
  * CER
  * WER
  * Bag of Words
  * Reading order
  * IoU
  * CPU time
  * wall time
  * I/O
  * Memory Usage
  * Disc usage
* [2022] The benchmarking will be executed automatically in a regular interval to measure if changes in the processors improve the result.
This might be done via CI, GitHub Actions or as a CRON job on a separate server.

## OCR-D/core

### METS server

The current approach to file management requires processors accessing a single
METS file on disk, which turns file management into a bottleneck for workflows.

To alleviate this, we [will develop an HTTP server](https://github.com/OCR-D/core/pull/966) that provides asynchronous and
parallel access to the METS in **Q4 2022**.

### Decentralized resource list

We currently maintain a list of processor resources centrally in OCR-D/core.

In **Q3 2022**, to allow processor developers to maintain their own separate
list of resources, we have implemented mechanisms to store resource lists in a
processor's `ocrd-tool.json` and bundle resources in their own module directory.

By **Q1 2023** we should have updated all the processors and whittled down the
central list to a mostly empty list.

### Page-wise processing

Currently, processors iterate through the files of a workspace by looping through
all the files in the input file group(s) themselves.

In **Q1 2023** we will refactor the processor API, deprecate the current
approach of processors iterating in a `process` method and enable processors
to process individual pages in a `process_page` method.

<!--
   -## Processors
   -
   -In this section we outline our plans with the various processor projects.
   -
   -**NOTE** Currently only anybaseocr as an example
   -
   -### [ocrd_anybaseocr](https://github.com/OCR-D/ocrd_anybaseocr)
   -
   -`ocrd_anybaseocr` is a fairly complex project with multiple processors working
   -on different problems with different technologies. Some processors are
   -powerful, some are too experimental to be recommended. The original developers
   -have moved on from the projects, so it is essential for maintainability by the
   -community that we refactor it.
   -->

## ocrd_all Docker deployment


* Our current target container is a **fat container**, with **maximum**,
  **medium** and **minimum** versions with decreasing amount of processors
  contained.
* We will wrap processor projects individually and transition to **slim containers** in **Q1 2023**.

## Supported Python versions


* Our current target version for Python is **3.7**, we support **3.6** and **3.7** fully, later versions partially.
* :warning: We cannot currently upgrade beyond **3.7** because there are no [tensorflow v1.15.x](#tensorflow) prebuilt images available. We need to investigate how to alleviate this until **Q4 2022**.
* We will change the target version for Python to **3.10** in **Q1 2023** when we have solved the tensorflow problem.
* Support for **3.6** will end **Q4 2022**. We will not test and include Python 3.6 after that.
* We will start to support **3.11** in **Q1 2023**.
* We will start to support **3.12** in **Q2 2023** (:warning: won't have distutils anymore)
* Support for **3.7** will end **Q2 2023**.
* Support for **3.8** will end **Q3 2023**.
* Support for **3.9** will end **Q4 2023**.

## Base OS image

* Our current base image for deployment is **Ubuntu 18.04**, we support **Ubuntu 18.04**, **20.04** and **22.04**.
* We will change the base image to **Ubuntu 20.04** in **Q4 2022**.
* We will change the base image to **Ubuntu 22.04** in **Q1 2023**.
* Support for **Ubuntu 18.04** will end in **Q1 2023**.
* Support for **Ubuntu 20.04** will end in **Q2 2024**.

## Software libraries

### [calamari](https://github.com/OCR-D/ocrd_calamari)

* Our currently supported calamari version is **1.x**.
* We will switch to **2.x** in **Q1 2023**.

* Support for **1.x** will end in **Q1 2022**

### [pillow](https://pillow.readthedocs.io/)

* We currently support Pillow **5.x** to **v9.x**

### [tensorflow](https://github.com/tensorflow/tensorflow)

* Our target version is **2.5.0**
* We currently support **1.15.x**, **2.4.0** and **2.5.0**.
  While we strongly encourage moving away from **1.15.x**, due to the
  logistics of updating trained models, we don't have a fixed
  cut-off date.

### [torch](https://pytorch.org/)

* Our current target version is **1.10.x**.

### bash

* We use bash scripting for development tasks and for the bashlib library in OCR-D.
* Our current target version is **4.4**.
