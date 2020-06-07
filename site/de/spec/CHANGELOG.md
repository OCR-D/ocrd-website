---
layout: page
lang: de
lang-ref: CHANGELOG.md
toc: true
---

Change Log
==========

All notable changes to the specs will be documented in this file.

Versioned according to [Semantic Versioning](http://semver.org/).

## Unreleased

## [3.7.0] - 2020-06-07

Added:

  * ocrd-tool.json: Parameter values may be objects, #143
  * glossary: definitions of "print space" and "border", #114

## [3.6.0] - 2020-04-30

Added:

  * CLI: `--overwrite` flag to delete existing output files before processing, #151

## [3.5.0] - 2020-04-20

Changed:

  * CLI: clarify requirements on processors, ht @bertsky, #148
  * Use `region` instead of `block` for areas on the page, #135
  * PAGE: `imageFilename` must NOT be a URL but a relative filename, #140
  * Updated URLs to point to https://ocr-d.de instead of https://ocr-d.github.io, #149

Added:

  * docker: instructions on naming and labelling images, #139
  * CLI tools must implement `-h/--help`, #115

## [3.4.2] - 2020-01-08

Changed:

  * bagit-profile accepts `metadata` as non-payload dir, #133
  * Relaxed the requirement for the `mets:fileGrp/@USE` syntax, #138

## [3.4.1] - 2020-01-03

Added:

  * No multi-page TIFF, #132

## [3.4.0] - 2019-11-05

Fixed

  * Various typos, #128

Changed:

  * Dockerfile: no CMD, no ENTRYPOINT, #130
  * Processors should assume 300 dpi if image metadata cannot be trusted, #129

Added:

  * Spec for provenance, #126

## [3.3.0] - 2019-10-23

Added:

  * Draft spec for logging
  * Draft spec for provenance

Changed:

  * ocrd-tool: Additional additional category `layout/segmentation/text-image`
  * ocrd-tool: Remove syntactical restriction for content-type
  * ocrd-tool: `output_file_grp` no longer required
  * CLI: `--mets` and `--working-dir` are optional not required
  * CLI: `--output-file-grp` is optional, OCR-D/core#296

## [3.2.1] - 2019-06-25

Added:

  * glossary: "MP", #112
  * glossary: "font family", #100 #109
  * cli: allow JSON strings for -p, OCR-D/core#239 #110

Fixed:

  * bagit: path of OcrdMets must be relative to /data, fix #107, #113


## [3.2.0] - 2019-02-27

Added:

  Convention for columns

Fixed:

  PAGE: link to the page xml docs

## [3.1.0] - 2018-12-20

Added:

  * Consistency check level 'lax'

Fixed:

  * Example in ocrd_tool.md is from ocrd_kraken, not ocrd_tesserocr

## [3.0.0] - 2018-12-13

Added:

  * PAGE text result and consistency checks, #82, OCR-D/assets#16

Changed:
  * :fire: Drop recommendation on reusing source file ID for page grouping
  * :fire: Drop GROUPID and replace with mets:structMap[@TYPE="PHYSICAL"] throughout
  * :fire: CLI: Replace `-g/-group-id` with `-g/--page-id`
  * CLI: Mark possible comma-separated multi-value parameters as such
  * CLI: Update `ocrd process` example
  * OCRD-ZIP: Set BagIt-Profile-Version to 1.2

## [2.7.0] - 2018-12-04

Added:

  * Font information, #76, #96

## [2.6.3] - 2018-11-23

Changed:

  * OCRD-ZIP: `Ocrd-Mets` and `mets:FLocat` URI/paths must be relative to `/data`, #99
  * OCRD-ZIP: `Ocrd-Mets` only relevant for extraction
  * OCRD-ZIP: Filenames MUST be relative to mets.xml
  * METS: Filenames MAY/SHOULD be relative to mets.xml
  * OCRD-ZIP: Allow a limited set of files in the bag basedir (readme, build files), #97

## [2.6.2] - 2018-11-22

Changed:

  * OCRD-ZIP bagit profile: Add empty list requirement for `Tag-Manifest-Required`, `Tag-Files-Required`
  * OCRD-ZIP bagit profile: Contact info
  * OCRD-ZIP allow `fetch.txt`, #98

## [2.6.1] - 2018-11-09

Fixed:

  * OCRD-ZIP: typo in bagit-profile: `Bagit-` --> `BagIt-`
  * OCRD-ZIP: Require `BagIt-Profile-Identifier`
  * OCRD-ZIP: Version number must be a string, bagit-profile/bagit-profile#13

## [2.6.0] - 2018-11-06

Changed:

  * Base workspace and workspace serialization mechanics on bagit, #70

## [2.5.0] - 2018-10-30

Added:

  * Recording processing information in METS, #89
  * Input and output file groups can be provided in ocrd-tool.json, #91

Changed

  * :fire: METS: grouping pages by physical `structMap` not `GROUPID`, #81

## [2.4.0] - 2018-10-19

Added:

  * File parameters, #69
  * Step for post-correction, #64

## [2.3.1] - 2018-10-10

Fixed

  * CLI: Example used repeated options


## [2.3.0] - 2018-09-26

Changed:

  * CLI: filtering by log level required, OCR-D/core#173, #74
  * CLI: log messages must adhere to uniform pattern, #78

Added:

  * CLI: Convention to prefer comma-separated values over repeated flags, #68

## [2.2.2] - 2018-08-14

Fixed:

  * Missed `description` for parameters

## [2.2.1] - 2018-07-25

Changed

  * spell out parameter properties in ocrd-tool.json schem

## [2.2.0] - 2018-07-23

Added:

  * CLI: Conventions for handling URL on the command line

## [2.1.2] - 2018-07-19

Added:

  * Reference PAGE media type in PAGE conventions, #65

## [2.1.1] - 2018-06-18

Fixed:

  - ocrd-tool: regex for `version` had a YAML error

## [2.1.0] - 2018-06-18

Added:

  * ocrd-tool: Must define `version`
  * METS: `mets:file` must have ID
  * METS: `mets:fileGrp` must have consistent MIMETYPE
  * METS: `mets:file` GROUPID must be unique with a `mets:fileGrp`

## [2.0.0] - 2018-06-18

Removed:

  * --output-mets CLI option

## [1.3.0] - 2018-06-15

Added:

  * Glossary, #56

Removed:

  * drop OCR-D-GT-PAGE, #61

Fixed:

  * explain `GT-` prefix for `fileGrp@USE` of ground truth files, #58
  * various typos

## [1.2.0] - 2018-05-25

Fixed:

* Fix example for ocrd_tool
* Fix TIFF media type

Added:

* -J/--dump-json, #30

Changed

  * ocrd-tool: tags -> category, #44
  * ocrd-tool: step -> steps (now an array), #44
  * ocrd-tool: parameterSchema -> parameters, #48
  * ocrd-tool: 'tools' is an object now, not an array, #43

## [1.1.5] - 2018-05-15

Added:

  * ocrd-tool: Steps: `preprocessing/optimization/grayscale_normalization` and `layout/segmentation/word`
  * PAGE conventions

## [1.1.4] - 2018-05-02

Added:

* PAGE/XML media type, #33
* mets:file@GROUPID == pg:pcGtsId, #31

## [1.1.3] - 2018-04-28

Added:

* Add OCR-D-SEG-WORD and OCR-D-SEG-GLYPH as USE attributes

## [1.1.2] - 2018-04-23

Changed:

* rename repo OCR-D/pyocrd -> OCR-D/core
* rename repo OCR-D/ocrd-assets -> OCR-D/assets
* renamed docker base image ocrd/pyocrd -> ocrd/core

Fixed:

* In ocrd_tool example: renamed parameter structure-level -> level-of-operation

## [1.1.1] - 2018-04-19

Fixed:
  * typo: `exceutable` -> `executable`
  * disallow custom properties

## [1.1.0] - 2018-04-19

Added
* Spec for OCRD-ZIP

Changed
* Use `executable` instead of `binary` to reduce confusion

Fixed
* typos (@stweil)

Removed

## [1.0.0] - 2018-04-16

Initial Release

<!-- link-labels -->
[3.7.0]: ../../compare/v3.7.0...v3.6.0
[3.6.0]: ../../compare/v3.6.0...v3.5.0
[3.5.0]: ../../compare/v3.5.0...v3.4.2
[3.4.2]: ../../compare/v3.4.2...v3.4.1
[3.4.1]: ../../compare/v3.4.1...v3.4.0
[3.4.0]: ../../compare/v3.4.0...v3.3.0
[3.3.0]: ../../compare/v3.3.0...v3.2.1
[3.2.1]: ../../compare/v3.2.1...v3.2.0
[3.2.0]: ../../compare/v3.2.0...v3.1.0
[3.1.0]: ../../compare/v3.1.0...v3.0.0
[3.0.0]: ../../compare/v3.0.0...v2.7.0
[2.7.0]: ../../compare/v2.7.0...v2.6.3
[2.6.3]: ../../compare/v2.6.3...v2.6.2
[2.6.2]: ../../compare/v2.6.2...v2.6.1
[2.6.1]: ../../compare/v2.6.1...v2.6.0
[2.6.0]: ../../compare/v2.6.0...v2.5.0
[2.5.0]: ../../compare/v2.5.0...v2.4.0
[2.4.0]: ../../compare/v2.4.0...v2.3.1
[2.3.1]: ../../compare/v2.3.1...v2.3.0
[2.3.0]: ../../compare/v2.3.0...v2.2.2
[2.2.2]: ../../compare/v2.2.2...v2.2.1
[2.2.1]: ../../compare/v2.2.1...v2.2.0
[2.2.0]: ../../compare/v2.2.0...v2.1.2
[2.1.2]: ../../compare/v2.1.2...v2.1.1
[2.1.1]: ../../compare/v2.1.1...v2.1.0
[2.1.0]: ../../compare/v2.1.0...v2.0.0
[2.0.0]: ../../compare/v2.0.0...v1.3.0
[1.3.0]: ../../compare/v1.3.0...v1.2.0
[1.2.0]: ../../compare/v1.2.0...v1.1.5
[1.1.5]: ../../compare/v1.1.5...v1.1.4
[1.1.4]: ../../compare/v1.1.4...v1.1.3
[1.1.3]: ../../compare/v1.1.3...v1.1.2
[1.1.2]: ../../compare/v1.1.2...v1.1.1
[1.1.1]: ../../compare/v1.1.1...v1.1.0
[1.1.0]: ../../compare/v1.1.0...v1.0.0
[1.0.0]: ../../compare/v1.0.0...HEAD
