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

Likewise, model distribution is not currently centralised within OCR-D though we
are working towards a central model repository.

In the meantime, this guide will show you, for each OCR engine:

  * which types of models are supported
  * where to store models locally
  * which currently available models we recommend
  * how to invoke the resp. OCR-D wrapper for the engine with a specific model

## Tesseract / ocrd_tesserocr

Tesseract models are single files with a `.traineddata` extension.

Tesseract expects models to be in a directory `tessdata` within what Tesseract
calls `TESSDATA_PREFIX`. When installing Tesseract from Ubuntu packages, that
location is `/usr/share/tesseract-ocr/4.00/tessdata`. When building from source
using [ocrd_all](htttps://github.com/OCR-D/ocrd_all), the models are searched
at `/path/to/ocrd_all/venv/share/tessdata`. If you want to override the
locations, you can set the `TESSDATA_PREFIX` environment variable, e.g. if you
want the models location to be `$HOME/tessdata`, you can by adding to your
`$HOME/.bashrc`: `export TESSDATA_PREFIX=$HOME`.

We recommend you download the following models, either by downloading and
saving to the right location or by running `make install-models-tesseract` when
using `ocrd_all`:

  * [equ](https://github.com/tesseract-ocr/tessdata_fast/raw/master/equ.traineddata)
  * [osd](https://github.com/tesseract-ocr/tessdata_fast/raw/master/osd.traineddata)
  * [eng](https://github.com/tesseract-ocr/tessdata_fast/raw/master/eng.traineddata)
  * [deu](https://github.com/tesseract-ocr/tessdata_fast/raw/master/deu.traineddata)
  * [frk](https://github.com/tesseract-ocr/tessdata_fast/raw/master/frk.traineddata)
  * [script/Latin](https://github.com/tesseract-ocr/tessdata_fast/raw/master/script/Latin.traineddata)
  * [script/Fraktur](https://github.com/tesseract-ocr/tessdata_fast/raw/master/script/Fraktur.traineddata)
  * [@stweil's GT4HistOCR model](https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/Fraktur_5000000/tessdata_fast/Fraktur_50000000.334_450937.traineddata)

If you installed Tesseract with Ubuntu's `apt` package manager, you may want to install
standard models like `deu` or `script/Fraktur` with `apt`:

```sh
sudo apt install tesseract-ocr-deu tesseract-ocr-script-frak
```

**NOTE:** When installing with `apt`, he `script/*` models are installed
without the `script/` prefix, so `script/Latin` becomes just `Latin`,
`script/Fraktur` becomes `Fraktur` etc.

OCR-D's Tesseract wrapper,
[ocrd_tesserocr](https://github.com/OCR-D/ocrd_tesserocr) and more
specifically, the `ocrd-tesserocr-recognize` processor, expects the name of the
model(s) to be provided as the `model` parameter. Multiple models can be
combined by concatenating with `+` (which generally improves accuracy but always slows processing):

```sh
# Use the deu and frk models
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS -p '{"model": "deu+frk"}'
# Use the script/Fraktur model
ocrd-tesserocr-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-TESS -p '{"model": "script/Fraktur"}'
```

## Ocropy / ocrd_cis

An Ocropy model is simply the neural network serialized with Python's pickle
mechanism and is generally distributed in a gzipped form, with a `.pyrnn.gz`
extension.

Ocropy has a rather convoluted algorithm to look up models, so we recommend you
explicitly set the `OCROPUS_DATA` variable to point to the directory with
ocropy's models. E.g. if you intend to store your models in `$HOME/ocropus-models`, add the following
to your `$HOME/.bashrc`: `export OCROPUS_DATA=$HOME/ocropus-models`.

We recommend you download the following models, either by downloading and
saving to the right location or by running `make install-models-ocropus` when
using `ocrd_all`:

  * [en-default.pyrnn.gz](https://github.com/zuphilip/ocropy-models/raw/master/en-default.pyrnn.gz)
  * [fraktur.pyrnn.gz](https://github.com/zuphilip/ocropy-models/raw/master/fraktur.pyrnn.gz)
  * [@jze's fraktur.pyrnn.gz](https://github.com/jze/ocropus-model_fraktur/raw/master/fraktur.pyrnn.gz) (save as `fraktur-jze.pyrnn.gz`)
  * [@chreul's  LatinHist.pyrnn.gz](https://github.com/chreul/OCR_Testdata_EarlyPrintedBooks/raw/master/LatinHist-98000.pyrnn.gz)


To use a specific model with OCR-D's ocropus wrapper in [ocrd_cis](https://github.com/cisocrgroup/ocrd_cis) and more specifically, the `ocrd-cis-ocropy-recognize` processor, use the `model` parameter:

```sh
ocrd-cis-ocropy-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-OCRO -p '{"model": "fraktur-jze.pyrnn.gz"}'
```

## Calamari / ocrd_calamari

Calamari models are Tensorflow model directories. For distribution, this
directory is usually packed to a tarball or ZIP file. Once downloaded, these
containers must be unpacked to a directory again.

As calamari does not have a model discovery setup, you must always provide the
path with a wildcard listing all `*.ckpt.json` ("checkpoint") files.

We recommend you download the following model, either by downloading and
unpacking manually or by using `make install-models-calamari` if using
`ocrd_all`:

  * [@mike-gerber's GT4HistOCR model](https://qurator-data.de/calamari-models/GT4HistOCR/2019-12-11T11_10+0100/model.tar.xz)

The Calamari-OCR project also maintains a [repository of models](https://github.com/Calamari-OCR/calamari_models)

To use a specific model with OCR-D's calamari wrapper
[ocrd_calamari](https://github.com/OCR-D/ocrd_calamari) and more specifically,
the `ocrd-calamari-recognize` processor, use the `checkpoint` parameter:

```sh
ocrd-calamari-recognize -I OCR-D-SEG-LINE -O OCR-D-OCR-CALA -p '{"checkpoint": "/path/to/model/*.ckpt.json"}'
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
