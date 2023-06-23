---
layout: page
lang: en
lang-ref: models
toc: true
title: Models for OCR-D processors
---

# Models for OCR-D processors

OCR engines rely on pre-trained models for their recognition. Every engine has
its own internal format(s) for models. Some support central storage of models
at a specific location (Tesseract, Ocropy, Kraken) while others require the full
path to a model (Calamari).

Moreover, many processors provide other file resources like configuration files or presets.

Since [v2.22.0](https://github.com/OCR-D/core/releases/v2.22.0), OCR-D/core
comes with a framework for managing **file resources** uniformly. This means
that processors can delegate to OCR-D/core to resolve specific file resources by name,
looking in well-defined places in the filesystem. This also includes downloading and caching
file parameters passed as a URL. Furthermore, OCR-D/core comes with a bundled database
of known resources, such as models, dictionaries, configurations and other
processor-specific data files. Processors can add their own specifications to that.

This means that OCR-D users should be able to concentrate on fine-tuning their OCR workflows
and not bother with implementation details like "where do I get models from and where do I put them".
In particular, users can reference file parameters by name now.

All of the above mentioned functionality can be accessed using the `ocrd resmgr` command line tool.

## What models are available?

To get a list of the (available or installed) file resources that OCR-D/core
[is aware of](https://github.com/OCR-D/core/blob/master/ocrd/ocrd/resource_list.yml):

```
ocrd resmgr list-available
# alternatively, using Docker:
docker run --volume ocrd-models:/models -- ocrd/all:maximum ocrd resmgr list-available
```

The output will look similar to this:

```
ocrd-calamari-recognize
- qurator-gt4hist-0.3 (https://qurator-data.de/calamari-models/GT4HistOCR/2019-07-22T15_49+0200/model.tar.xz)
  Calamari model trained with GT4HistOCR
- qurator-gt4hist-1.0 (https://qurator-data.de/calamari-models/GT4HistOCR/2019-12-11T11_10+0100/model.tar.xz)
  Calamari model trained with GT4HistOCR

ocrd-cis-ocropy-recognize
- LatinHist.pyrnn.gz (https://github.com/chreul/OCR_Testdata_EarlyPrintedBooks/raw/master/LatinHist-98000.pyrnn.gz)
  ocropy historical latin model by github.com/chreul
```

As you can see, resources are grouped by the processors which make use of them.

The word after the list symbol, e.g. `qurator-gt4hist-0.3`,
`LatinHist.pyrnn.gz`, defines the _name_ of the resource, which is a shorthand you can
use in parameters without having to specify the full URL (in brackets after the
name).

The second line of each entry contains a short description of the resource.

## Installing resources

On installing resources in OCR-D, read the follow-up sections
[Installing known resources](#installing-known-resources) and
[Installing unknown resources](#installing-unknown-resources).

*Known* resources are resources that are provided by processor developers [in the `ocrd-tool.json`](/en/spec/ocrd_tool#file-parameters)
and are available by name to `ocrd resmgr download`. 

*Unknown* resources, in contrast, are models, configurations, parameter sets etc. that you provide yourself
or found elsewhere on the Internet, which require passing a URL (or local path) to `ocrd resmgr download`.

**If you installed OCR-D via Docker,** read the section [Models and Docker](#models-and-docker) *additionally*. 

### Installing known resources

You can install resources with the `ocrd resmgr download` command. It expects
the name of the processor as the 1st argument and the name of a resource as a 2nd argument.

Since model distribution is decentralised within OCR-D, every processor can advertise its
own known resources, which the resource manager then picks up.

For example, to install the `LatinHist.pyrnn.gz` resource for `ocrd-cis-ocropy-recognize`:

```
ocrd resmgr download ocrd-cis-ocropy-recognize LatinHist.pyrnn.gz
```

This will look up the resource in the [bundled resource and user databases](#user-database), download,
unarchive (where applicable) and store it in the [proper location](#where-is-the-data).


> **NOTE:** The special name `*` can be used instead of a resource name/url to
> download *all* known resources for this processor. To download all tesseract models:

```sh
ocrd resmgr download ocrd-tesserocr-recognize '*'
```

> **NOTE:** Equally, the special processor `*` can be used instead of a processor and a resource
> to download *all* known resources for *all* installed processors:

```sh
ocrd resmgr download '*'
```

> (In either case, `*` must be in quotes or escaped to avoid wildcard expansion by the shell.)

### Installing unknown resources

If you need to install a resource which OCR-D does not know of, that can be achieved by passing
its URL in combination with the `--any-url/-n` flag to `ocrd resmgr download`.

For example, to install the same model for `ocrd-cis-ocropy-recognize` as above:

```
ocrd resmgr download -n https://github.com/chreul/OCR_Testdata_EarlyPrintedBooks/raw/master/LatinHist-98000.pyrnn.gz ocrd-cis-ocropy-recognize LatinHist.pyrnn.gz
```

Or to install a model for `ocrd-tesserocr-recognize` that is located at `https://my-server/mymodel.traineddata`:

```
ocrd resmgr download -n https://my-server/mymodel.traineddata ocrd-tesserocr-recognize mymodel.traineddata
```

This will download and store the resource in the [proper location](#where-is-the-data) and create a stub entry in the
[user database](#user-database).  You can then use it as the parameter value for the `model` parameter:

```
ocrd-tesserocr-recognize -P model mymodel
```

### Models and Docker

If you are using OCR-D with Docker, we recommend keeping all downloaded resources **persistently**
in a host directory, independent of both:
- the Docker container's internal storage (which is transient, i.e. any change over the image
  gets lost with each new `docker run`),
- the host's data directory (which may be on a different filesystem).
 
That resource directory needs to be mounted into a specific path in the container, as does the data directory:
- `/models`: resource files (to be mounted as a **named volume**, e.g. `-v ocrd-models:/models`),
- `/data`: input/output files (to be mounted any way you like, probably a **bind mount**, e.g. `-v $PWD:/data`),
- `/tmp`: temporary files (ideally as **tmpfs**, e.g. `--tmpfs /tmp`)

Initially, (if you use a named volume, not a bind mount,) the host resource directory will contain only
those resources that have been **pre-installed** into the processors' module directories. Each time you run
the Docker container, the Resource Manager and the processors will access that directory from the inside
to resolve resources, so you can **download additional** models into that location using `ocrd resmgr`, and
later **use them** in workflows.

The following will assume (without loss of generality) that your host-side data
path is under `./data`, and the host-side volume is called `ocrd-models`:

To download models to `ocrd-models` in the host FS and `/models` in the container FS:

```sh
docker run --user $(id -u) \
  --volume ocrd-models:/models \
ocrd/all \
ocrd resmgr download ocrd-tesserocr-recognize eng.traineddata\; \
ocrd resmgr download ocrd-calamari-recognize default\; \
...
```

To run processors, then as usual do:

```sh
docker run --user $(id -u) \
  --tmpfs /tmp \
  --volume $PWD/data:/data \
  --volume ocrd-models:/models \
  ocrd/all ocrd-tesserocr-recognize -I IN -O OUT -P model eng
```

This principle applies to all `ocrd/*` Docker images, e.g. you can replace `ocrd/all` above with `ocrd/tesserocr` as well.

## List installed resources

The `ocrd resmgr list-installed` command has the same output format as `ocrd resmgr list-available`. But instead
of the database, it scans the filesystem locations [where data is searched](#where-is-the-data) for existing
resources and lists URL and description if a database entry exists.

## User database

Whenever the OCR-D/core resource manager encounters an unknown resource in the filesystem, or when you install
a resource with `ocrd resmgr download`, it will add a new stub entry in the user database, which is found at
`$XDG_CONFIG_HOME/ocrd/resources.yml` (where `$XDG_CONFIG_HOME` defaults to `$HOME/.config` if unset) and
gets created if it does not exist.

This allows you to use the OCR-D/core resource manager mechanics, including
lookup of known resources by name or URL, without relying (only) on the
database maintained by the OCR-D/core developers.

> **NOTE:** If you produced or found resources that are interesting for the wider
> OCR(-D) community, please tell us in the [OCR-D gitter chat](https://gitter.im/OCR-D/Lobby)
> or open an issue in the respective Github repository, so we can add it to the database.

## Where is the data

The lookup algorithm is [defined in our specifications](https://ocr-d.de/en/spec/ocrd_tool#file-parameters)

In order of preference, a resource `<name>` for a processor `ocrd-foo` is searched at:

* `$PWD/<name>`
* `$XDG_DATA_HOME/ocrd-resources/ocrd-foo/<name>`
* `/usr/local/share/ocrd-resources/ocrd-foo/<name>`  
* `$VIRTUAL_ENV/lib/python3.6/site-packages/ocrd-foo/<name>` or `$VIRTUAL_ENV/share/ocrd-foo/<name>`  
   (or whatever the processor's internal module location is)

(where `$XDG_DATA_HOME` defaults to `$HOME/.local/share` if unset).

We recommend using the `$XDG_DATA_HOME` location, which is also the default. But
you can override the location to store data with the `--location` option, which can
be `cwd`, `data`, `system` and `module` resp.

In Docker though, `$XDG_CONFIG_HOME=$XDG_DATA_HOME/ocrd-resources=/usr/local/share/ocrd-resources` 
gets symlinked to `/models` for easier volume handling (and persistency).

```sh
# will download to $PWD/latest_net_G.pth
ocrd resmgr download --location cwd ocrd-anybaseocr-dewarp latest_net_G.pth
# will download to /usr/local/share/ocrd-resources/ocrd-anybaseocr-dewarp/latest_net_G.pth
ocrd resmgr download --location system ocrd-anybaseocr-dewarp latest_net_G.pth
```

## Changing the default resource directory

The `$XDG_DATA_HOME` default location is reasonable because
models are usually large files which should persist across different deployments,
both native and containerized, both single-module and [ocrd_all](https://github.com/OCR-D/ocrd_all).
Moreover, that variable can easily be overridden during installation.

However, there are use cases where `system` or even `cwd` should be
used as location to store resources, hence the `--location` option.

## Notes on specific processors

## Ocropy / ocrd_cis

An Ocropy model is simply the neural network serialized with Python's pickle
mechanism and is generally distributed in a gzipped form, with a `.pyrnn.gz`
extension and can be used as such, no need to unarchive.

To use a specific model with OCR-D's ocropus wrapper in
[ocrd_cis](https://github.com/cisocrgroup/ocrd_cis) and more specifically, the
`ocrd-cis-ocropy-recognize` processor, use the `model` parameter:

```sh
ocrd-cis-ocropy-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-OCRO -P model fraktur-jze.pyrnn.gz
```

**NOTE:** Model must be downloade before with

```sh
ocrd resmgr download ocrd-cis-ocropy-recognize fraktur-jze.pyrnn.gz
```

## Calamari / ocrd_calamari

Calamari models are Tensorflow model directories. For distribution, this
directory is usually packed to a tarball or ZIP file. Once downloaded, these
containers must be unpacked to a directory again. `ocrd resmgr` handles this
for you, so you just need the name of the resource in the database.

The Calamari-OCR project also maintains a [repository of models](https://github.com/Calamari-OCR/calamari_models).

To use a specific model with OCR-D's calamari wrapper
[ocrd_calamari](https://github.com/OCR-D/ocrd_calamari) and more specifically,
the `ocrd-calamari-recognize` processor, use the `checkpoint_dir` parameter:

```sh
# To use the "default" model, i.e. the one trained on GT4HistOCR by QURATOR
ocrd-calamari-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-CALA
# To use your own trained model
ocrd-calamari-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-CALA -P checkpoint_dir /path/to/modeldir
```

## Tesseract / ocrd_tesserocr

Tesseract models are single files with a `.traineddata` extension.

Since Tesseract only supports model lookup in a single directory, 
and we want to share the tessdata directory with the standalone CLI,
`ocrd_tesserocr` resources must be stored in the `module` location.
If the default path of that location is not the place you want to use for Tesseract models,
then either recompile Tesseract with the `tessdata` path you had in mind,
or use the `TESSDATA_PREFIX` environment variable to override the `module` location at runtime.

**NOTE**: For reasons of efficiency and to avoid duplicate models, all `ocrd-tesserocr-*` processors
re-use the resource directory for `ocrd-tesserocr-recognize`.

OCR-D's Tesseract wrapper,
[ocrd_tesserocr](https://github.com/OCR-D/ocrd_tesserocr) and more
specifically, the `ocrd-tesserocr-recognize` processor, expects the name of the
model(s) to be provided as the `model` parameter. Multiple models can be
combined by concatenating with `+` (which generally improves accuracy but always slows processing):

```sh
# Use the deu and frk models
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS -P model 'deu+frk'
# Use the Fraktur model
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS -P Fraktur
```


# Model training

With the pretrained models mentioned above, good results can be obtained for many originals. Nevertheless, the
recognition rate can usually be improved significantly by fine-tuning an existing model or even training a new
model on your own particular originals. 

## Tesstrain

For training Tesseract models, [`tesstrain`](https://github.com/tesseract-ocr/tesstrain) can be used. As it is
not included in `ocrd_all`, you will still have to install it, first. For information on the setup and the 
training process itself see the [Readme](https://github.com/tesseract-ocr/tesstrain) in the GithHub Repository.

## okralact

While `tesstrain` only allows you to train models for Tesseract, with [`okralact`](https://github.com/OCR-D/okralact)
you can train models for four engines compatible with OCR-D - namely Tesseract, Ocropus, Kraken and Calamari - at once. 
Especially if you want to use several OCR engines for your workflows or are not sure which OCR engine will give you the best
results, this might be particularly effective for you. Just like `tesstrain` it is not included in `ocrd_all`, meaning 
you will still have to install it, first. For information on the setup and the training process itself see the
[Readme](https://github.com/OCR-D/okralact) in the GithHub Repository.

# Further reading

If you just installed OCR-D and want to know how to process your own data, please see the [user guide](/en/user_guide).
