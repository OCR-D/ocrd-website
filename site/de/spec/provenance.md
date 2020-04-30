---
layout: page
lang: de
lang-ref: provenance.md
toc: true
---

# Provenance
Provenance is information about entities, activities, and people involved in producing a piece of data or thing, which can be used to form assessments about its quality, reliability or trustworthiness. (Source: [The PROV Data Model (PROV-DM)](https://www.w3.org/TR/prov-dm/))

## Data Model
[The PROV Data Model (PROV-DM)](https://www.w3.org/TR/prov-dm/) is used to store all provenance metadata.
All provenance have to be stored in files. 
There's provenance at the page level, but there's also provenance at the document level.
All files regarding provenance are stored in a subfolder **`metadata`**.

## Format
The workflow provenance is stored in [PROV-XML](https://www.w3.org/TR/prov-xml/). 

### Types
All Activities, Entities belonging to the OCR-D workflow have the same namespace.
#### Namespace
<dl>
  <dt><strong>Prefix</strong></dt>
  <dd>ocrd</dd>
  <dt><strong>Namespace</strong></dt>
  <dd>http://www.ocr-d.de</dd>
</dl>

Type | Data Type | Description
-------- | -------- | --------
Entity   | ocrd:mets | Filename  of METS file
Entity   | ocrd:mets_referencedFile | ID of the file referenced inside METS. 
Entity   | ocrd:parameter_file   | Content of the parameter file.
Activity   | ocrd:processor | Processor that was executed 
Activity   | ocrd:workflow | Workflow that was executed


## Content 
Only the following information is stored for provenance:

(a) **General data**

1. Workflow engine 
  - Label including version
  - Start date
  - End date

(b) **Processor data**

2. Processor
  - Label including version, conforming to [OCR-D `mets:agent/mets:name`](https://ocr-d.de/en/spec/mets#recording-processing-information-in-mets) (e.g.: `ocrd-kraken-binarize_Version 0.1.0`, `ocrd/core 1.0.0`)
  - Start date
  - End date
3. Content of METS file before executing the processor
4. Content of METS file after executing processor
5. ID of the input file(s)
6. ID of output file(s)
7. Content of parameter.json (optional)

### Input/Output
All files referenced in METS must also be referenced in provenance by their `mets:file/@ID`.
A file _may_ be linked to its location (URL). The location may be replaced due to 
different uses:
1. local files
2. external files

All files not referenced in METS must be linked to their content in provenance. (e.g.: parameter.json)

### Ingest Workspace to OCR-D Repositorium
At least before ingesting into repository/LTA, the entire provenance must be stored in one file (metadata/ocrd_provenance.xml) to make the provenance searchable.
Therfore all the provenance files are merged into one big file.
This file replaces all provenance files stored in subfolder 'metadata'

## Example
The file structure could look like this after a workflow with 4 steps has been executed.
```
metadata/
   |
   +-- mets.xml.'workflowid'_0000
   |
   +-- mets.xml.'workflowid'_0001
   |
   +-- mets.xml.'workflowid'_0002
   |
   +-- mets.xml.'workflowid'_0003
   |
   +-- mets.xml.'workflowid'_0004
   |
   +-- ocrd_provenance.xml
   |
   +-- provenance_'workflowid'.xml (optional)
```

## Provenance and BagIt
The provenance MAY be stored as tag directory in the bagIt container.
E.g.:
```
<base directory>/
         |
         +-- bagit.txt
         |
         +-- manifest-<algorithm>.txt
         |
         +-- [additional tag files]
         |
         +-- data/
         |     |
         |     +-- mets.xml
         |     |
         |     +-- ...
         |
         +-- metadata
                |
                +-- mets.xml.'workflowid'_0000
                |
                +-- ...
                |
                +-- mets.xml.'workflowid'_XXXX
                |
                +-- ocrd_provenance.xml

```

