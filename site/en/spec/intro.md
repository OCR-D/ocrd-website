---
layout: page
lang: en
lang-ref: spec-intro
title: OCR-D Specs Overview
---

# OCR-D Specs Overview

Since OCR-D focuses on improving access to mass digitization for historical
prints, it is important that its tools are sufficiently uniform in their interfaces
and data access patterns to support the widest possible application within
GLAM digitization workflows.

This website lays out a set of conventions and interface definitions that must
be implemented by the OCR-D module projects (MP) to be usable within the OCR-D ecosphere.

## CLI

Software developed by MP must be executable with a
command line interface (CLI) on a Linux OS. CLI are straightforward to run and
test and can be easily embedded in automated setups. The mechanics of OCR-D
conformant CLI tools are laid out in the [CLI specs](cli).

## METS

To allow processing OCR-related data in a digitization workflow, a uniform data
exchange format is necessary. OCR-D decided to use the widely used METS format
and has developed [conventions](./mets) on how MP must access and manipulate
METS data in order to be interoperable.

## ocrd-tool.json

Interoperability needs metadata, both descriptive and technical. OCR-D has
[developed a format](./ocrd_tool) that allows MP to express general information
about themselves and detailed information about the tools they develop.

## REST

OCR-D will offer RESTful access to the MP CLI based on HTTP, using
the Open API / Swagger set of tools.

## Dockerfile

Docker is a widely used system for containerization of software. MPs are
encouraged to package the tools they develop as a docker image by providing a
`Dockerfile`. OCR-D offers [recommendations on how the Dockerfile should be
structured](./docker).
