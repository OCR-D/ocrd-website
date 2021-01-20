---
layout: page
lang: en
lang-ref: faq
toc: true
---

# Models for OCR-D processors

OCR engines rely on pre-trained models for their recognition. Every engine has
its own internal format(s) for models. Some support central storage of models
at a specific location (tesseract, ocropy, kraken) while others require the full
path to a model (calamari).

Since [v2.22.0](https://github.com/OCR-D/core/releases/v2.22.0), OCR-D/core
comes with a framework for managing processor resources uniformly. This means
that processors can delegate to OCR-D/core to resolve specific file resources by name,
looking in well-defined places in the filesystem. This also includes downloading and caching
file parameters passed as a URL. Furthermore, OCR-D/core comes with a bundled database
of known resources, such as models, dictionaries, configurations and other
processor-specific data files. This means that OCR-D users should be able to
concentrate on fine-tuning their OCR workflows and not bother with implementation
details like "where do I get models from and where do I put them".

All of the above mentioned functionality can be accessed using the `ocrd
resmgr` command line tool.

## What models are available?

To get a list of the resources that the OCR-D/core [is aware
of](https://github.com/OCR-D/core/blob/master/ocrd/ocrd/resource_list.yml):

```
ocrd resmgr list-available
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

As you can see, resources are grouped by the processor they are used by.

The word after the list symbol, e.g. `qurator-gt4hist-0.3`,
`LatinHist.pyrnn.gz`, define the "name" of the resource, a shorthand you can
use in parameters without having to specify the full URL (in brackets after the
name).

The second line of each entry contains a short description of the resource.

## Installing known resources

You can install resources with the `ocrd resmgr download` command. It expects
the name of the processor as the first argument and either the name or URL of a
resource as a second argument.

Likewise, model distribution is not currently centralised within OCR-D though we
are working towards a central model repository.

For example, to install the `LatinHist.pyrnn.gz` resource for `ocrd-cis-ocropy-recognize`:

```
ocrd resmgr download ocrd-cis-ocropy-recognize LatinHist.pyrnn.gz
# or
ocrd resmgr download ocrd-cis-ocropy-recognize https://github.com/chreul/OCR_Testdata_EarlyPrintedBooks/raw/master/LatinHist-98000.pyrnn.gz
```

This will look up the resource in the [bundled resource and user databases](#user-database), download,
unarchive (where applicable) and store it in the [proper location](#where-is-the-data).


**NOTE:** The special name `*` can be used instead of a resource name/url to
download *all* known resources for this processor. To download all tesseract models:

```sh
ocrd resmgr download ocrd-tesserocr-recognize '*'
```

(Note that `*` must be in quotes or escaped because of shell wildcard expansion)

## Installing unknown resources

If you need to install a resource that OCR-D doesn't know of, than can be achieved with the `--any-url/-n` flag to `ocrd resmgr download`:

To install a model for `ocrd-tesserocr-recognize` that is located at `https://my-server/mymodel.traineddata`.

```
ocrd resmgr download -n ocrd-tesserocr-recognize https://my-server/mymodel.traineddata
```

This will download and store the resource in the [proper location](#where-is-the-data) and create a stub entry in the
[user database](#user-database).  You can then use it as the parameter value for the `model` parameter:

```
ocrd-tesserocr-recognize -P model mymodel
```

## List installed resources

The `ocrd resmgr list-installed` command has the same output format as `ocrd resmgr list-available` but instead
of the database, it scans the filesystem locations [where data is searched](#where-is-the-data) for existing
resources and lists URL and description if a database entry exists.

## User database

Whenever the OCR-D/core resource manager encounters an unknown resource in the filesystem or when you install
a resource with `ocrd resmgr download`, it will create a new stub entry in the user database, which is found at
`$HOME/.config/ocrd/resources.yml` and created if it doesn't exist.

This allows you to use the OCR-D/core resource manager mechanics, including
lookup of known resources by name or URL, without relying (only) on the
database maintained by the OCR-D/core developers.

**NOTE:** If you produced or found resources that are interesting for the wider
OCR(-D) community, please tell us in the [OCR-D gitter
chat](https://gitter.im/OCR-D/Lobby) so we can add it to the database.

## Where is the data

The lookup algorithm is [defined in our specifications](https://ocr-d.de/en/spec/ocrd_tool#file-parameters)

In order of preference, a resource `<name>` for a processor `ocrd-foo` is searched at:

* `$VIRTUAL_ENV/share/ocrd-resources/ocrd-foo/<name>`
* `$HOME/.config/ocrd-resources/ocrd-foo/<name>`
* `$HOME/.local/share/ocrd-resources/ocrd-foo/<name>`
* `$HOME/.cache/ocrd-resources/ocrd-foo/<name>`
* `$PWD/ocrd-resources/ocrd-foo/<name>`

We recommend using the `$VIRTUAL_ENV` location, which is also the default. But
you can override the location to store data with the `--location` option, which can
be `cwd`, `virtualenv`, `config`, `data` and `cache` resp.

```sh
# will download to $PWD/ocrd-resources/ocrd-anybaseocr-dewarp/latest_net_G.pth
ocrd resmgr download --location cwd ocrd-anybaseocr-dewarp latest_net_G.pth
# will download to $HOME.cache/ocrd-resources/ocrd-anybaseocr-dewarp/latest_net_G.pth
ocrd resmgr download --location cache ocrd-anybaseocr-dewarp latest_net_G.pth
```

## Changing the default resource directory

The `$VIRTUAL_ENV` default location is reasonable because we heavily advertise
using virtual environments and is compatible with
[ocrd_all](https://github.com/OCR-D/ocrd_all).

However, there are use cases where the `config`/`data/`/`cache` or even the
`cwd` option should be the default (or only) location to store resources and
resolve file parameters.

To change the default location, adapt the `$HOME/.config/ocrd/config.yml` file
(it is created if it doesn't exist whenever you execute `ocrd resmgr`) which
has a `resource_location` key that accepts the same range of values as the
`ocrd resmgr --location` command line flag.


## Notes on specific processors

## Ocropy / ocrd_cis

An Ocropy model is simply the neural network serialized with Python's pickle
mechanism and is generally distributed in a gzipped form, with a `.pyrnn.gz`
extension and can be used as such, no need to unarchive.

To use a specific model with OCR-D's ocropus wrapper in
[ocrd_cis](https://github.com/cisocrgroup/ocrd_cis) and more specifically, the
`ocrd-cis-ocropy-recognize` processor, use the `model` parameter:

```sh
# Model will be downloaded on-demand if it is not locally available yet
ocrd-cis-ocropy-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-OCRO -P model fraktur-jze.pyrnn.gz
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
# or, to be able to control which checkpoints to use:
ocrd-calamari-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-CALA -P checkpoint '/path/to/modeldir/*.ckpt.json'
```

## Tesseract / ocrd_tesserocr

Tesseract models are single files with a `.traineddata` extension.

Since tesseract only supports model lookup in a single directory, models should
only be stored in a single location. If the default location (`virtualenv`) is
not the place you want to use for tesseract models, consider [changing the default location
in the OCR-D config file](#changing-the-default-resource-directory).

**NOTE:** For reasons of effiency and to avoid duplicate models, all `ocrd-tesserocr-*` processors
reuse the resource directory for `ocrd-tesserocr-recognize`.

If the `TESSDATA_PREFIX` environemnt variable is set when any of the tesseract processors
are called, it will be the location to look for resources instead of the default.

OCR-D's Tesseract wrapper,
[ocrd_tesserocr](https://github.com/OCR-D/ocrd_tesserocr) and more
specifically, the `ocrd-tesserocr-recognize` processor, expects the name of the
model(s) to be provided as the `model` parameter. Multiple models can be
combined by concatenating with `+` (which generally improves accuracy but always slows processing):

```sh
# Use the deu and frk models
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS -P model 'deut+frk'
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
