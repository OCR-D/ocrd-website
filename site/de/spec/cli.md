---
layout: page
lang: de
lang-ref: cli.md
toc: true
---

# Command Line Interface (CLI)

All tools provided by MP must be standalone executables, installable into `$PATH`.

Those tools intended for run-time data processing (but not necessarily tools for training or deployment) are called **processors**.
Processors must adhere to the following uniform interface, including mandatory and optional parameters (i.e. no more or fewer are permissible).

**NOTE:** Command line options cannot be repeated, except those explicitly
marked as **REPEATABLE** (e.g. `-p params.json -p '{"val": 1}'` is allowed
because [`-p` is repeatable](#-p---parameter-param_json).

**NOTE**: Parameters marked **MULTI-VALUE** cannot be repeated but can specify
multiple values, formatted as a single string with comma-separated items (e.g.
`-I group1,group2,group3` instead of `-I group1 -I group2 -I group3`).

## CLI executable name

Every CLI executable's name must begin with `ocrd-`.

Examples:
  * `ocrd-kraken-binarize`
  * `ocrd-tesserocr-recognize`

## Mandatory parameters

### `-I, --input-file-grp GRP`

**MULTI-VALUE**

[METS](mets) file group(s) used as input.

Input file groups must not be modified.

## Optional parameters

### `-O, --output-file-grp GRP`

**MULTI-VALUE**

[METS](mets) file group(s) used as output.

Omit to resort to default output file groups of the processor, or for processors that inherently do not produce output files.

### `-g, --page-id ID`

**MULTI-VALUE**

The `mets:div[@TYPE='page']/@ID` that contains the `mets:fptr/@FILEID` pointers
to files representing a page. Effectively, only those files in the [input file
group](#-i---input-file-grp-grp) that are referenced in these
`mets:div[@TYPE="page"]` will be processed.

Omit to process all pages.

### `--overwrite`

Delete files in the output file group(s) before processing.

If `--overwrite` is set, but [`--page-id`](-g---page-id-id) is not set, delete
all output file groups set with
[`--output-file-grp`](-o---output-file-grp-grp), including all files that belong to
those file groups.

If `--overwrite` is set and [`--page-id`](-g---page-id-id) is set, delete all files that represent
any of the page IDs given with [`--page-id`](-g---page-id-id) from all output
file groups set with
[`--output-file-grp`](-o---output-file-grp-grp)

"File deletion" in the context of `--overwrite` means deletion of matching
`mets:file` elements from the METS document and all local files these
`mets:file` represent.

"Group deletion" in the context of `--overwrite` means deletion of the
`mets:fileGrp` element from METS, and deletion of all files that belong to this
`mets:fileGrp` element.

### `-p, --parameter PARAM_JSON`

**REPEATABLE**

URL of parameter file in [JSON format](https://json.org/) corresponding to the
`parameters` section of the processor's [ocrd-tool metadata](ocrd_tool). If
that file is not readable and `PARAM_JSON` begins with `{` (opening brace), try
to parse `PARAM_JSON` as JSON. If that also fails, throw an exception.

When parsing JSON, all lines matching the regular expression `^\s*#.*`, i.e.
lines whose first non-whitespace character is `#`, are to be disregarded as
comments.

When `-p` is repeated, the parsed values should be shallowly merged from right
to left.

`-p` can be omitted to use default parameters only, or for processors without
any parameters.

### `-P, --parameter-override KEY VAL`

**REPEATABLE**

Companion to [`-p, --parameter PARAM_JSON`](#-p--parameter-PARAM_JSON) that allows overriding `KEY` in the parameter JSON object with `VAL`. All `P` key-value-pairs are applied to the parameter JSON in the order they are given on the command line.

Syntactically, `VAL` SHOULD be a valid JSON datatype:
  * `"a string"` - a string should be enclosed with double quotes, contained double quotes backslash-escaped
  * `123` - an int
  * `123.45` - a float
  * `true`, `false` - a boolean
  * `[1, "two", 3.33]` - an array
  * `{"foo": 42}` - an object

As a convenience, if `VAL` fails to parse as a valid JSON type, it is
interpreted as a string (`a string` is equivalent to `"a string"`, but `true`
will be parsed as the boolean value `true`, not the string `"true"`).

### `-m, --mets METS_IN`

Input [METS](mets) URL. Default: `mets.xml`

If `METS_IN` is a file path but the file is not readable, processors must
show the [`--help` message](#-h---help) message and exit with return code `1`.

### `-w, --working-dir DIR`

Working Directory. Default: current working directory.

### `-l, --log-level LOGLEVEL`

Set the global maximum verbosity level. More verbose log entries will be
ignored. (One of `OFF`, `ERROR`, `WARN`, `INFO` (default), `DEBUG`, `TRACE`).

**NOTE:** Setting the log level via `--log-level` parameter should override any
other implementation-specific means of logging configuration. For example, with
`--log-level TRACE` no log messages should be filtered globally, whereas
`--log-level ERROR`, only errors should be output globally.

### `-J, --dump-json`

Instead of processing METS, output the [ocrd-tool](ocrd_tool) description for
this executable, in particular its parameters.

### `-C, --show-resource FILENAME`

Print the contents of processor resource `FILENAME`. Look up the resp. absolute filename according to the [file parameter lookup rules](ocrd_tool#file-parameter).

### `-L, --list-resources`

List the names of [processor resources](#processor-resources) in all of the paths defined by.the [file parameter lookup rules](ocrd_tool#file-parameter), one name per line.

### `-h, --help`

Print a concise description of the tool, the command line options and
parameters it accepts as well as the input/output groups. This information should
be generated from [`ocrd-tool.json`](ocrd_tool) as much as possible.

## Return value

Successful execution should signal `0`. Any non-zero return value is considered a failure.

## Logging

Data printed to `STDERR` and `STDOUT` is captured linewise and stored as log data.

Processors must adjust logging verbosity according to the [`--log-level` parameter](#-l---log-level-loglevel).

Errors, especially those leading to exceptions, must be printed to `STDERR`.

The log messages must have the format `TIME LEVEL LOGGERNAME - MESSAGE\n`, where

* `TIME` is the current time in the format `HH:MM:ss.mmm`, e.g. `07:05:31.007`
* `LEVEL` is the log level of the message, in uppercase, e.g. `INFO`
* `LOGGERNAME` is the name of the logging component, such as the class name. Segments of `LOGGERNAME` should be separated by dot `.`, e.g. `ocrd.fancy_tool.analyze`
* `MESSAGE` is the message to log, should not contain new lines.
* `\n` is ASCII char `0x0a` (newline)

## Processor resources

Parameters that reference files can be resolved from relative to absolute
filename by following the [conventions laid out in the `ocrd_tool`
spec](ocrd_tool#file-parameters). These files, either bundled by the processor
developer or put in place by the user, are called *processor resources*. The
*processor resources* of a processor can be listed with the `-L/--list-resources`
option and individual *processor resources* can be retrieved with the
`-C/--show-resource` option. Since *processor resources* use the same mechanism
as file parameters, they can be used

  * as the argument to the `-p/--parameter` option (i.e. a **preset** file), and
  * as the value of a file-type parameter (e.g. a **model** file)

and the processor must resolve them to absolute paths [according to the rules
for file parameters](ocrd_tool#file-parameters).

## URL/file convention

Whenever a URL is expected, it should be possible to use a local file path
instead and have the implementation interpret as a `file://` URL on the fly.

Implementations should adhere to this algorithm when resolving a URL `u`:

1. If `u` contains the string `://`: Do not modify.
2. If `u` is an absolute path according to the mechanics of the underlying file system: Prepend `file://` to `u`.
3. Otherwise: Resolve `u` as a path relative to the current working directory, prepend `file://` to `u`.

**NOTE:** This convention is limited to the CLI for convenience of users and
developers. In METS and PAGE documents, URLs must be strictly valid and
resolvable by common software agents as-is.

## Example

This is how the CLI provided by the MP should work:

```sh
$> ocrd-kraken-binarize \
    --mets "file:///path/to/file/mets.xml" \
    --working-dir "file:///path/to/workingDir/" \
    --parameters "file:///path/to/file/parameters.json" \
    --page-id PHYS_0001,PHYS_0002,PHYS_0003 \
    --input-file-grp OCR-D-IMG
    --output-file-grp OCR-D-IMG-BIN-KRAKEN
```

And this is how it will be called with the `ocrd process` CLI:

```sh
$> ocrd process \
    'kraken-binarize -I OCR-D-IMG -O OCR-D-IMG-BIN-KRAKEN -p /path/to/file/parameters.json'
    -m "file:///path/to/file/mets.xml" \
    -g PHYS_0001,PHYS_0002,PHYS_0003

    preprocessing/binarization/kraken-binarize
```

### METS input

```xml
<mets:mets>
    <!-- ... -->
  <mets:structMap TYPE="PHYSICAL">
    <mets:div ID="PHYS_0000" TYPE="physSequence">
      <mets:div TYPE="page" ID="PHYS_0001">
        <mets:fptr FILEID="OCR-D-IMG_0001"/>
      </mets:div>
      <mets:div TYPE="page" ID="PHYS_0002">
        <mets:fptr FILEID="OCR-D-IMG_0002"/>
      </mets:div>
      <mets:div TYPE="page" ID="PHYS_0003">
        <mets:fptr FILEID="OCR-D-IMG_0003"/>
      </mets:div>
    </mets:div>
  </mets:structMap>

  <mets:fileSec>

    <mets:fileGrp USE="OCR-D-IMG">
      <mets:file ID="OCR-D-IMG_0001" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000001.tif" />
      </mets:file>
      <mets:file ID="OCR-D-IMG_0002" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000002.tif" />
      </mets:file>
      <mets:file ID="OCR-D-IMG_0003" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000003.tif" />
      </mets:file>
    </mets:fileGrp>

  </mets:fileSec>
</mets:mets>
```

### Input JSON parameter file

```json
{
    "threshold": 0.05,
    "zoom": 2,
    "range": [5, 10],
}
```

### METS output

This is the METS file after being run through the MP CLI:

```xml
<mets:mets>
    <!-- ... -->
  <mets:structMap TYPE="PHYSICAL">
    <mets:div DMDID="DMDPHYS_0000" ID="PHYS_0000" TYPE="physSequence">
      <mets:div TYPE="page" ID="PHYS_0001">
        <mets:fptr FILEID="OCR-D-IMG_0001"/>
        <mets:fptr FILEID="OCR-D-IMG-BIN-KRAKEN_0001"/>
      </mets:div>
      <mets:div TYPE="page" ID="PHYS_0002">
        <mets:fptr FILEID="OCR-D-IMG_0002"/>
        <mets:fptr FILEID="OCR-D-IMG-BIN-KRAKEN_0002"/>
      </mets:div>
      <mets:div TYPE="page" ID="PHYS_0003">
        <mets:fptr FILEID="OCR-D-IMG_0003"/>
        <mets:fptr FILEID="OCR-D-IMG-BIN-KRAKEN_0003"/>
      </mets:div>
    </mets:div>
  </mets:structMap>

  <mets:fileSec>

    <mets:fileGrp USE="OCR-D-IMG">
      <mets:file ID="OCR-D-IMG_0001" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000001.tif" />
      </mets:file>
      <mets:file ID="OCR-D-IMG_0002" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000002.tif" />
      </mets:file>
      <mets:file ID="OCR-D-IMG_0003" MIMETYPE="image/tiff">
        <mets:FLocat LOCTYPE="URL" xlink:href="https://github.com/OCR-D/spec/raw/master/io/example/00000003.tif" />
      </mets:file>
    </mets:fileGrp>

    <mets:fileGrp USE="OCR-D-IMG-BIN-KRAKEN">
      <mets:file ID="OCR-D-IMG-BIN-KRAKEN_0001" MIMETYPE="image/png">
        <mets:FLocat LOCTYPE="URL" xlink:href="file:///tmp/ocrd-workspace-ABC123/0001.png" />
      </mets:file>
      <mets:file ID="OCR-D-IMG-BIN-KRAKEN_0002" MIMETYPE="image/png">
        <mets:FLocat LOCTYPE="URL" xlink:href="file:///tmp/ocrd-workspace-ABC123/0002.png" />
      </mets:file>
      <mets:file ID="OCR-D-IMG-BIN-KRAKEN_0003" MIMETYPE="image/png">
        <mets:FLocat LOCTYPE="URL" xlink:href="file:///tmp/ocrd-workspace-ABC123/0003.png" />
      </mets:file>
    </mets:fileGrp>

  </mets:fileSec>
</mets:mets>
```
