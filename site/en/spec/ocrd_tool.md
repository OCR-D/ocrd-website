---
layout: page
lang: en
lang-ref: ocrd_tool.md
toc: true
title: ocrd-tool.json
---

# ocrd-tool.json

Tools MUST be described in a file `ocrd-tool.json` in the root of the repository.

It must contain a JSON object adhering to the [ocrd-tool JSON Schema](#Definition).

In particular, every tool provided must be described in an array item under the
`tools` key. These definitions drive the [CLI](cli) and the [web
services](swagger).

To validate a `ocrd-tool.json` file, use `ocrd ocrd-tool /path/to/ocrd-tool.json validate`.

## File parameters

To mark a parameter as expecting the address of a file, it MUST declare the
`content-type` property as a [valid media
type](https://www.iana.org/assignments/media-types/media-types.xhtml).
Optionally, workflow processors can be notified that this file is potentially
large and static (e.g. a fixed dataset or a precomputed model) and should be cached
indefinitely after download by setting the `cacheable` property to `true`.

The filename itself, i.e. the concrete value `<fpath>` of a file parameter,
should be resolved in the following way (with `<cwd>` representing the current 
working directory, and `<mod>` representing the distribution directory of the module):

* If `<fpath>` is an `http`/`https` URL: Download to a temporary directory (if
  `cacheable==False`) or a semi-temporary cache directory (if `cacheable==True`)
* If `<fpath>` is an absolute path: Use as-is.
* If `<fpath>` is a relative path (with or without directory components):
  Try resolving via the following directories, and return the first one found if any,
  otherwise abort with an error message stating so:
  * `<cwd>/<fpath>` (**Note** that the file is expected to be directly under `<cwd>`, not in a subdirectory)
  * If an environment variable is defined that has the name of the processor in
    upper-case and with `-` replaced with `-` and followed by `_PATH` (e.g. for a processor
    `ocrd-dummy`, the variable would need to be called `OCRD_DUMMY_PATH`):
    * Split the variable value at `:` and try to resolve by appending `<fpath>`
      to each token and return the first found file if any
  * `$XDG_DATA_HOME/ocrd-resources/<name-of-processor>/<fpath>` (with `$HOME/.local/share` instead of `$XDG_DATA_HOME` if unset)
  * `/usr/local/share/ocrd-resources/<name-of-processor>/<fpath>`
  * `<mod>/<fpath>` (**Note** that the file is expected to be directly under `<mod>`, not in a subdirectory)

The path of the `<mod>` directory is implementation specific and allows modules
to distribute small resources along with the code, i.e. pre-installed files like
[presets](cli#processor-resources).

## Input / Output file groups

Tools should define the names of both expected input and produced output file
groups as a list of `USE` attributes of `mets:fileGrp` elements. If more than
one file group is expected or produced, this should be explained in the
description of the tool.

**NOTE:** Both input and output file groups can be [overridden at
runtime](cli#-i---input-file-grp-grp). Tools must therefore ensure not to
hardcode file group names. When multiple groups are expected, the order of the
override reflects the order in which they are defined in the `ocrd-tool.json`.

## Definition

<!-- Regenerate with 'shinclude -i ocrd_tool.md'. See https://github.com/kba/shinclude -->
<!-- BEGIN-EVAL -w '```yaml' '```' -- cat ./ocrd_tool.schema.yml -->
```yaml
type: object
description: Schema for tools by OCR-D MP
required:
  - version
  - git_url
  - tools
additionalProperties: false
properties:
  version:
    description: "Version of the tool, expressed as MAJOR.MINOR.PATCH."
    type: string
    pattern: '^[0-9]+\.[0-9]+\.[0-9]+$'
  git_url:
    description: Github/Gitlab URL
    type: string
    format: url
  dockerhub:
    description: DockerHub image
    type: string
  tools:
    type: object
    additionalProperties: false
    patternProperties:
      'ocrd-.*':
        type: object
        additionalProperties: false
        required:
          - description
          - steps
          - executable
          - categories
          - input_file_grp
          # Not required because not all processors produce output files
          # - output_file_grp
        properties:
          executable:
            description: The name of the CLI executable in $PATH
            type: string
          input_file_grp:
            description: Input fileGrp@USE this tool expects by default
            type: array
            items:
              type: string
              pattern: '^OCR-D-[A-Z0-9-]+$'
          output_file_grp:
            description: Output fileGrp@USE this tool produces by default
            type: array
            items:
              type: string
              pattern: '^OCR-D-[A-Z0-9-]+$'
          parameters:
            description: Object describing the parameters of a tool. Keys are parameter names, values sub-schemas.
            type: object
            patternProperties:
              ".*":
                type: object
                additionalProperties: false
                required:
                  - description
                  - type
                  # also either 'default' or 'required'
                properties:
                  type:
                    type: string
                    description: Data type of this parameter
                    enum:
                      - string
                      - number
                      - boolean
                      - object
                      - array
                  format:
                    description: Subtype, such as `float` for type `number` or `uri` for type `string`.
                  description:
                    description: Concise description of syntax and semantics of this parameter
                  required:
                    type: boolean
                    description: Whether this parameter is required
                  default:
                    description: Default value when not provided by the user
                  enum:
                    type: array
                    description: List the allowed values if a fixed list.
                  content-type:
                    type: string
                    default: 'application/octet-stream'
                    description: >
                      The media type of resources this processor expects for
                      this parameter. Most processors use files for resources
                      (e.g.  `*.traineddata` for `ocrd-tesserocr-recognize`)
                      while others use directories of files (e.g. `default` for
                      `ocrd-eynollah-segment`).  If a parameter requires
                      directories, it must set `content-type` to
                      `text/directory`.
                  cacheable:
                    type: boolean
                    description: "If parameter is reference to file: Whether the file should be cached, e.g. because it is large and won't change."
                    default: false
          description:
            description: Concise description what the tool does
          categories:
            description: Tools belong to this categories, representing modules within the OCR-D project structure
            type: array
            items:
              type: string
              enum:
                - Image preprocessing
                - Layout analysis
                - Text recognition and optimization
                - Model training
                - Long-term preservation
                - Quality assurance
          steps:
            description: This tool can be used at these steps in the OCR-D functional model
            type: array
            items:
              type: string
              enum:
                - preprocessing/characterization
                - preprocessing/optimization
                - preprocessing/optimization/cropping
                - preprocessing/optimization/deskewing
                - preprocessing/optimization/despeckling
                - preprocessing/optimization/dewarping
                - preprocessing/optimization/binarization
                - preprocessing/optimization/grayscale_normalization
                - recognition/text-recognition
                - recognition/font-identification
                - recognition/post-correction
                - layout/segmentation
                - layout/segmentation/text-nontext
                - layout/segmentation/region
                - layout/segmentation/line
                - layout/segmentation/word
                - layout/segmentation/classification
                - layout/analysis
          resource_locations:
            type: array
            description: The locations in the filesystem this processor supports for resource lookup
            default: ['data', 'cwd', 'system', 'module']
            items:
              type: string
              enum: ['data', 'cwd', 'system', 'module']
          resources:
            type: array
            description: Resources for this processor
            items:
              type: object
              additionalProperties: false
              required:
                - url
                - description
                - name
                - size
              properties:
                url:
                  type: string
                  description: URLs of all components of this resource
                description:
                  type: string
                  description: A description of the resource
                name:
                  type: string
                  description: Name to store the resource as
                type:
                  type: string
                  enum: ['file', 'directory', 'archive']
                  default: file
                  description: Type of the URL
                parameter_usage:
                  type: string
                  description: Defines how the parameter is to be used
                  enum: ['as-is', 'without-extension']
                  default: 'as-is'
                path_in_archive:
                  type: string
                  description: if type is archive, the resource is at this location in the archive
                  default: '.'
                version_range:
                  type: string
                  description: Range of supported versions, syntax like in PEP 440
                  default: '>= 0.0.1'
                size:
                  type: number
                  description: Size of the resource in bytes
```

<!-- END-EVAL -->

## Example

This is from the [ocrd_tesserocr project](https://github.com/OCR-D/ocrd_tesserocr):

```json
{
  "version": "0.10.0",
  "git_url": "https://github.com/OCR-D/ocrd_tesserocr",
  "dockerhub": "ocrd/tesserocr",
  "tools": {
    "ocrd-tesserocr-deskew": {
      "executable": "ocrd-tesserocr-deskew",
      "categories": ["Image preprocessing"],
      "description": "Detect script, orientation and skew angle for pages or regions",
      "input_file_grp": [
        "OCR-D-IMG",
        "OCR-D-SEG-BLOCK"
      ],
      "output_file_grp": [
        "OCR-D-DESKEW-BLOCK"
      ],
      "steps": ["preprocessing/optimization/deskewing"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "operation_level": {
          "type": "string",
          "enum": ["page","region"],
          "default": "region",
          "description": "PAGE XML hierarchy level to operate on"
        },
        "min_orientation_confidence": {
          "type": "number",
          "format": "float",
          "default": 1.5,
          "description": "Minimum confidence score to apply orientation as detected by OSD"
        }
      }
    },
    "ocrd-tesserocr-fontshape": {
      "executable": "ocrd-tesserocr-fontshape",
      "categories": ["Text recognition and optimization"],
      "description": "Recognize font shapes (family/monospace/bold/italic) and size in segmented words with Tesseract (using annotated derived images, or masking and cropping images from coordinate polygons), annotating TextStyle",
      "input_file_grp": [
        "OCR-D-SEG-WORD",
        "OCR-D-OCR"
      ],
      "output_file_grp": [
        "OCR-D-OCR-STYLE"
      ],
      "steps": ["recognition/font-identification"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "padding": {
          "type": "number",
          "format": "integer",
          "default": 0,
          "description": "Number of background-filled pixels to add around the word image (i.e. the annotated AlternativeImage if it exists or the higher-level image cropped to the bounding box and masked by the polygon otherwise) on each side before recognition."
        },
        "model": {
          "type": "string",
          "default": "osd",
          "description": "tessdata model to apply (an ISO 639-3 language specification or some other basename, e.g. deu-frak or osd); must be an old (pre-LSTM) model"
        }
      }
    },
    "ocrd-tesserocr-recognize": {
      "executable": "ocrd-tesserocr-recognize",
      "categories": ["Text recognition and optimization"],
      "description": "Segment and/or recognize text with Tesseract (using annotated derived images, or masking and cropping images from coordinate polygons) on any level of the PAGE hierarchy.",
      "input_file_grp": [
        "OCR-D-SEG-PAGE",
        "OCR-D-SEG-REGION",
        "OCR-D-SEG-TABLE",
        "OCR-D-SEG-LINE",
        "OCR-D-SEG-WORD"
      ],
      "output_file_grp": [
        "OCR-D-SEG-REGION",
        "OCR-D-SEG-TABLE",
        "OCR-D-SEG-LINE",
        "OCR-D-SEG-WORD",
        "OCR-D-SEG-GLYPH",
        "OCR-D-OCR-TESS"
      ],
      "steps": [
        "layout/segmentation/region",
        "layout/segmentation/line",
        "recognition/text-recognition"
      ],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "padding": {
          "type": "number",
          "format": "integer",
          "default": 0,
          "description": "Extend detected region/cell/line/word rectangles by this many (true) pixels, or extend existing region/line/word images (i.e. the annotated AlternativeImage if it exists or the higher-level image cropped to the bounding box and masked by the polygon otherwise) by this many (background/white) pixels on each side before recognition."
        },
        "segmentation_level": {
          "type": "string",
          "enum": ["region", "cell", "line", "word", "glyph", "none"],
          "default": "word",
          "description": "Highest PAGE XML hierarchy level to remove existing annotation from and detect segments for (before iterating downwards); if ``none``, does not attempt any new segmentation; if ``cell``, starts at table regions, detecting text regions (cells). Ineffective when lower than ``textequiv_level``."
        },
        "textequiv_level": {
          "type": "string",
          "enum": ["region", "cell", "line", "word", "glyph", "none"],
          "default": "word",
          "description": "Lowest PAGE XML hierarchy level to re-use or detect segments for and add the TextEquiv results to (before projecting upwards); if ``none``, adds segmentation down to the glyph level, but does not attempt recognition at all; if ``cell``, stops short before text lines, adding text of text regions inside tables (cells) or on page level only."
        },
        "overwrite_segments": {
          "type": "boolean",
          "default": false,
          "description": "If ``segmentation_level`` is not none, but an element already contains segments, remove them and segment again. Otherwise use the existing segments of that element."
        },
        "overwrite_text": {
          "type": "boolean",
          "default": true,
          "description": "If ``textequiv_level`` is not none, but a segment already contains TextEquivs, remove them and replace with recognised text. Otherwise add new text as alternative. (Only the first entry is projected upwards.)"
        },
        "block_polygons": {
          "type": "boolean",
          "default": false,
          "description": "When detecting regions, annotate polygon coordinates instead of bounding box rectangles."
        },
        "find_tables": {
          "type": "boolean",
          "default": true,
          "description": "When detecting regions, recognise tables as table regions (Tesseract's ``textord_tabfind_find_tables=1``)."
        },
        "sparse_text": {
          "type": "boolean",
          "default": false,
          "description": "When detecting regions, use 'sparse text' page segmentation mode (finding as much text as possible in no particular order): only text regions, single lines without vertical or horizontal space."
        },
        "raw_lines": {
          "type": "boolean",
          "default": false,
          "description": "When detecting lines, do not attempt additional segmentation (baseline+xheight+ascenders/descenders prediction) on line images. Can increase accuracy for certain workflows. Disable when line segments/images may contain components of more than 1 line, or larger gaps/white-spaces."
        },
        "char_whitelist": {
          "type": "string",
          "default": "",
          "description": "When recognizing text, enumeration of character hypotheses (from the model) to allow exclusively; overruled by blacklist if set."
        },
        "char_blacklist": {
          "type": "string",
          "default": "",
          "description": "When recognizing text, enumeration of character hypotheses (from the model) to suppress; overruled by unblacklist if set."
        },
        "char_unblacklist": {
          "type": "string",
          "default": "",
          "description": "When recognizing text, enumeration of character hypotheses (from the model) to allow inclusively."
        },
        "model": {
          "type": "string",
          "description": "The tessdata text recognition model to apply (an ISO 639-3 language specification or some other basename, e.g. deu-frak or Fraktur)."
        }
      }
    },
     "ocrd-tesserocr-segment": {
      "executable": "ocrd-tesserocr-segment",
      "categories": ["Layout analysis"],
      "description": "Segment page into regions and lines with Tesseract",
      "input_file_grp": [
        "OCR-D-IMG",
        "OCR-D-SEG-PAGE",
        "OCR-D-GT-SEG-PAGE"
      ],
      "output_file_grp": [
        "OCR-D-SEG-LINE"
      ],
      "steps": ["layout/segmentation/region", "layout/segmentation/line"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "padding": {
          "type": "number",
          "format": "integer",
          "description": "extend detected region rectangles by this many (true) pixels",
          "default": 4
        },
        "block_polygons": {
          "type": "boolean",
          "default": false,
          "description": "annotate polygon coordinates instead of bounding box rectangles"
        },
        "find_tables": {
          "type": "boolean",
          "default": true,
          "description": "recognise tables as table regions (textord_tabfind_find_tables)"
        },
        "sparse_text": {
          "type": "boolean",
          "default": false,
          "description": "use 'sparse text' page segmentation mode (find as much text as possible in no particular order): only text regions, single lines without vertical or horizontal space"
        }
      }
   },
   "ocrd-tesserocr-segment-region": {
      "executable": "ocrd-tesserocr-segment-region",
      "categories": ["Layout analysis"],
      "description": "Segment page into regions with Tesseract",
      "input_file_grp": [
        "OCR-D-IMG",
        "OCR-D-SEG-PAGE",
        "OCR-D-GT-SEG-PAGE"
      ],
      "output_file_grp": [
        "OCR-D-SEG-BLOCK"
      ],
      "steps": ["layout/segmentation/region"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "overwrite_regions": {
          "type": "boolean",
          "default": true,
          "description": "Remove existing layout and text annotation below the Page level (otherwise skip page; no incremental annotation yet)."
        },
        "padding": {
          "type": "number",
          "format": "integer",
          "description": "extend detected region rectangles by this many (true) pixels",
          "default": 0
        },
        "crop_polygons": {
          "type": "boolean",
          "default": false,
          "description": "annotate polygon coordinates instead of bounding box rectangles"
        },
        "find_tables": {
          "type": "boolean",
          "default": true,
          "description": "recognise tables as table regions (textord_tabfind_find_tables)"
        },
        "sparse_text": {
          "type": "boolean",
          "default": false,
          "description": "use 'sparse text' page segmentation mode (find as much text as possible in no particular order): only text regions, single lines without vertical or horizontal space"
        }
      }
    },
     "ocrd-tesserocr-segment-table": {
      "executable": "ocrd-tesserocr-segment-table",
      "categories": ["Layout analysis"],
      "description": "Segment table regions into cell text regions with Tesseract",
      "input_file_grp": [
        "OCR-D-SEG-BLOCK",
        "OCR-D-GT-SEG-BLOCK"
      ],
      "output_file_grp": [
        "OCR-D-SEG-BLOCK"
      ],
      "steps": ["layout/segmentation/region"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "overwrite_cells": {
          "type": "boolean",
          "default": true,
          "description": "Remove existing layout and text annotation below the TableRegion level (otherwise skip table; no incremental annotation yet)."
        }
      }
     },
     "ocrd-tesserocr-segment-line": {
      "executable": "ocrd-tesserocr-segment-line",
      "categories": ["Layout analysis"],
      "description": "Segment regions into lines with Tesseract",
      "input_file_grp": [
        "OCR-D-SEG-BLOCK",
        "OCR-D-GT-SEG-BLOCK"
      ],
      "output_file_grp": [
        "OCR-D-SEG-LINE"
      ],
      "steps": ["layout/segmentation/line"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "overwrite_lines": {
          "type": "boolean",
          "default": true,
          "description": "Remove existing layout and text annotation below the TextRegion level (otherwise skip region; no incremental annotation yet)."
        }
      }
    },
    "ocrd-tesserocr-segment-word": {
      "executable": "ocrd-tesserocr-segment-word",
      "categories": ["Layout analysis"],
      "description": "Segment lines into words with Tesseract",
      "input_file_grp": [
        "OCR-D-SEG-LINE",
        "OCR-D-GT-SEG-LINE"
      ],
      "output_file_grp": [
        "OCR-D-SEG-WORD"
      ],
      "steps": ["layout/segmentation/word"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "overwrite_words": {
          "type": "boolean",
          "default": true,
          "description": "Remove existing layout and text annotation below the TextLine level (otherwise skip line; no incremental annotation yet)."
        }
      }
    },
    "ocrd-tesserocr-crop": {
      "executable": "ocrd-tesserocr-crop",
      "categories": ["Image preprocessing"],
      "description": "Poor man's cropping via region segmentation",
      "input_file_grp": [
	"OCR-D-IMG"
      ],
      "output_file_grp": [
	"OCR-D-SEG-PAGE"
      ],
      "steps": ["preprocessing/optimization/cropping"],
      "parameters" : {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": 0
        },
        "padding": {
          "type": "number",
          "format": "integer",
          "description": "extend detected border by this many (true) pixels on every side",
          "default": 4
        }
      }
    },
    "ocrd-tesserocr-binarize": {
      "executable": "ocrd-tesserocr-binarize",
      "categories": ["Image preprocessing"],
      "description": "Binarize regions or lines with Tesseract's global Otsu",
      "input_file_grp": [
        "OCR-D-IMG",
        "OCR-D-SEG-BLOCK",
        "OCR-D-SEG-LINE"
      ],
      "output_file_grp": [
        "OCR-D-BIN-BLOCK",
        "OCR-D-BIN-LINE"
      ],
      "steps": ["preprocessing/optimization/binarization"],
      "parameters": {
        "operation_level": {
          "type": "string",
          "enum": ["region", "line"],
          "default": "region",
          "description": "PAGE XML hierarchy level to operate on"
        }
      }
    }
  }
}
```
