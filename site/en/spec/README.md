---
layout: page
lang: en
lang-ref: README.md
toc: true
title: Specification of the technical architecture, interface definitions and data exchange format(s)
---

<img src="https://ocr-d.de/assets/Logo-Schrift_Englisch.svg">

# Specification of the technical architecture, interface definitions and data exchange format(s)

See [https://ocr-d.de/en/spec/](https://ocr-d.de/en/spec/).

## Translating the spec

The specification is in English. To add a german translation of a file, replace the `.md` suffix with `.de.md`.

## Building JSON files

`.json` files are built from the easier-to-edit `.yml` files.

To regenerate the `.json` files after editing `.yml` files, run

```sh
make json
```

This requires python3 with the `click` and `yaml` libraries. To install the libraries run

```sh
make deps
```
