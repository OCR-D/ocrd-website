---
layout: page
lang: en
lang-ref: api.md
toc: true
title: Web API
---

# Web API

## What the Web API is

## Why we need a Web API

The Web API is an important increment for implementers to be able to base their outward-facing HTTP 
interfaces on a common API definition, so that the different implementations are interoperable on this level.

## Basic Architecture

# Workflows

## What is NF and why did we choose it?

Nextflow is a workflow framework that allows the integration of various scripting languages into a single cohesive pipeline. Nextflow also has its own Domain Specific Language (DSL) that extends Groovy (extension of Java).

We choose it due to its rich set of features:
- Stream oriented: Promotes programming approach extending Unix pipes model.
- Fast Prototyping: Let’s you write a computational pipeline from smaller tasks.
- Reproducibility: Supports Docker, Singularity, and 3 other types of containers.
- Portable: Can run locally, Slurm, SGE, PBS, and cloud (Google, Kubernetes, and AWS).
- Continuous checkpoints: Each process in the workflow is checkpointed. It is possible to retry 
failed workflows and start from the last checkpoint.
- Supports various scripting languages including Bash, Python, Perl, and others.
- Enables separation between configuration (how to do) and workflow logic (what to do).
- Modularization of tasks possible via workflow, sub-workflows, and processes.
- Provides detailed logs and various types of execution reports.

## How is the NF script structured?

The NF script contains the following structures:
### DSL and Parameters
### Definition of processes
### Definition of workflows
### Main workflow

Check this source code example: [seq_ocrd_wf_many.nf](https://github.com/MehmedGIT/OPERANDI_TestRepo/blob/master/ExampleWorkflows/Nextflow/workflow4/seq_ocrd_wf_many.nf)

## Which features of NF do we use, i.e. what features have to be implemented in potential implementations?
The minimally used features for local runs are the parameters, processes, process decorators, and workflows.

## How does parallelization work, both within works and across works?

A Nextflow workflow script contains several processes. Processes are executed independently and are isolated from each other (i.e. they do not have a shared memory space). 
Communication between the processes is possible only through data channels (similar to the pipes model in Unix). These channels are basically asynchronous FIFO queues. 
Any process can define one or more channels as input and output. 
The order of interaction between these processes, and ultimately the order of workflow execution depends on the communication channel dependencies between processes. 
For example, if process A writes data to channel A and process B reads data from channel A, then Nextflow knows that process A must be executed before process B.

Check this source code example: [seq_ocrd_wf_many.nf](https://github.com/MehmedGIT/OPERANDI_TestRepo/blob/master/ExampleWorkflows/Nextflow/workflow4/seq_ocrd_wf_many.nf)

## How does the NF script interact with the processing server?
There is still no running processing server. More details will be announced once there is more to talk about. The interaction will most probably happen with curl through a bash script inside the Nextflow process. Of course, if it is integrated inside the OCR-D core, then no direct interactions will be needed from inside the Nextflow script.

## How does the NF script interact with the METS server?
There is still no running METS server. More details will be announced once there is more to talk about. The interaction will most probably happen with curl through a bash script inside the Nextflow process. Of course, if it is integrated inside the OCR-D core, then no direct interactions will be needed from inside the Nextflow script.

## How to convert the existing OCR-D process workflows we reference to NF?
The OtoN (OCR-D to Nextflow) converter converts basic OCR-D process workflows to Nextflow workflow scripts. Check here: [OtoN](https://github.com/MehmedGIT/OtoN_Converter)

There may be input OCR-D process files that are not handled well enough. Feel free to report any bugs, errors, or lack of errors (when an error is expected). 

The tool will probably be a part of the OCR-D software in the future when it is stable enough for general use.

## How should NF scripts be written, tested, deployed, and evaluated?
Depends on the use case. Detailed instructions for local executions and example Nextflow workflow scripts can be found here: [Nextflow](https://github.com/MehmedGIT/OPERANDI_TestRepo/tree/master/ExampleWorkflows/Nextflow)

## What conventions do we encourage, naming, structure, documentation, etc.?
Try to stick to the structure provided in point 2 when writing Nextflow scripts. You can also check the Nextflow examples provided in point 8. The naming conventions for variables, function names, process names, and workflow names are encouraged to follow the snake case. I will provide further answers to any following questions related to this main question.

