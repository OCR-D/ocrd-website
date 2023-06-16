---
layout: page
lang: en
lang-ref: web_api.md
toc: true
title: Web API
---

# Web API

## Terminology

* **Processing Worker**: a Processing Worker is an [OCR-D Processor](https://ocr-d.de/en/spec/glossary#ocr-d-processor)
  running as a worker, i.e. listening to the Process Queue, pulling new jobs when available, processing them, and
  pushing the updated job statuses back to the queue if necessary.
* **Workflow Server**: a Workflow Server is a server which exposes REST endpoints in the `Workflow` section of
  the [Web API specification](openapi.yml). In particular, for each `POST /workflow/{workflow-id}` request, the
  corresponding Nextflow script is executed. The script comprises a chain of call to the `POST /processor/{executable}`
  endpoint in an appropriate order.
* **Processing Server**: a Processing Server is a server which exposes REST endpoints in the `Processing` section of
  the [Web API specification](openapi.yml). In particular, for each `POST /processor/{executable}` request,
  a Processing Message is added to the respective Job Queue.
* **Process Queue**: a Process Queue is a queueing system for workflow jobs (i.e. single processor runs on one
  workspace) to be executed by Processing Workers and to be enqueued by the Workflow Server via the Processing Server.
  In our implementation, it's [RabbitMQ](https://www.rabbitmq.com/).
* **Job queue**: one or many queues in the Process Queue, which contains processing messages. Processing Workers listen
  to the job queues.
* **Result queue**: one or many queues in the Process Queue, which contains result messages. Depending on the
  configuration in the processing messages, Processing Workers might publish result messages to these queues. A
  3rd-party service can listen to these queues to get updated about the job status.
* **Processing message**: a message published to the job queue. This message contains necessary information for the
  Processing Worker to process data and perform actions after the processing has finished. These actions include `POST`
  ing the result message to the provided callback URL, or publishing the result message to the result queue. The schema
  of processing messages can be found [here](web_api/processing-message.schema.yml).
* **Result message**: a message published to the result queue. This message contains information about a job (ID,
  status, etc.). Depending on the configuration in the processing message, a result message can be `POST`ed to the
  callback URL, published to the result queue, or both. The schema for result messages can be
  found [here](web_api/result-message.schema.yml).

## Why do we need a Web API?

After having processors running locally via the [CLI](https://ocr-d.de/en/spec/cli), communication over network is the
natural extension. This feature will improve the flexibility, scalability and reliability of the system. This
specification presents ideas behind the endpoints, how to use them, and technical details happening in the background.

## The Specification

The Web API specification can be found [here](openapi.yml). It follows
the [OpenAPI specification](https://swagger.io/specification/). There are 4 parts to be implemented: discovery,
processing, workflow, and workspace.

**Discovery**: The service endpoints in this section provide information about the server. They include, but are not
limited to, hardware configuration, installed processors, and information about each processor.

**Processing**: Via the service endpoints in this section, one can get information about a
specific [processor](https://ocr-d.de/en/spec/glossary#ocr-d-processor), trigger a processor run, and check the status
of a running processor. By exposing these endpoints, the server can encapsulate the detailed setup of the system and
offer users a single entry to the processors. The implementation of this section is provided
by [OCR-D/core](https://github.com/OCR-D/core). Implementors do not need to implement it themselves, they can reuse
and/or extend the reference implementation from OCR-D/core.

**Workflow**: Beyond single processors, one can manage
entire [workflows](https://ocr-d.de/en/spec/glossary#ocr-d-workflow), i.e. a series of connected processor
instances. In this spec, a workflow amounts to a [Nextflow](https://www.nextflow.io/) script. Some information
about Nextflow and how to use it in OCR-D is documented [in the Nextflow spec](nextflow).

**Workspace**: The service endpoints in this section concern data management, which in OCR-D is handled
via [workspaces](https://ocr-d.de/en/spec/glossary#workspace). (A workspace is the combination of
a [METS](https://ocr-d.de/en/spec/mets) file and any number of referenced files already downloaded, i.e. with locations
relative to the METS file path.) Processing (via single processors or workflows) always refers to existing workspaces,
i.e. workspaces residing in the server's filesystem.

## Usage

When a system implements the Web API completely, it can be used as follows:

1. Retrieve information about the system via endpoints in the `Discovery` section.
2. Create a workspace (from an [OCRD-ZIP](https://ocr-d.de/en/spec/ocrd_zip) or METS URL) via the `POST /workspace`
   endpoint and get back a workspace ID.
3. Create a workflow by uploading a Nextflow script to the system via the `POST /workflow` endpoint and get back a
   workflow ID.
4. One can either:
    * Trigger a single processor on a workspace by calling the `POST /processor/{executable}` endpoint with the chosen
      processor name, workspace ID and parameters, or
    * Start a workflow on a workspace by calling the `POST /workflow/{workflow-id}` endpoint with the chosen workflow ID
      and workspace ID.
    * In both cases, a job ID is returned.
5. With the given job ID, it is possible to check the job status by calling:
    * `GET /processor/{executable}/{job-id}` for a single processor, or
    * `GET /workflow/{workflow-id}/{job-id}` for the workflow.
6. Download the resulting workspace via the `GET /workspace/{workspace-id}` endpoint and get back an OCRD-ZIP.
   Set the request header to `Accept: application/json` in case you only want the meta-data of the workspace but not the
   files.

## Suggested OCR-D System Architecture

There are various ways to build a system which implements this Web API. In this section, we describe a distributed
architecture, which greatly improves the scalability, flexibility, and reliability of the system compared to
the [CLI](https://ocr-d.de/en/spec/cli) and the Distributed Processor REST Calls approach.

<figure>
  <img src="/assets/web-api-distributed-queue.jpg" alt="Distributed architecture with the Web API"/>
  <figcaption align="center">
    <b>Fig. 1:</b> OCR-D System Architecture
  </figcaption>
</figure>

In this architecture, all servers are implemented using [FastAPI](https://fastapi.tiangolo.com/). Behind the scene, it
runs [Uvicorn](https://www.uvicorn.org/), an [ASGI](https://asgi.readthedocs.io/en/latest/) web server implementation
for Python. [RabbitMQ](https://www.rabbitmq.com/) is used for the Process Queue, and [MongoDB](https://www.mongodb.com/)
is the database system. There are many options for a reverse proxy, such as Nginx, Apache, or HAProxy. From our side, we
recommend using [Traefik](https://doc.traefik.io/traefik/).

### Description

As shown in Fig. 1, each section in the [Web API specification](#the-specification) is implemented by different servers,
which are Discovery Server, Processing Server, Workflow Server, and Workspace Server respectively. Although each server
in the figure is deployed on its own machine, it is completely up to the implementors to decide which machines run which
servers. However, having each processor run on its own machine reduces the risk of version and resource conflicts.
Furthermore, the machine can be customized to best fit the processor's hardware requirements and throughput demand. For
example, some processors need GPU computation, while others do not, or some need more CPU capacity while others need
more memory.

**Processing**: since the `Processing` section is provided by [OCR-D Core](https://github.com/OCR-D/core), implementors
do not need to implement Processing Server, Process Queue, and Processing Worker themselves, they can reuse/customize
the existing implementation. Once a request arrives, it will be pushed to a job queue. A job queue always has the same
name as its respective processors. For example, `ocrd-olena-binarize`processors listen only to the queue
named `ocrd-olena-binarize`. A Processing Worker, which is
an [OCR-D Processor](https://ocr-d.de/en/spec/glossary#ocr-d-processor) running as a worker, listens to the queue, pulls
new jobs when available, processes them, and push the job statuses back to the queue if necessary. One normally does not
run a Processing Worker directly, but via a Processing Server. Job statuses can be pushed back to the queue, depending
on the [job configuration](#process-queue), so that other services get updates and act accordingly.

**Database**: in this architecture, a database is required to store information such as users requests, jobs statuses,
workspaces, etc. [MongoDB](https://www.mongodb.com/) is required here.

**Network File System**: in order to avoid file transfer between different machines, it is highly recommended to have
a [Network File System (NFS)](https://en.wikipedia.org/wiki/Network_File_System) set up. With NFS, all Processing
Servers(specifically processors) can work in a shared storage environment and access files as if they are local files.
To get data into the NFS, one could use the `POST /workspace` endpoint to
upload [OCRD-ZIP](https://ocr-d.de/en/spec/ocrd_zip)files. However, this approach is only appropriate for testing or
very limited data sizes. Usually, Workspace Server should be able to pull data from other storages.

### Processing Server

The Processing Server is a server which exposes REST endpoints in the `Processing` section of
the [Web API specification](openapi.yml). In the queue-based system architecture, a Processing Server is responsible for
deployment management and enqueueing workflow jobs. For the former, a Processing Server can deploy, re-use, and shutdown
Processing Workers, Process Queue, and Database, depending on the configuration. For the latter, it decodes requests and
delegates them to the Process Queue.

To start a Processing Server, run

```shell
$ ocrd processing-server --address=<IP>:<PORT> /path/to/config.yml
```

This command starts a Processing Server on the provided IP address and port. It accepts only one argument, which is the
path to a configuration file. The schema of a configuration file can be found [here](web_api/config.schema.yml). Below
is a small example of how the file might look like.

```yaml
process_queue:
  address: localhost
  port: 5672
  credentials:
    username: admin
    password: admin
  ssh:
    username: cloud
    path_to_privkey: /path/to/file
database:
  address: localhost
  port: 27017
  credentials:
    username: admin
    password: admin
  ssh:
    username: cloud
    password: "1234"
hosts:
  - address: localhost
    username: cloud
    password: "1234"
    workers:
      - name: ocrd-cis-ocropy-binarize
        number_of_instance: 2
        deploy_type: native
      - name: ocrd-olena-binarize
        number_of_instance: 1
        deploy_type: docker

  - address: 134.76.1.1
    username: tdoan
    path_to_privkey: /path/to/file
    workers:
      - name: ocrd-eynollah-segment
        number_of_instance: 1
        deploy_type: native
```

There are three main sections in the configuration file.

1. `process_queue`: it contains the `address` and `port`, where the Process Queue was deployed, or will be deployed with
   the specified `credentials`. If the `ssh` property is presented, the Processing Server will try to connect to
   the `address` via `ssh` with provided `username` and `password` and deploy [RabbitMQ](https://www.rabbitmq.com/) at
   the specified `port`. The remote machine must have [Docker](https://www.docker.com/) installed since the deployment
   is done via Docker. Make sure that the provided `username` has enough rights to run Docker commands. In case
   the `ssh` property is not presented, the Processing Server assumes that RabbitMQ was already deployed and just uses
   it.
2. `database`: this section also contains the `address` and `port`, where the [MongoDB](https://www.mongodb.com/) is
   running, or will run. If `credentials` is presented, it will be used when deploying and connecting to the database.
   The `ssh` section behaves exactly the same as described in the `process_queue` section above.
3. `hosts`: this section contains a list of hosts, usually virtual machines, where Processing Workers should be
   deployed. To be able to connect to a host, an `address` and `username` are required, then comes either `password`
   or `path_to_privkey` (path to a private key). All Processing Workers, which will be deployed, must be declared under
   the `workers` property. In case `deploy_type` is `docker`, make sure that [Docker](https://www.docker.com/) is
   installed in the target machine and the provided `username` has enough rights to execute Docker commands.

Among three sections, only the `process_queue` is required. However, if `hosts` is present, `database` must be there
as well. For more information, please check the [configuration file schema](web_api/config.schema.yml).

### Process Queue

By using a queuing system for individual per-workspace per-job processor runs, specifically as message queueing
with [RabbitMQ](https://www.rabbitmq.com/), the reliability and flexibility of the Processing Server are greatly
improved over a system directly coupling the workflow engine and distributed processor instances.

In our implementation of the Process Queue, manual acknowledgement mode is used. This means, when a Processing Worker
finishes successfully, it sends a positive ACK signal to RabbitMQ. In case of failure, it tries again three times before
sending a negative ACK signal. When a negative signal is received, RabbitMQ will re-queue the message. If there is not
any ACK signal sent for any reason (e.g. consumer crash, power outage, network problem, etc.), RabbitMQ will
automatically re-queue the message after timeout, which is 30 minutes by default. This behavior, however, can
be [overridden](https://www.rabbitmq.com/consumers.html#acknowledgement-timeout) by setting another value for
the `consumer_timeout` property in the [`rabbitmq.conf`](https://www.rabbitmq.com/configure.html#config-file) file.

To avoid processing the same input twice (in case of re-queuing), a Processing Worker first checks
the [`redeliver`](https://www.rabbitmq.com/confirms.html#automatic-requeueing) property to see if this message was
re-queued. If yes, and the status of this process in the database is not `SUCCESS`, it will process the data described
in the message again.

When a Processing Server receives a request, it creates a message based on the request content, then push it to a
job queue. A job queue always has the same name as its respective processors. For
example, `ocrd-olena-binarize` processors listen only to the job queue named `ocrd-olena-binarize`. Below is an example
of how a message looks like. For a detailed schema, please check
the [message schema](web_api/processing-message.schema.yml).

```yaml
job_id: uuid
processor_name: ocrd-cis-ocropy-binarize

path_to_mets: /path/to/mets.xml
input_file_grps:
  - OCR-D-DEFAULT
output_file_grps:
  - OCR-D-BIN
page_id: PHYS_001,PHYS_002
parameters:
  params_1: 1
  params_2: 2

result_queue_name: ocrd-cis-ocropy-binarize-result
callback_url: https://my.domain.com/callback

created_time: 1668782988590
```

In the message content, `job_id`, `processor_name`, and `created_time` are added by the Processing Server, while the
rest comes from the body of the `POST /processor/{executable}` request.

Instead of `path_to_mets`, one can also use `workspace_id` to specify a workspace. An ID of a workspace can be obtained
from the Workspace Server.

In case `result_queue_name` property is presented, the result of the processing will be pushed to the queue with the
provided name. If the queue does not exist yet, it will be created on the fly. This is useful when there is another
service waiting for the results of processing. That service can simply listen to that queue and will be immediately
notified when the results are available. Below is a simple Python script to demonstrate how a service can listen to
the `result_queue_name` and act accordingly.

```python
import pika, sys, os

def main():
    credentials = pika.PlainCredentials('username', 'password')
    connection = pika.BlockingConnection(pika.ConnectionParameters(host='my.domain.name', port=5672, credentials=credentials))
    channel = connection.channel()

    # Create the result queue, in case it does not exist yet
    result_queue_name = 'ocrd-cis-ocropy-binarize-result'
    channel.queue_declare(queue=result_queue_name)

    def callback(ch, method, properties, body):
        print(' [x] Received %r' % body)

    channel.basic_consume(queue=result_queue_name, on_message_callback=callback, auto_ack=True)

    print(' [*] Waiting for job results.)
    channel.start_consuming()
```

It is important that the result queue exists before one starts listening on it, otherwise an error is thrown. The best
way to ensure this is trying to create the result queue in the listener service, as shown in the Python script above. In
RabbitMQ, this action is idempotent, which means that the creation only happens if the queue doesn't exist yet,
otherwise nothing will happen. For more information, please check
the [RabbitMQ tutorials](https://www.rabbitmq.com/getstarted.html).

If the `callback_url` in the processing message is set, a `POST` request will be made to the provided endpoint when the
processing is finished. The body of the request is the result message described below.

The schema for result messages can be found [here](web_api/result-message.schema.yml). This message is sent to the
callback URL or to the result queue, depending on the configuration in the processing message. An example of the message
looks like this:

```yaml
job_id: uuid
status: SUCCESS
path_to_mets: /path/to/mets.xml
```

With the returned `job_id`, one can retrieve more information by sending a `GET` request to
the `/processor/{executable}/{job_id}` endpoint, or to `/processor/{executable}/{job_id}/log` to get all logs of that
job.

### Processing Worker

There is normally no need to start (or stop) a Processing Worker manually, since it can be managed by a Processing
Server via a [configuration file](#processing-server). However, if it is necessary to do so, there are two ways to start
a Processing Worker:

```shell
# 1. Use ocrd CLI bundled with OCR-D/core
$ ocrd server <processor-name> --type=worker --queue=<queue-address> --database=<database-address>

# 2. Use processor name
$ <processor-name> --server --type=worker --queue=<queue-address> --database=<database-address>
```

* `--queue`: a [Rabbit MQ connection string](https://www.rabbitmq.com/uri-spec.html) to a running instance.
* `--database`: a [MongoDB connection string](https://www.mongodb.com/docs/manual/reference/connection-string/) to a
  running instance.

### Database

A database is required to store necessary information such as users requests, jobs statuses, workspaces,
etc. [MongoDB](https://www.mongodb.com/) is used in this case. To connect to MongoDB via a Graphical User
Interface, [MongoDB Compass](https://www.mongodb.com/products/compass) is recommended.

When a Processing Worker connects to the database for the first time, it will create a database called `ocrd`.
For collections, each processor creates and works on a collection with the same name as its own. For example,
all `ocrd-olena-binarize` processors will read and write to the `ocrd-olena-binarize` collection only.
