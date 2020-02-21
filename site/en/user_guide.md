---
layout: page
author: Elisabeth Engl
date: 2020-02-04T19:16:54+01:00
lang: en
lang-ref: from-novice-to-pro
toc: true
---

# User Guide for Non-IT Users (without Docker)

## Prerequisites and Preparations

### Virtual environment

Before starting to work with the OCR-D-software you should activate the
virtualenv. This has either been installed automatically if you installed the
software via ocrd_all, or you should have [installed it yourself](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) before
installing the OCR-D-software individually. 

```sh
source ~/venv/bin/activate
```

Once you have activated the virtualenv, you should see `(venv)` prepended to
your shell prompt.

When you are done with your OCR-D-work, you can use `deactivate` to deactivate
your venv.

### Preparing a workspace

OCR-D processes digitized images in so-called workspaces, special directories
which contain the images to be processed and their corresponding METS file. Any
files generated while processing these images with the OCR-D-software will also
be stored in this directory. 

How you prepare a workspace depends on whether you already have or don't have a
METS file with the paths to the images you want to process. For usage within
OCR-D your METS file should look similar to [this example](example_mets.md). 

#### Already existing METS

If you already have a METS file as indicated above, you can create a workspace
and load the pictures to be processed with the following command: 

```sh
ocrd workspace clone [URL of your mets.xml]
```

In most cases, METS files indicate several picture formats. For OCR-D you will
only need one format. We strongly recommend using the format with the best
resolution. Optionally, you can specify to only load the filegroup needed at
the end of the command above.

You can also optionally specify a particular name for your workspace. If you
don't, it will simply generate a name by itself.

#### Non-existing METS

If you don't have a METS file or it doesn't suffice the OCR-D-requirements you
can generate it with the following commands. First, you have to create a
workspace:

```sh
ocrd workspace init [/path/to/your/workspace]
```

Then you can change into your workspace and set a unique ID

```sh
workspace$ ocrd workspace set-id 'unique ID'
```

and copy the folder containing your pictures to be processed into the workspace:

```sh
cp -r [/path/to/your/pictures] .
```
**Note:** All pictures must have the same format (tif, jpg, ...)

Now you can add your pictures to the METS. When creating the workspace, a blank
METS file was created, too, to which you can add the pictures to be processed. 

You can do this manually with the following command:

```sh
ocrd workspace add -g [ID of the physical page, has to start with a letter] -G [name of picture folder in your workspace] -i [ID of the scanned page] -m image/[format of your picture] [/path/to/your/picture/in/workspace]
```

Your command could e.g. look like this:

```sh
ocrd workspace add -g P_00001 -G OCR-D-IMG -i 00001 -m image/tif OCR-D-IMG/00001.tif
```

If you have many pictures to be added to the METS, you can do this automatically with a for-loop:

```sh
for i in [/path/to/your/picture/folder/in/workspace]/*.[file ending of your pictures]; do base= `basename ${i} .[file ending of your pictures]`; ocrd workspace add -G [name of picture folder in your workspace] -i ${base} -g P_${base} -m image/[format of your pictures] ${i}; done
```

Your for-loop could e.g. look like this:

```sh
for i in OCR-D-IMG/*.tif; do base=`basename ${i} .tif`; ocrd workspace add -G OCR-D-IMG -i ${base} -g P_${base} -m image/tif ${i}; done
```

In the end, your METS file should look like this [example METS](example_mets.md).

## Using the OCR-D-processors

### OCR-D-Syntax

There are several ways for invoking the OCR-D-processors. However, all of those
ways make use of the following syntax:

```sh
-I Input-Group    # folder of the files to be processed
-O Output-Group   # folder for the output of your processor
-p parameter.json # indication of parameters for a particular processor
```

For some processors parameters are purely optional, other processors as e.g. `ocrd-tesserocr-recognize` won't work without one or several parameters.

