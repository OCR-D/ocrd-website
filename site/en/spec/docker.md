---
layout: page
lang: en
lang-ref: docker.md
toc: true
---

# Dockerfile provided by MP

MP should provide a
[Dockerfile](https://docs.docker.com/engine/reference/builder/) that should
result in a container which bundles the [tools developed by the MP](cli) along
with all requirements.

## Based on ocrd:core

Docker containers should be based on the [ocrd base
image](https://hub.docker.com/r/ocrd/core/) which itself is based on Ubuntu
18.04. For one, this allows MP to use the `ocrd` tool to handle recurrent tasks
in a spec-conformant way. Besides, it locally installed and containerized
[CLI](cli) interchangeable.

## Naming images

Image tags MUST be the same as the project name but with underscore (`_`)
replaced with forward slash (`/`).

Examples:

| project name                                                | docker tag                                                  |
| ---                                                         | ---                                                         |
| [`ocrd_tesserocr`](https://github.com/OCR-D/ocrd_tesserocr) | [`ocrd/tesserocr`](https://hub.docker.com/r/ocrd/tesserocr) |
| [`ocrd_calamari`](https://github.com/OCR-D/ocrd_calamari)   | [`ocrd/calamari`](https://hub.docker.com/r/ocrd/calamari)   |
| [`ocrd_olena`](https://github.com/OCR-D/ocrd_olena)         | [`ocrd/olena`](https://hub.docker.com/r/ocrd/olena)         |

## Labelling images

The Dockerfile MUST accept build args `VCS_REF` and `BUILD_DATE`.

`VCS_REF` contains the short id of the latest commit this image was built upon.

`BUILD_DATE` contains an ISO-8601 date.

From these build args, the image shall be labelled with this command:

```dockerfile
LABEL \
    maintainer="https://github.com/YOUR/PROJECT/issues" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/YOUR/PROJECT" \
    org.label-schema.build-date=$BUILD_DATE
```

`maintainer` and `org.label-schema.cvs-url` shall point to the issues and
landing page of the GitHub project resp.

## Shell entrypoint

No `CMD` should be provided.

No `ENTRYPOINT` should be provided.

If `CMD` or `ENTRYPOINT` are provided, they should be empty arrays.

## `/data` as volume

The directory `/data` in the the container should be marked as a volume to
allow processing host data in the container in a uniform way.

## Example

### `Dockerfile`

```dockerfile
FROM ocrd:core
VOLUME ["/data"]
ARG VCS_REF
ARG BUILD_DATE
LABEL \
    maintainer="https://github.com/bar/ocrd_foo/issues" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/bar/ocrd_foo" \
    org.label-schema.build-date=$BUILD_DATE

# RUN-commands to install requirements, build and install
# e.g.
# apt-get install -y curl

ENTRYPOINT []
```

### Command to build docker image

```sh
docker build \
  -t 'ocrd/foo' \
	--build-arg VCS_REF=$(git rev-parse --short HEAD) \
	--build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
```
