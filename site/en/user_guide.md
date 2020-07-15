---
layout: page
author: Elisabeth Engl
date: 2020-02-04T19:16:54+01:00
lang: en
lang-ref: from-novice-to-pro
toc: true
---

# User Guide for Non-IT Users

The following guide provides a detailed description on how to use the OCR-D-Software after it has been installed successfully. As explained in the
setup guide, you can either use the [OCR-D-Docker-solution](https://ocr-d.github.io/en/setup#ocrd_all-via-docker), or you can
[install the Software locally](https://ocr-d.github.io/en/setup#ocrd_all-natively). Note that these two options require different prerequisites to get 
started with OCR-D after the installation as detailed in the very next two paragraphs. The [third preparatory step](#preparing-a-workspace) is
obligatory for both Docker and Non-Docker users!

Furthermore, Docker commands have a [different syntax than native calls](#translating-native-commands-to-docker-calls). This guide always states native calls first and then provides the respective command for Docker users. 

## Prerequisites and Preparations

### Setup docker

If you want to use the OCR-D-Docker-solution, [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository) and [docker compose](https://docs.docker.com/compose/install/) have to be installed.  

After installing docker you have to set up daemon and add user to  the group 'docker'

```sh
# Start docker daemon at startup
sudo systemctl enable docker
# Add user to group 'docker'
sudo usermod -aG docker $USER
```

<img src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png" alt="warning" style="zoom:33%;" /> Please log out and log in again.

To test access to docker try the following command:

```sh
docker ps
```

Now you should see an (empty) list of available images.

For installing docker images please refer to the [setup guide](setup.html).

### Virtual environment (without docker)

If you don't want to use Docker, you should activate the
virtualenv before starting to work with the OCR-D-software. This has either been installed automatically if you installed the
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
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace clone [URL of your mets.xml]
```

In most cases, METS files indicate several picture formats. For OCR-D you will
only need one format. We strongly recommend using the format with the highest
resolution. Optionally, you can specify to only load the file group needed:

List all existing groups:

```sh
ocrd workspace -d [/path/to/your/workspace] list-group
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace -d /data list-group
```

Download all files of one group:

```sh
ocrd workspace -d [/path/to/your/workspace] find --file-grp [selected file group] --download
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace -d /data find --file-grp [selected file group] --download
```

You can also optionally specify a particular name for your workspace. If you
don't, it will simply generate a name by itself.

#### Non-existing METS

If you don't have a METS file or it doesn't suffice the OCR-D-requirements you
can generate it with the following commands. First, you have to create a
workspace:

```sh
ocrd workspace init [/path/to/your/workspace] # or empty for current directory
## alternatively using docker
mkdir -p [/path/to/your/workspace]
docker run --rm -u $(id -u) -v [/path/to/your/workspace]:/data -w /data -- ocrd/all:maximum ocrd workspace init /data
```

Then you can change into your workspace directory and set a unique ID

```sh
cd /path/to/your/workspace # if not already there
ocrd workspace set-id 'unique ID'
## alternatively using docker
docker run --rm -u $(id -u) -v [/path/to/your/workspace]:/data -w /data -- ocrd/all:maximum ocrd workspace set-id 'unique ID'
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
ocrd workspace add -g [ID of the physical page, has to start with a letter] -G [name of picture folder in your workspace] -i [ID of the scanned page, has to start with a letter] -m image/[format of your picture] [/path/to/your/picture/in/workspace]
## alternatively using docker
docker run --rm -u $(id -u) -v [/path/to/workspace]:/data -w /data -- ocrd/all:maximum ocrd workspace add -g [ID of the physical page, has to start with a letter] -G [name of picture folder in your workspace] -i [ID of the scanned page, has to start with a letter] -m image/[format of your picture] [relative/path/to/your/picture/in/workspace]
```

Your command could e.g. look like this:

```sh
ocrd workspace add -g P_00001 -G OCR-D-IMG -i OCR-D-IMG_00001 -m image/tif OCR-D-IMG/00001.tif
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace add -g P_00001 -G OCR-D-IMG -i OCR-D-IMG_00001 -m image/tif OCR-D-IMG/00001.tif
```

If you have many pictures to be added to the METS, you can do this automatically with a for-loop:

```sh
for i in [/path/to/your/picture/folder/in/workspace]/*.[file ending of your pictures]; do base= `basename ${i} .[file ending of your pictures]`; ocrd workspace add -G [name of picture folder in your workspace] -i OCR-D-IMG_${base} -g P_${base} -m image/[format of your pictures] ${i}; done
## alternatively using docker
for i in [relative/path/to/your/picture/folder/in/workspace]/*.[file ending of your pictures]; do base= `basename ${i} .[file ending of your pictures]`; docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace add -G [name of picture folder in your workspace] -i OCR-D-IMG_${base} -g P_${base} -m image/[format of your pictures] ${i}; done 
```

<img src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png" alt="warning" style="zoom:33%;" /> If the file names of the images starts with a number, at least one of the following characters must be placed in front of its name for parameter 'i': [a-z,A-Z,_,-] (e.g.: 'OCR-D-IMG_\_')

Your for-loop could e.g. look like this:

```sh
for i in OCR-D-IMG/*.tif; do base=`basename ${i} .tif`; ocrd workspace add -G OCR-D-IMG -i OCR-D-IMG_${base} -g P_${base} -m image/tif ${i}; done
## alternatively using docker
for i in OCR-D-IMG/*.tif; do base=`basename ${i} .tif`;docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd workspace add -G OCR-D-IMG -i OCR-D-IMG_${base} -g P_${base} -m image/tif ${i}; done
```

In the end, your METS file should look like this [example METS](example_mets.md).

Alternatively, `ocrd-import` from [workflow-configuration](#workflow-configuration) is a shell script which does all of the above (and can also convert arbitrary image formats) automatically. For usage options, see:

```sh
ocrd-import -h
```

For example, to search for all files under `path/to/your/pictures/` recursively, and add all image files under file group `OCR-D-IMG`, keeping their filename stem as page ID, and converting all unaccepted image file formats like JPEG2000, XPS or PDF (the latter rendered to bitmap at 300 DPI) to TIFF on the fly, and also add any PAGE-XML file of the same filename stem under file group `OCR-D-SEG-PAGE`, while ignoring other files, and finally write everything to `path/to/your/pictures/mets.xml`, do:

```sh
ocrd-import --nonnum-ids --ignore --render 300 path/to/your/pictures
## alternatively using docker
docker run --rm -u $(id -u) -v [/path/to/your/data]:/data -w /data -- ocrd/all:maximum ocrd-import -P -i -r 300 path/to/your/pictures
```

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
ocrd-[processor needed] -I [Input-Group] -O [Output-Group] -p [path to parameter.json]
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd-[processor needed] -I [Input-Group] -O [Output-Group] -p [path to parameter.json]'
```
Your command could e.g. look like this:
```sh
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json
```

**Note:** For processors using multiple input-, or output groups you have to use a comma separated list. 

E.g.: 

```sh
ocrd-anybaseocr-crop  -I OCR-D-IMG -O OCR-D-BIN,OCR-D-IMG-BIN
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd-anybaseocr-crop  -I OCR-D-IMG -O OCR-D-BIN,OCR-D-IMG-BIN
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
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd process \
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
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd process \
  'cis-ocropy-binarize -I OCR-D-IMG -O OCR-D-SEG-PAGE' \
  'tesserocr-segment-region -I OCR-D-SEG-PAGE -O OCR-D-SEG-BLOCK' \
  'tesserocr-segment-line -I OCR-D-SEG-BLOCK -O OCR-D-SEG-LINE' \
  'tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESSEROCR -p param-tess-fraktur.json'
```

**Note:** In contrast to calling a single processor, for `ocrd process` you leave
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
bash startWorkflow.sh [particular parameters.txt] [/path/to/your/workspace]
## alternatively using docker
docker run --rm --network="host" -v $PWD:/data -- ocrd/taverna process [particular parameters.txt] [relative/path/to/your/workspace]
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

Then open your new `workflow_configuration.txt` file respectively and adjust it to your needs by exchanging or adding the specified processors of parameters. The first column contains the name of the processor, the following two columns indicate the names of the input and the output filegroups. The forth column for group-ID can be left blank. In the last column you can indicate the log level. 

If your processor requires a parameter, it has to be specified in the fith column. As with parameters when calling processors directly on the CLI, there are two ways how to specify them. You can either call a `json` file which should be stored in Taverna's subdirectory `models`. See [Calling a single processor](TODO) on how to create `json` files. Alternatively, you can directly write down the parameter needed using the following syntax:

```sh
{\"[param1]\":\"[value1]\",\"[param2]\":\"[value2]\",\"[param3]\":\"[value3]\"}
e.g.
{\"level-of-operation\":\"page\"}
```

**Note:** Avoid white spaces and escape double quotes with backslash.

For information on the available processors see [section at the end](#get-more-information-about-processors).



#### workflow-configuration

workflow-configuration is another tool for specifying OCR-D workflows and running them. It uses GNU make as workflow engine, treating document processing like software builds (including incremental and parallel computation). Configurations are just makefiles, targets are workspaces and their file groups.

In contrast to Taverna it is included in ocrd_all, therefore you most likely already installed it with the other OCR-D-processors.

The `workflow-configuration` directory already contains several workflows, which were tested against the Ground Truth provided by OCR-D. For the CER of those workflows in our tests see [the table on GitHub](https://github.com/bertsky/workflow-configuration#usage).

**Note:** Most workflows are configured for GT data, i.e. they expect preprocessed images which were already segmented at least down to line level. If you want to run them on raw images, you have to add some preprocessing and segmentation steps first. Otherwise they will fail. 

In order to run a workflow, change into your data directory (that contains the workspaces) and call the desired configuration file on your workspace(s):

```sh
ocrd-make -f [name_of_your_workflow.mk] [/path/to/your/workspace1] [/path/to/your/workspace2]
```

As indicated in the command above, you can run a workflow on several workspaces by listing them after one another. Or use the special target `all` for all the workspaces in the current directory.
The documents in those workspaces will be processed and the respective
output along with the log files will be saved into the same workspace(s).

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
cp workflow.mk [name_of_your_new_workflow_configuration.mk]
```

Then open the new file with an editor which understands `make` syntax like e.g. `nano`, and exchange or add the processors or parameters to your needs: 

```sh
nano [name_of_your_new_workflow_configuration.mk]
```

You can write new rules by using file groups as prerequisites/targets in the normal GNU make syntax. The first target defined must be the default goal that builds the very last file group for that configuration. Alternatively a variable `.DEFAULT_GOAL` pointing to that target can be set anywhere in the makefile. 

**Note:** Also see the [extensive Readme of workflow-configuration](https://bertsky.github.io/workflow-configuration) on how to adjust the preconfigured workflows to your needs.

#### Translating native commands to docker calls
The native calls presented above are simple to translate to commands based on the
docker images by prepending the boilerplate telling Docker which image to use,
which user to run as, which files to bind to a container path etc.

For example a call to
[`ocrd-tesserocr-binarize`](https://github.com/OCR-D/tesserocr) might natively
look like this:

```sh
ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
```

To run it with the [`ocrd/all:maximum`] Docker container:

```sh
docker run -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum ocrd-tesserocr-segment-region -I OCR-D-IMG -O OCR-D-SEG-BLOCK
           \_________/ \___________/ \______/ \_________________/ \___________________________________________________________/
              (1)          (2)         (3)          (4)                            (5)
```

* (1) tells Docker to run the container as the calling user instead of root
* (2) tells Docker to bind the current working directory as the `/data` folder in the container
* (3) tells Docker to change the container's working directory to `/data`
* (4) tells docker which image to run
* (5) is the unchanged call to `ocrd-tesserocr-segment-region`

It can also be useful to delete the container after creation with the `--rm`
parameter.

### Specifying New OCR-D-Workflows

When you want to specify a new workflow adapted to the features of particular
images, we recommend using an existing workflow as specified in `Taverna` or
`workflow-configuration` as starting point. You can adjust it to your needs by
exchanging or adding the specified processors of parameters. For an overview on
the existing processors, their tasks and features, see the [next section](#get-more-information-about-processors) and our [workflow guide](workflows.html).




### Get more Information about Processors

To get all available processors you might use the autocomplete in your preferred console. 

**Note:** Activate virtual environment first.

Type 'ocrd-' followed by `TAB` to get a list of all available processors.

To get further information about one processor type

```sh
[name_of_selected_processor] -h
## alternatively using docker
docker run --rm -u $(id -u) -v $PWD:/data -w /data -- ocrd/all:maximum [name_of_selected_processor] -h
```



