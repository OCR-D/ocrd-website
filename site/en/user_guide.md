---
layout: page
author: Elisabeth Engl
date: 2020-02-04T19:16:54+01:00
lang: en
lang-ref: https://translate.google.com/translate?hl=&sl=en&tl=de&u=https%3A%2F%2Focr-d.de%2Fen%2Fuser_guide
toc: true
title: User Guide for Non-IT Users
---

# User Guide for Non-IT Users

The following guide provides a detailed description on how to use the OCR-D software after it has been
[installed](setup) successfully. As explained in the [Setup Guide](setup), you can either use the
[OCR-D Docker solution](https://ocr-d.github.io/en/setup#ocrd_all-via-docker), or you can
[install the Software natively](https://ocr-d.github.io/en/setup#ocrd_all-natively) on your OS.

Depending on which option you prefer, you will require different steps to run OCR-D, as detailed
in the following two paragraphs. (The [third paragraph](#preparing-a-workspace) is obligatory
for both Docker and native users.)

Docker commands need a [extra syntax over native commands](#translating-native-commands-to-docker-calls). 
This guide always states native calls first, but follows up with the respective command for Docker.

## Preparations

### Docker installation: Run container

If you are using the Installation via Docker, we recommend running an interactive shell session in the container:

```sh
docker run --user $(id -u) --tmpfs /tmp --volume $PWD:/data --volume ocrd-models:/models -it ocrd/all bash
```

<!--
docker run --user $(id -u) --volume $PWD:/data -it ocrd/all bash
-->

After spinning up the container, you can use the internal installation and call the processors
the same way as in the native installation. Alternatively, you can
[translate each command to a docker call](/en/user_guide#translating-native-commands-to-docker-calls) separately.

### Native installation: Activate virtual environment

If you are using a native installation, you must activate the venv before you can start
working with the OCR-D software. It has either been created automatically if you 
[installed the software via ocrd_all](setup), or you should have manually
[installed it yourself](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments)
before installing the OCR-D software. 

To activate, you need to specify the path to your venv. In the automatic `ocrd_all` case,
it has simply been created under `venv` in your `ocrd_all` directory:

```sh
# example with manually created venv:
$ source ~/venv/bin/activate

# example for automatically created venv:
$ source ocrd_all/venv/bin/activate

# when the shell loads the venv, the prompt will change:
(venv) $
```

Once you have activated the venv in your shell, you should see its name prepended to
the command prompt.

When you are done with your OCR-D work, you can use `deactivate` to deactivate
the venv (or just terminate the shell).


### Preparing a workspace

OCR-D processes digitized images in so-called [workspaces](spec/glossary#workspace),
i.e. special directories which contain the images to be processed and their corresponding 
METS file. Any files generated while processing these images with the OCR-D software
will also be stored in this directory.

How you prepare a workspace **depends** on whether or not you **already** have a METS file
with the paths (or URLs) to the images you want to process. For usage within
OCR-D your METS file should look similar to [this example](example_mets).

#### Already existing METS

If you already have a METS file as indicated above, you can create a workspace
and load the pictures to be processed with the following command:

```sh
ocrd workspace [-d path/to/workspace] clone URL_OF_METS
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace clone [-d path/to/your/workspace] URL_OF_METS
```

(Where `path/to/your/workspace` is but an example. You can **omit
the directory argument** if you want to use the current working directory
as target. For repeated use, we recommend a `cd path/to/your/workspace` once,
so in subsequent operations, the argument can be omitted.)

This will create a file `mets.xml` within the target directory.

In most cases, METS files indicate several picture formats. For OCR-D you will
only need one format. We strongly recommend using the format with the highest
resolution. Optionally, you can specify to only load the file group needed:

List all existing groups:

```sh
ocrd workspace [-d /path/to/your/workspace] list-group
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace [-d path/to/your/workspace] list-group
```

This will provide you with the names of all the different file groups in your METS, e.g. `THUMBNAILS`,
`PRESENTATION`, `MAX`.

Download all files of one file group:

```sh
ocrd workspace [-d path/to/your/workspace] find --file-grp [selected file group] --download
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace [-d path/to/your/workspace] find --file-grp [selected file group] --download
```

This will download all images in the specified file group and save them in a directory named accordingly
in your workspace. You are now ready to start processing your images with OCR-D.

#### Non-existing METS

If you don't have a METS file or it does not comply with the OCR-D requirements,
then you can generate one with the following commands. First, create an empty
workspace:

```sh
ocrd workspace [-d path/to/your/workspace] init
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace [-d path/to/your/workspace] init
```

(Where `path/to/your/workspace` is but an example. You can **omit
the directory argument** if you want to use the current working directory
as target. For repeated use, we recommend a `cd path/to/your/workspace` once,
so in subsequent operations, the argument can be omitted.)

This will **create** a file `mets.xml` within the target directory.

Then you can set a unique `mods:identifier` …

```sh
ocrd workspace [-d path/to/your/workspace] set-id 'unique ID'
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace [-d path/to/your/workspace] set-id 'unique ID'
```

… and copy or symlink the directory containing the images to be processed into the workspace directory:

```sh
cp -r path/to/your/images [path/to/your/workspace/].
ln -s path/to/your/images [path/to/your/workspace/].
```

Now you can add those images to the empty METS created above,
by **adding references** for their path names. You can do this in a number of ways. 

Either with the following simple command:

```sh
ocrd workspace [-d path/to/your/workspace] add -g {ID of the physical page} -G {name of image fileGrp} -i {ID of the image file} -m image/{MIME format of that image} {path/to/that/image/file/in/workspace}
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace [-d path/to/your/workspace] add -g {ID of the physical page} -G {name of image fileGrp} -i {ID of the image file} -m image/{MIME format of that image} {path/to/that/image/file/in/workspace}
```

> **Note**: Identifiers in XML must always [start with a letter](https://www.w3.org/TR/REC-xml/#NT-Names).

For example, your simple commands could look like this:

```sh
ocrd workspace add -g P_00001 -G OCR-D-IMG -i OCR-D-IMG_00001 -m image/tiff images/00001.tif
ocrd workspace add -g P_00002 -G OCR-D-IMG -i OCR-D-IMG_00001 -m image/tiff images/00002.tif
...
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace add -g P_00001 -G OCR-D-IMG -i OCR-D-IMG_00001 -m image/tiff images/00001.tif
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace add -g P_00002 -G OCR-D-IMG -i OCR-D-IMG_00002 -m image/tiff images/00002.tif
...
```

Or, if you have lots of images to be added to the METS, you can do this automatically with a `for` loop:
> **Note**: For this method, all images must have the same format (tiff, jpeg, ...)

```sh
FILEGRP="OCR-D-IMG" # name of fileGrp to use
EXT=".tif"  # the actual extension of the image files
MEDIATYPE="image/tiff"  # the actual MIME type of the images
cd path/to/your/workspace
for path in images/*$EXT; do
  base=`basename $path $EXT`;
  ## using local ocrd CLI:
  ocrd workspace add -G $FILEGRP -i ${FILEGRP}_${base} -g P_$base -m $MEDIATYPE $path
  ## alternatively, using Docker:
  docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace add -G $FILEGRP -i ${FILEGRP}_${base} -g P_$base -m $MEDIATYPE $path
done
```

For example, your `for` loop could look like this:

```sh
for path in images/*.tif; do base=`basename $path .tif`; ocrd workspace add -G OCR-D-IMG -i OCR-D-IMG_$base -g P_$base -m image/tiff $path; done
## alternatively, using Docker:
for path in images/*.tif; do base=`basename $path .tif`; docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd workspace add -G OCR-D-IMG -i OCR-D-IMG_$base -g P_$base -m image/tiff $path; done
```

The log information should inform you about every image which was added to the METS file.
In the end, your `mets.xml` should look like this [example METS](example_mets). 
You are now ready to start processing your images with OCR-D.

Finally, the shell script `ocrd-import` from [workflow-configuration](https://github.com/bertsky/workflow-configuration)
is a tool which does all of the above (and can also convert arbitrary image formats and extract from PDFs)
automatically. For usage options, see:

```sh
ocrd-import -h
```

For example, to search for all files under `path/to/your/images/` recursively, 
and add all image files under fileGrp `OCR-D-IMG`, keeping their filename stem as page ID,
while converting all unsupported image file formats like JPEG2000, XPS or PDF 
(the latter rendered to bitmap at 300 DPI) to TIFF on the fly, 
and also add any PAGE-XML file of the same filename stem under fileGrp `OCR-D-SEG-PAGE`,
while ignoring other files, and finally write everything to `path/to/your/images/mets.xml`, do:

```sh
ocrd-import --nonnum-ids --ignore --render 300 path/to/your/images
## alternatively using Docker
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd-import -P -i -r 300 path/to/your/images
```

You should now have a workspace which contains the aforementioned `mets.xml` that has
a fileGrp `OCR-D-IMG` referencing your local image files.

> **Note**: In OCR-D, we typically name the image fileGrp `OCR-D-IMG`, which is used
> throughout the documentation. Naming your image fileGrp differently is of course possible,
> but you should be aware that you then need to adapt the name of the image or input fileGrp
> when copying and pasting from the sample calls provide on this website.


## Using the OCR-D processors

### OCR-D command-line interface syntax

There are several ways for invoking the OCR-D processors. Still, all of them
make use of the following syntax:

```sh
-I Input-Group      # fileGrp of the files to be processed
-O Output-Group     # fileGrp of the files results
-P parameter value  # (direct assignment of parameters for a particular processor)
-p parameter-file   # (file-based assignment of parameters for a particular processor)
-g page-range       # (range of physical pages to be processed)
```

> **Note**: For some processors, all parameters are optional, while other processors such as
> `ocrd-tesserocr-recognize` will not work without some parameter specifications.

For information on the available processors, and their respective parameters,
see [getting more information about processors](#get-more-information-about-processors).

### Calling a single processor
If you just want to run a single processor, you can go into your workspace and use the following command:
```sh
ocrd-{processor name} -I {Input-Group} -O {Output-Group} [-p {parameter-file}] [-P {parameter} {value}]
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd-{processor name} -I {Input-Group} -O {Output-Group} [-p {parameter-file}] [-P {parameter} {value}]
```
For example, your processor call command could look like this:
```sh
ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN -P impl sauvola
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-BIN -P impl sauvola
```

The specified processor will read the files in fileGrp `Input-Group`,
binarize them and write the results in fileGrp `Ouput-Group` in your workspace
(i.e. both as files on the filesystem and referenced in the `mets.xml`). 
It will also add information about this processing step in the METS metadata.

> **Note**: For processors using multiple input- or output fileGrps you have to use a comma-separated list.

For example:

```sh
ocrd-cor-asv-ann-align  -I OCR-D-OCR1,OCR-D-OCR2,OCR-D-OCR3 -O OCR-D-OCR4
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd-cor-asv-ann-align  -I OCR-D-OCR1,OCR-D-OCR2,OCR-D-OCR3 -O OCR-D-OCR4
```

> **Note**: If multiple parameter key-value pairs are necessary, each of them has to be preceded by `-P` as in 
```sh
... -P param1 value1 -P param2 value2 -P param3 value3
```

> **Note**: If a value consists of several words with whitespaces, they have to be enclosed in quotation marks
> (to prevent the shell from splitting them up) as in
```sh
-P param "value value"
```

### Calling several processors

Running several processors one after another on the same data is called a **workflow**.
For workflow processing, you need a workflow format and a workflow engine. 

In the most simple case, you just write a shell script which combines single processor
calls in a command sequence joined by `&&`. The following paragraphs will describe more
advanced options.

#### ocrd process

If you quickly want to specify a particular workflow on the CLI, you can use
`ocrd process`, which has a similar syntax as calling single processor CLIs:

```sh
ocrd process \
  '{processor needed without prefix 'ocrd-'} -I {Input-Group} -O {Output-Group}' \
  '{processor needed without prefix 'ocrd-'} -I {Input-Group} -O {Output-Group} -P {parameter} {value}'
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd process \
  '{processor needed without prefix 'ocrd-'} -I {Input-Group} -O {Output-Group}' \
  '{processor needed without prefix 'ocrd-'} -I {Input-Group} -O {Output-Group} -P {parameter} {value}'
  ```

For example, your command could look like this:

```sh
ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -P model Fraktur'
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -P model Fraktur'
```

Each specified processor will read the files in the respective fileGrp `Input-Group`,
process them accordingly, and write the results in the respective fileGrp `Ouput-Group`
in your workspace (i.e. both as files on the filesystem and referenced in the `mets.xml`). 
It will also add information about this processing step in the METS metadata.

The processors work on the files sequentially. So at first, all pages will be processed
with the first processor (e.g. binarized), then (if successful) all pages will be processed 
by the second processor (e.g. segmented) etc. 

So in the end, your workspace should contain a directory (and fileGrp) with (intermediate)
processing results for each output fileGrp specified in the workflow.

> **Note**: In contrast to calling a single processor, for `ocrd process` you leave
> out the prefix `ocrd-` before the name of a particular processor.

#### ocrd-make

`ocrd-make` from [workflow-configuration](https://github.com/bertsky/workflow-configuration)
is another tool for specifying OCR-D workflows and running them. It combines GNU `parallel` with GNU `make`
as workflow engine, treating document processing like software builds (including incremental and parallel
computation). Configurations are just makefiles, workspaces and their file groups are just targets.

It is included in [ocrd_all](https://github.com/OCR-D/ocrd_all), therefore you most likely already
[installed it](setup) along with the other OCR-D processors. 

> **Note**: The `workflow-configuration` distribution contains several example workflows, which were tested
> against the Ground Truth provided by OCR-D. For CER results of those workflows in our tests see
> [the table on GitHub](https://github.com/bertsky/workflow-configuration#usage). However, most workflows
> are configured for GT data, i.e. they expect preprocessed images which were already segmented
> at least down to line level. If you want to run them on naked images, you have to add some preprocessing
> and segmentation steps first, otherwise they will fail.

In order to run a workflow, change into your data directory (which contains the workspaces) and call
the desired configuration file on your workspace(s):

```sh
ocrd-make -f {name_of_your_workflow.mk} [/path/to/your/workspace1] [/path/to/your/workspace2] ...
```

As indicated in the command above, you can run a workflow on several workspaces by listing them after one another.
Or use the special target `all` for all the workspaces in the current directory.
The documents in those workspaces will be processed and the respective output 
along with the log files will be saved into the same workspace(s).

For an overview of all available targets and workspaces:

```sh
ocrd-make help
```

For general info on `make` invocation, including the `-j` switch for parallel processing:
```sh
make --help
```

When you want to adjust a workflow for better results on your particular
images, you should start off by copying the original `workflow.mk`
file:

```sh
cp workflow.mk {name_of_your_new_workflow_configuration.mk}
```

Then open the new file with an editor which understands `make` syntax like e.g. `nano`,
and exchange or add the processors or parameters to your needs:

```sh
nano {name_of_your_new_workflow_configuration.mk}
```

You can write new rules by using file groups as prerequisites/targets in the normal GNU make syntax.
The first target defined must be the default goal that builds the very last file group for that configuration.
Alternatively, a variable `.DEFAULT_GOAL` pointing to that target can be set anywhere in the makefile.

> **Note**: Also see the [extensive Readme of workflow-configuration](https://bertsky.github.io/workflow-configuration)
> on how to write workflows or adjust the preconfigured workflows to your needs.

#### Translating native commands to Docker calls
The command calls presented above are easy to translate for use in our
Docker images – simply by prepending the boilerplate telling Docker which image to use,
which user to run as, which files to bind to a container path etc.

For example a call to
[`ocrd-tesserocr-segment`](https://github.com/OCR-D/ocrd_tesserocr) might natively
look like this …

```sh
ocrd-tesserocr-segment -I OCR-D-IMG -O OCR-D-SEG
```

… to run it with the [`ocrd/all:maximum`](https://hub.docker.com/r/ocrd/all/tags) Docker container …

```sh
docker run -u $(id -u) -v $PWD:/data -v ocrd-models:/models -- ocrd/all:maximum ocrd-tesserocr-segment -I OCR-D-IMG -O OCR-D-SEG
           \_________/ \___________/ \_____________________/ \________________/ \______________________________________________/
               (1)          (2)             (3)                        (4)                         (5)
```


* (1) tells Docker to run the container as the calling user (who should have write access to the CWD) instead of root
* (2) tells Docker to bind-mount the current working directory (CWD) under `/data` in the container
* (3) tells Docker to mount `/models` in the container (i.e. the location for all models) under the **named volume** `ocrd-models`
* (4) tells Docker which image to spawn a container for
* (5) is the unchanged call to the processor

> **Note**: You can replace the host-side path in (2) with any absolute directory path.

> **Note**: Make sure to keep re-using the same named volume for models and other file resources under (3).
> For details, see [models and Docker](models#models-and-docker)

> **Note**: It can also be useful to have Docker automatically delete the container after termination
> by adding the `--rm` option.

> **Note**: It can also be useful to have Docker mount `/tmp` in the container to faster memory,
> which can be done via `--tmpfs /tmp` (for a RAM disk) or something like `-v /nvram:/tmp`.

### Specifying new OCR-D workflows

When you want to specify a new workflow adapted to the features of particular
images, we recommend using an existing workflow as specified in the [Workflow Guide](workflows)
as starting point. You can adjust it to your needs by exchanging or adding the specified parameters
and/or processors. For an overview on the existing processors, their tasks and features, see the 
[next section](#get-more-information-about-processors) and our [workflow guide](workflows.html).



### Get more information about processors

To get all available processors you might use the autocomplete in your preferred console.

> **Note**: If you installed OCR-D via Docker, make sure you run the interactive bash shell
> on the ocrd/all Docker image as described in the section [Preparations](#docker-installation-run-container).
> If you installed OCR-D natively, activate the virtual environment first as described in the section
> [Preparations](#native-installation-activate-virtual-environment).

Type `ocrd-` followed by a tab character (for autocompletion proposals) to get a list of all available processors.

To get further information about a particular processor, call it with `--help` or `-h`:

```sh
ocrd-{processor name} --help
## alternatively, using Docker:
docker run --rm -u $(id -u) -v $PWD:/data -- ocrd/all:maximum ocrd-{processor name} --help
```


### Using models

Several processors rely on models, which usually have to be downloaded beforehand.
An overview on the existing model repositories and short descriptions on the most important models
can be found in our [Models Guide](https://ocr-d.de/en/models).
We strongly recommend to use the [OCR-D resource manager](https://ocr-d.de/en/models) to download the models,
as this makes it easy to both download and use them.