### Calling a single processor
If you just want to call a single processor, e.g. for testing purposes, you can go into your workspace and use the following command:
```sh
ocrd-[processor needed] -I [Input-Group] -O [Output-Group] -p [path to parameter.json]'
```
Your command could e.g. look like this:
```sh
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json
```

**Note:** For processors using multiple input-, or output groups you have to use a comma separated list. 

E.g.: 

```sh
ocrd-anybaseocr-crop  -I OCR-D-IMG -O OCR-D-BIN,OCR-D-IMG-BIN
```

The [`parameter.json`](`parameter.json`) file can be created with the following command:

```
echo '{ "[parameter]": "[specification]" }' > [name of your param.json file]
```

Instead of calling a `parameter.json` file you can also directly
write down the parameters when invoking a processor:

```sh
-p '{"[parameter]": "[value]"}'
```

**Note:** If multiple parameters are necessary they have to be separated by a comma. (No comma after the last parameter!)

E.g.: 

```sh
-p '{"[param1]": "[value1]", "[param2]": "[value2]", "[param3]": "[value3]"}'
```

### Calling several processors

#### ocrd-process

If you quickly want to specify a particular workflow on the CLI, you can use
ocrd-process, which has a similar syntax as calling single processors.

```sh
ocrd process \
  '[processor needed without prefix 'ocrd-'] -I [Input-Group] -O [Output-Group]' \
  '[processor needed without prefix 'ocrd-'] -I [Input-Group] -O [Output-Group] -p [parameter.json]'
```

Your command could e.g. look like this:

```sh
ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json'
```

**Note:** In contrast to calling a single processor, for ocrd-process you leave
out the prefix `ocrd-` before the name of a particular processor.

#### Taverna

Taverna is a more sophisticated workflow-software which allows you to specify a
particular workflow in a file and call this workflow, or rather its file, on
several workspaces.

Note that Taverna is not included in your [`ocrd_all`](https:/github.com/OCR-D/ocrd_all) installation. Therefore, you still might have to install it following this [setup guide](setup.md).

Taverna comes with several predefined workflows which can help you getting started. These are stored in the `/conf` directory. 

1. parameters.txt  (best results without gpu)
2. parameters_fast.txt (good results for slower computers)
3. parameters_gpu.txt (best results with gpu)

**Note:** Those workflows are only tested with a limited set of pages of the 17./18. century. Results may be worse for other prints.

For every workflow at least two files are needed: A `workflow_configuration` file contains a particular workflow which is invoked by a `parameters` file. For calling a workflow via Taverna, change into the `Taverna` folder and use the following command:

```sh
bash startWorkflow.sh [particular parameters.txt] [path to your workspace]
```

The images in your indicated workspace will be processed and the respective
output will be saved into the same workspace.

When you want to adjust a workflow for better results on your particular
images, you should start off by copying the original `workflow_configuration`
and `parameters` files. To this end, change to the `/conf` subdirectory of
`Taverna` and use the following commands:

```sh
conf$ cp workflow_configuration.txt [name of your new workflow_configuration.txt]
conf$ cp parameters.txt [name of your new parameters.txt]
```

Open the new `parameters.txt` file with an editor like e.g. Nano and change the
name of the old `workflow_configuration.txt` specified in this file to the name
of your new `workflow_configuration.txt` file: 

```sh
nano [name of your new workflow_configuration.txt]
```

Then open your new `workflow_configuration.txt` file respectively and adjust it to your needs by exchanging or adding the specified processors of parameters. For information on the available processors see ???

👷

#### workflow-config

👷

### Specifying New OCR-D-Workflows

👷

When you want to specify a new workflow adapted to the features of particular
images, we recommend using an exisiting workflow as specified in `Taverna` or
`workflow-config` as starting point. You can adjust it to your needs by
exchanging or adding the specified processors of parameters. For an overview on
the existing processors, their tasks and features, see ???.
