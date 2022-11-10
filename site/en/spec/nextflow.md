---
layout: page
lang: en
lang-ref: nextflow.md
toc: true
title: Workflow Format (Nextflow)
---

# Workflow Format (Nextflow)

One key task in phase III of OCR-D was to define a workflow format describing sequences of OCR-D processors processing the images. Our solution is based on the open source project [Nextflow (NF)](https://www.nextflow.io/).
The files (with the extension ```.nf```) describing this sequence can be generated and read both by humans and algorithms and can be more compelx and flexible than the temporary solution with 
```ocrd process```.

Nextflow is a workflow framework that allows the integration of various scripting languages into a single cohesive pipeline. 
Nextflow also has its own Domain Specific Language (DSL) that extends Groovy (extension of Java).

We choose it due to its rich set of features:
- Stream oriented: Promotes programming approach extending Unix pipes model.
- Fast Prototyping: Lets you write a computational pipeline from smaller tasks.
- Reproducibility: Supports Docker, Singularity, and 3 other types of containers.
- Portable: Can run locally, Slurm, SGE, PBS, and cloud (Google, Kubernetes, and AWS).
- Continuous checkpoints: Each process in the workflow is checkpointed. It is possible to retry 
failed workflows and start from the last checkpoint.
- Supports various scripting languages including Bash, Python, Perl, and others.
- Enables separation between configuration (how to do) and workflow logic (what to do).
- Modularization of tasks possible via workflow, sub-workflows, and processes.
- Provides detailed logs and various types of execution reports.

## Structure of the Nextflow script
The NF script contains the following structures:

### DSL and Parameters

Example:

```
// enables a syntax extension that allows definition of module libraries
nextflow.enable.dsl=2

// pipeline parameters
params.venv = "\$HOME/venv37-ocrd/bin/activate"
params.workspace = "$projectDir/ocrd-workspace/"
params.mets = "$projectDir/ocrd-workspace/mets.xml"
params.reads = "$projectDir/ocrd-workspace/OCR-D-IMG" // The first input directory
params.outs = "$projectDir/ocrd-workspace/OCR-D-BIN"

// nextflow run <my script> --foo Hello
// Then, the parameter is accessed with: params.foo

// log pipeline parameters to the console
log.info """\
         O P E R A N D I - T E S T   P I P E L I N E 4
         ===========================================
         venv          : ${params.venv}
         ocrd-workpace : ${params.workspace}
         mets          : ${params.mets}
         reads         : ${params.reads}
         outs          : ${params.outs}
         """
         .stripIndent()
```
### Definition of processes

```
process tesserocr_deskew {
  maxForks 1
	
  input:
    path mets_file
    val input_dir
    val output_dir
	
  output:
    val output_dir
	
  script:
  """
  source "${params.venv}"
  ocrd-tesserocr-deskew -I ${input_dir} -O ${output_dir} -P operation_level page
  deactivate
  """	
}
```
### Definition of workflows

### Main workflow

```
// This is the main workflow
workflow {

  main:
    ocr_d_img = Channel.value("OCR-D-IMG")
    ocr_d_bin = Channel.value("OCR-D-BIN")
    ocr_d_crop = Channel.value("OCR-D-CROP")
    ocr_d_bin2 = Channel.value("OCR-D-BIN2")
    ocr_d_denoise = Channel.value("OCR-D-BIN-DENOISE")
    ocr_d_deskew = Channel.value("OCR-D-BIN-DENOISE-DESKEW")
    ocr_d_seg = Channel.value("OCR-D-SEG")
    ocr_d_dewarp = Channel.value("OCR-D-SEG-LINE-RESEG-DEWARP")
    ocr_d_oc = Channel.value("OCR-D-OC")
  
  
    // input_dir_ch = Channel.fromPath(params.reads, type: 'dir')
    ocropy_binarize(params.mets, ocr_d_img, ocr_d_bin)
    anybaseocr_crop(params.mets, ocropy_binarize.out, ocr_d_crop)
    skimage_binarize(params.mets, anybaseocr_crop.out, ocr_d_bin2)
    skimage_denoise(params.mets, skimage_binarize.out, ocr_d_denoise)
    tesserocr_deskew(params.mets, skimage_denoise.out, ocr_d_deskew)
    cis_ocropy_segment(params.mets, tesserocr_deskew.out, ocr_d_seg)
    cis_ocropy_dewarp(params.mets, cis_ocropy_segment.out, ocr_d_dewarp)
    calamari_recognize(params.mets, cis_ocropy_dewarp.out, ocr_d_oc)

}
```

### Code example
Check this source code example: [seq_ocrd_wf_many.nf](https://github.com/subugoe/operandi/blob/main/ExampleWorkflows/Nextflow/workflow4/seq_ocrd_wf_many.nf)
TODO: We will provide more structure-related details here based on the example above.

## For users and developers:
Detailed instructions for local executions and example Nextflow workflow scripts can be found here: [Nextflow](https://github.com/subugoe/operandi/tree/master/ExampleWorkflows/Nextflow)

### Convert the existing OCR-D process workflows we reference to NF
You can use OtoN (OCR-D to Nextflow) converter which converts basic OCR-D process workflows to Nextflow workflow scripts. Check here: [OtoN](https://github.com/MehmedGIT/OtoN_Converter)

It is still very fresh and there are still known problems (related to the produced Nextflow scripts) and we are trying to fix them. 
It is also not convenient to use (no proper CLI and no usage instructions yet). 
Stay tuned for more updates. 

Most edge cases for the lexer/parser of the OCR-D process file have been tested while implementing. 
There may be input OCR-D process files that are not handled well enough. Feel free to report any bugs, errors, or lack of errors (when an error is expected). 

The tool will probably be a part of the OCR-D software in the future when it is stable enough for general use.

### Conventions for Nextflow scrips
Try to stick to the structure provided in section [Structure of the Nextflow script](#structure-of-the-nextflow-script) when writing Nextflow scripts. 
You can also check the Nextflow examples provided in section [Main workflow](#main-workflow). 
The naming conventions for variables, function names, process names, and workflow names are encouraged to follow the snake case.

## For developers: Nextflow implementation in OCR-D related projects
The minimally used features for local runs are the parameters, processes, process decorators, and workflows.

### Parallelization

A Nextflow workflow script contains several processes. Processes are executed independently and are isolated from each other (i.e. they do not have a shared memory space). 
Communication between the processes is possible only through data channels (similar to the pipes model in Unix). These channels are basically asynchronous FIFO queues. 
Any process can define one or more channels as input and output. 
The order of interaction between these processes, and ultimately the order of workflow execution depends on the communication channel dependencies between processes. 
For example, if process A writes data to channel A and process B reads data from channel A, then Nextflow knows that process A must be executed before process B.

Check this source code example: [seq_ocrd_wf_many.nf](https://github.com/subugoe/operandi/blob/master/ExampleWorkflows/Nextflow/workflow4/seq_ocrd_wf_many.nf)

TODO: We will provide more parallelization details here based on the example above.

### Interaction with the processing server
As of Aug 2022 the processing server implementation in OCR-D/core is not yet finished, cf. https://github.com/OCR-D/core/pull/884 and https://github.com/OCR-D/core/pull/652. 
The interaction will most probably happen with curl through a bash script inside the Nextflow process. 
Of course, if it is integrated inside the OCR-D core, then no direct interactions will be needed from inside the Nextflow script.

### Interaction with the METS server
As of August, 2022, the METS server implementation is still unfinished.
The interaction will most probably happen with curl through a bash script inside the Nextflow process. 
Of course, if it is integrated inside the OCR-D core, then no direct interactions will be needed from inside the Nextflow script.
