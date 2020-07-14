---
layout: post
lang: en
title: Introduction to ocrd workspace CLI
---

Once [you have set up OCR-D](/en/setup) you can start exploring the command
line tools. One particular versatile command is `ocrd workspace` which will
be introduced in this article.

All OCR-D processors and all other command line tools produced in
OCR-D support the `--help` flag. If you are unsure what a command does
or how it is invoked, try `<command> --help`, e.g.  for `ocrd workspace`:

```sh
$ ocrd workspace --help

Usage: ocrd workspace [OPTIONS] COMMAND [ARGS]...

  Working with workspace

Options:
  -d, --directory WORKSPACE_DIR  Changes the workspace folder location.
                                 [default: .]

  -M, --mets-basename TEXT       The basename of the METS file.  [default:
                                 mets.xml]

  --backup                       Backup mets.xml whenever it is saved.
  --help                         Show this message and exit.

Commands:
  add           Add a file or http(s) URL FNAME to METS in a workspace.
  backup        Backing and restoring workspaces - dev edition
  bulk-add      Add files in bulk to an OCR-D workspace.
  clone         Create a workspace from METS_URL and return the directory...
  find          Find files.
  get-id        Get METS id if any
  init          Create a workspace with an empty METS file in DIRECTORY.
  list-group    List fileGrp USE attributes
  list-page     List physical page IDs
  prune-files   Removes mets:files that point to non-existing local files...
  remove        Delete files (given by their ID attribute ``ID``).
  remove-group  Delete fileGrps (given by their USE attribute ``GROUP``).
  set-id        Set METS ID.
  validate      Validate a workspace METS_URL can be a URL, an absolute
                path...
```

## What is a workspace

A workspace in OCR-D's terminology is a directory with a METS file, referencing
PAGE-XML and images. Processors work on a workspace, you can create (`init`) a new
workspace from scratch or download (`clone`) an existing METS file.

## Init

If you only have a directory of digitized images and no METS, you can create
one with `ocrd workspace init`.

* Create a new mets.xml in the current directory:

```sh
ocrd workspace init
```

* Create a new mets.xml at /path/to/ws1:

```sh
ocrd workspace --directory /path/to/ws1 init
```

## clone

To create a local workspace from a remote METS document, use the `ocrd
workspace clone` command:

* Create a workspace in the current directory from a remote METS URL:

```sh
ocrd workspace clone 'https://remote.host/mets.xml'
```

* Create a workspace at `/tmp/ws` from a remote METS URL:

```sh
ocrd workspace --directory /tmp/ws clone https...
```

* Create a workspace at `/tmp/ws` from a remote URL, **also downloading all files referenced in the METS**:

```sh
ocrd workspace --directory /tmp/ws clone --download https...
```

## Add

Once you have a workspace, i.e. a `mets.xml` file in place, you can use the
command line tools to do all kinds of operations on the workspace. Here we'll
focus on how to add files to the workspace.

Files can be added with the `ocrd workspace add` command. When adding a file,
there are a number of required parameters to describe the file, as per its help:
```sh
ocrd workspace add --help
Usage: ocrd workspace add [OPTIONS] FNAME

  Add a file or http(s) URL FNAME to METS in a workspace. If FNAME is not an
  http(s) URL and is not a workspace-local existing file, try to copy to
  workspace.

Options:
  -G, --file-grp TEXT      fileGrp USE  [required]
  -i, --file-id TEXT       ID for the file  [required]
  -m, --mimetype TEXT      Media type of the file  [required]
  -g, --page-id TEXT       ID of the physical page
  -C, --check-file-exists  Whether to ensure FNAME exists
  --ignore                 Do not check whether file exists.
  --force                  If file with ID already exists, replace it. No
                           effect if --ignore is set.

  --help                   Show this message and exit.
```

The `-G`, `-i` and `-m` options are required and we strongly recommend you also
always set the `--page-id` for a file to make it clear which page the file
being added represents.

