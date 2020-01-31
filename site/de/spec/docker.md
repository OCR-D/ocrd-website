---
layout: page
lang: de
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

## Shell entrypoint

No `CMD` should be provided.

No `ENTRYPOINT` should be provided.

If `CMD` or `ENTRYPOINT` are provided, they should be empty arrays.

## `/data` as volume

The directory `/data` in the the container should be marked as a volume to
allow processing host data in the container in a uniform way.

## Example

```dockerfile
FROM ocrd:core
VOLUME ["/data"]

# RUN-commands to install requirements, build and install
# e.g.
# apt-get install -y curl

ENTRYPOINT []
```
