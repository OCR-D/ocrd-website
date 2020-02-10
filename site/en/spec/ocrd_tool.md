---
layout: page
lang: en
lang-ref: ocrd_tool.md
toc: true
---

# ocrd-tool.json

Tools MUST be described in a file `ocrd-tool.json` in the root of the repository.

It must contain a JSON object adhering to the [ocrd-tool JSON Schema](#Definition).

In particular, every tool provided must be described in an array item under the
`tools` key. These definitions drive the [CLI](cli) and the [web
services](swagger).

To validate a `ocrd-tool.json` file, use `ocrd ocrd-tool /path/to/ocrd-tool.json validate`.

## File parameters

To mark a parameter as expecting the address of a file, it must declare the
`content-type` property as a [valid media
type](https://www.iana.org/assignments/media-types/media-types.xhtml).
Optionally, workflow processors can be notified that this file is potentially
large and static (e.g. a fixed dataset or a precomputed model) and should be cached
indefinitely after download by setting the `cacheable` property to `true`.

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
                    description: "If parameter is reference to file: Media type of the file"
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
```

<!-- END-EVAL -->

## Example

This is from the [ocrd_tesserocr project](https://github.com/OCR-D/ocrd_tesserocr):

```json
{
  "version": "0.8.0",
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
          "default": -1
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
    "ocrd-tesserocr-recognize": {
      "executable": "ocrd-tesserocr-recognize",
      "categories": ["Text recognition and optimization"],
      "description": "Recognize text in lines with Tesseract (using annotated derived images, or masking and cropping images from coordinate polygons)",
      "input_file_grp": [
        "OCR-D-SEG-BLOCK",
        "OCR-D-SEG-LINE",
        "OCR-D-SEG-WORD",
        "OCR-D-SEG-GLYPH"
      ],
      "output_file_grp": [
        "OCR-D-OCR-TESS"
      ],
      "steps": ["recognition/text-recognition"],
      "parameters": {
        "dpi": {
          "type": "number",
          "format": "float",
          "description": "pixel density in dots per inch (overrides any meta-data in the images); disabled when negative",
          "default": -1
        },
        "textequiv_level": {
          "type": "string",
          "enum": ["region", "line", "word", "glyph"],
          "default": "word",
          "description": "Lowest PAGE XML hierarchy level to add the TextEquiv results to; when below `region`, implicitly adds segmentation below the line level, but requires existing line segmentation"
        },
        "overwrite_words": {
          "type": "boolean",
          "default": false,
          "description": "Remove existing layout and text annotation below the TextLine level (regardless of textequiv_level)."
        },
        "raw_lines": {
          "type": "boolean",
          "default": false,
          "description": "Do not attempt additional segmentation (baseline+xheight+ascenders/descenders prediction) when using line images (i.e. when textequiv_level<region). Can increase accuracy for certain workflows. Disable when line segments/images may contain components of more than 1 line, or larger gaps/white-spaces."
        },
        "char_whitelist": {
          "type": "string",
          "default": "",
          "description": "Enumeration of character hypotheses (from the model) to allow exclusively; overruled by blacklist if set."
        },
        "char_blacklist": {
          "type": "string",
          "default": "",
          "description": "Enumeration of character hypotheses (from the model) to suppress; overruled by unblacklist if set."
        },
        "char_unblacklist": {
          "type": "string",
          "default": "",
          "description": "Enumeration of character hypotheses (from the model) to allow inclusively."
        },
        "model": {
          "type": "string",
          "description": "tessdata model to apply (an ISO 639-3 language specification or some other basename, e.g. deu-frak or Fraktur)"
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
          "default": -1
        },
        "overwrite_regions": {
          "type": "boolean",
          "default": true,
          "description": "remove existing layout and text annotation below the Page level"
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
          "default": -1
        },
        "overwrite_regions": {
          "type": "boolean",
          "default": true,
          "description": "remove existing layout and text annotation below the region level"
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
          "default": -1
        },
        "overwrite_lines": {
          "type": "boolean",
          "default": true,
          "description": "remove existing layout and text annotation below the TextRegion level"
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
          "default": -1
        },
        "overwrite_words": {
          "type": "boolean",
          "default": true,
          "description": "remove existing layout and text annotation below the TextLine level"
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
          "default": -1
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