For example, let's assume you have a PNG image at `/tmp/IMG_0001`, representing
the first physical page of the work. You can add that to the empty workspace at `/tmp/ws` [we created before](#init-and-clone), like so:

```sh
ocrd workspace --directory /tmp/ws add -i FILE_0001_PNG -G OCR-D-IMG -m image/png -g PHYS_0001 /tmp/IMG_0001.png
```

Here's a breakdown of the options

* `-i FILE_0001_PNG`: This must be a unique identifier of a file. Make sure to make it specific enough, e.g. by adding the format (as we're doing here) or with some other consistent naming scheme
* `-G OCR-D-IMG`: Add this file to the `OCR-D-IMG` file group (or create it if it does not yet exist). The names of `mets:fileGrp` are **completely arbitrary**. By convention, OCR-D uses `OCR-D-IMG` for the unprocessed images in [the Ground Truth](https://ocr-d.de/gt-repo/) but other conventions call this file group `MAX` (for MAXimum resolution).
* `-m image/png`: The media type or MIME type of the file, `image/png` for PNG images, `image/tiff` for TIFF, etc.
* `-g PHYS_0001`: The ID of the physical page, i.e. the `mets:div` that groups together all files representing the same page. The identifier is arbitrary as well, though many METS tools chose `PHYS_` + numerical identifier as the naming convention.
Note that -i and -g always have to start with a letter
After running the command, you will find the file copied into the workspace at `<fileGrp>/<ID>.ext`, so in this case at `OCR-D-IMG/IMG_0001.png`.

To make sure that the file was added, you can use the `ocrd workspace find` command:

```sh
ocrd workspace find -k ID -k fileGrp -k mimetype -k pageId
FILE_0001_PNG   OCR-D-IMG       image/png       PHYS_0001
```

If you need to add many files at once, there is a command `ocrd workspace
bulk-add` that is orders of magnitude faster than calling `ocrd workspace add`
for each and every file. See `ocrd workspace bulk-add --help` for an example
how to use it and if you encounter problems, as always, [ask for support in the 
OCR-D chat](https://gitter.im/OCR-D/Lobby).

## Validate

Lastly, we want to look at the `ocrd workspace validate` command that makes assertions
on the validity, syntactical correctness and [spec compliance](https://ocr-d.de/en/spec)
of all parts of a workspace: METS, PAGE-XML and images.

Initially developed for producing and validating [Ground Truth](https://ocr-d.de/gt), it
has many checks that can help you find problems in your data

```
ocrd workspace validate --help
Usage: ocrd workspace validate [OPTIONS] [METS_URL]

  Validate a workspace

  METS_URL can be a URL, an absolute path or a path relative to $PWD. If not
  given, use the concatenation of --directory and --mets-basename.

  Check that the METS and its referenced file contents abide by the OCR-D
  specifications.

Options:
  -a, --download                  Download all files
  -s, --skip [imagefilename|dimension|mets_unique_identifier|mets_file_group_names|mets_files|pixel_density|page|page_xsd|mets_xsd|url]
                                  Tests to skip
  --page-textequiv-consistency, --page-strictness [strict|lax|fix|off]
                                  How strict to check PAGE multi-level
                                  textequiv consistency

  --page-coordinate-consistency [poly|baseline|both|off]
                                  How fierce to check PAGE multi-level
                                  coordinate consistency

  --help                          Show this message and exit.
```

If you don't provide any options, the validation will run all checks on your
workspace and report any issues, grouped by severity ("notice", "warning",
"error") as a simple XML document that is both human-readable bnd
machine-readable.

To skip certain tests that are not helpful for you, use the `--skip` option.
For example, if your images have incorrect `DPI` metadata, you can omit those
messages with `--skip pixel_density`.

## Further reading

* [Setup Guide](https://ocr-d.de/en/setup)
* [OCR-D Chat](https://gitter.im/OCR-D/Lobby)
* [OCR-D Wiki](https://github.com/OCR-D/ocrd-website/wiki)
