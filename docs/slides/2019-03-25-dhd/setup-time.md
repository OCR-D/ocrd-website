# Setup Time!

<p style="text-align: center">
<img src="https://media.giphy.com/media/AliO819Kp3aus/200w_d.gif" height="250"/>
<img src="https://media.giphy.com/media/3o85xy034Ob6pNkG08/200w_d.gif" height="250"/>
</p>

<p style="text-align: center">
<img src="https://media.giphy.com/media/zWryHmkavNdDO/giphy-tumblr.gif" height="250"/>
<img src="https://media.giphy.com/media/pxl9J1y4n6UCI/giphy.gif" height="250"/>
</p>

<!-- BEGIN-MARKDOWN-TOC -->
* [What operating system are you on?](#what-operating-system-are-you-on)
	* [Linux](#linux)
	* [Mac OS X](#mac-os-x)
	* [Windows 7](#windows-7)
	* [Windows 10](#windows-10)
* [Installation OCR-D Stack](#installation-ocr-d-stack)
	* [Python](#python)
	* [Setup a virtualenv](#setup-a-virtualenv)
	* [Activate virtualenv](#activate-virtualenv)
	* [Install ocrd core Software](#install-ocrd-core-software)
		* [Test Installation](#test-installation)
	* [Install OCR-D Modules](#install-ocr-d-modules)
		* [ocrd_ocropy](#ocrd_ocropy)
			* [Test Installation](#test-installation-1)
		* [ocrd_kraken](#ocrd_kraken)
			* [Test Installation](#test-installation-2)
		* [ocrd_tesserocr](#ocrd_tesserocr)
			* [Test Installation](#test-installation-3)
* [Install PAGE Viewer](#install-page-viewer)
* [Yay :fireworks: :tada:](#yay-fireworks-tada)

<!-- END-MARKDOWN-TOC -->

## What operating system are you on?

### Linux

You're set, see [next section](#installation-ocr-d-stack)

### Mac OS X

Works mostly like Linux for our purposes, see [next section](#installation-ocr-d-stack).

However, you will need to have `homebrew` or `macports` on your system to be
able to [install tesseract from
homebrew](https://formulae.brew.sh/formula/tesseract_) or [with
macports](https://github.com/macports/macports-ports/blob/master/textproc/tesseract/Portfile).

In case of problems, install VirtualBox and Ubuntu 18.04 inside.

### Windows 7

Please install VirtualBox and Ubuntu 18.04 inside

### Windows 10

Install Windows Subsystem for Linux (WSL)

1. Open PowerShell as Administrator and run:
    ```bash=bash
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```
    :information_source: Needs reboot!
2. Press 'Windows'-Key
3. Type 'Microsoft Store'
4. Start Microsoft Store
5. Search for 'Ubuntu'
6. In category 'Apps' select 'Ubuntu 18.04 LTS'
7. Select 'Download/Herunterladen'
8. Dialog 'Geräteübergreifend verwenden'
   a) Select 'Nein, danke'
9. Installation finished! -> Start
    ```
    Installing, this may take a few minutes...
    Please create a default UNIX user account. ...
    Enter new UNIX username: ocrd
    Enter new UNIX password: dhd2019
    Retype new UNIX password: dhd2019
    passwd: password updated successfully
    [...]
    ocrd@hostname:~$
    ```
10. Done

**Link:** https://docs.microsoft.com/de-de/windows/wsl/install-win10

## Installation OCR-D Stack
### Python
```bash=bash
# Update package list
user@hostname:~$sudo apt-get update
[...]
Reading package lists... Done
# Install Python3
user@hostname:~$sudo apt-get install python3 python3-dev python3-virtualenv build-essential
[...]
Do you want to continue? [Y/n] 'Enter'
[...]
user@hostname:~$
```
### Setup a virtualenv
:information_source: Setting up virtual environment will take a while!
```bash=bash
# Setup virtual environment.
user@hostname:~$python3 -m virtualenv ~/env-ocrd --python=python3
Already using interpreter /usr/bin/python3
Using base prefix '/usr'
New python executable in /home/ocrd/env-ocrd/bin/python3
Also creating executable in /home/ocrd/env-ocrd/bin/python
Installing setuptools, pkg_resources, pip, wheel...done
user@hostname:~$
```
### Activate virtualenv
```bash=bash
user@hostname:~$source ~/env-ocrd/bin/activate
(env-ocrd) user@hostname:~$
```
### Install ocrd core Software
:information_source: Setting up ocrd core software will take a while!
```bash=bash
(env-ocrd) user@hostname:~$pip install ocrd==1.0.0b6
Collecting ocrd==1.0.0b5
  Downloading https://files.pythonhosted.org/packages/cd/e4/9f56fe9971e04e2e97d6ad27457d6a1c17d798de9c15fd3030f194beca24/ocrd-0.15.2-py3-none-any.whl (138kB)
   100% |████████████████████████████████| 143kB 3.0MB/s
[...]
Successfully installed Deprecated-1.2.0 Flask-1.0.2 Jinja2-2.10 MarkupSafe-1.1.1 Pillow-5.4.1 Werkzeug-0.14.1 attrs-19.1.0 bagit-1.7.0 bagit-profile-1.3.0 certifi-2019.3.9 chardet-3.0.4 click-7.0 idna-2.8 itsdangerous-1.1.0 jsonschema-3.0.1 lxml-4.3.2 numpy-1.16.2 ocrd-0.15.2 opencv-python-4.0.0.21 pyrsistent-0.14.11 pyyaml-5.1 requests-2.21.0 six-1.12.0 urllib3-1.24.1 wrapt-1.11.1
(env-ocrd) user@hostname:~$
```
#### Test Installation
```bash=bash
(env-ocrd) user@hostname:~$ocrd --version
ocrd, version 1.0.0b6
```
### Install OCR-D Modules
- ocrd_ocropy
- ocrd_kraken
- ocrd_tesserocr

#### ocrd_ocropy

```bash=bash
(env-ocrd) user@hostname:~$pip install ocrd_ocropy
Collecting ocrd_ocropy
[...]
Successfully installed cycler-0.10.0 imageio-2.5.0 kiwisolver-1.0.1 matplotlib-3.0.3 ocrd-fork-ocropy-1.4.0a3 ocrd-ocropy-0.0.1a1 pyparsing-2.3.1 python-dateutil-2.8.0
(env-ocrd) user@hostname:~$
```

##### Test Installation

```bash=bash
(env-ocrd) user@hostname:~$ocrd-ocropy-segment --help
Usage: ocrd-ocropy-segment [OPTIONS]                                                                                                                   Options:
  -V, --version                   Show version
  -l, --log-level [OFF|ERROR|WARN|INFO|DEBUG|TRACE]
                                  Log level
  -J, --dump-json                 Dump tool description as JSON and exit
  -p, --parameter PATH
  -g, --page-id TEXT              ID(s) of the pages to process
  -O, --output-file-grp TEXT      File group(s) used as output.
  -I, --input-file-grp TEXT       File group(s) used as input.
  -w, --working-dir TEXT          Working Directory
  -m, --mets TEXT                 METS URL to validate
  --help                          Show this message and exit.
```

#### ocrd_kraken

```bash=bash
(env-ocrd) user@hostname:~$pip install ocrd_kraken
Collecting ocrd_kraken
[...]
Successfully installed kraken-0.9.16 ocrd-kraken-0.1.0 regex-2019.3.12
(env-ocrd) user@hostname:~$
```

##### Test Installation

```bash=bash
(env-ocrd) user@hostname:~$ocrd-kraken-binarize --help
Usage: ocrd-kraken-binarize [OPTIONS]

Options:
-V, --version                   Show version
-l, --log-level [OFF|ERROR|WARN|INFO|DEBUG|TRACE]  Log level
-J, --dump-json                 Dump tool description as JSON and exit
-p, --parameter PATH
-g, --page-id TEXT              ID(s) of the pages to process
-O, --output-file-grp TEXT      File group(s) used as output.
-I, --input-file-grp TEXT       File group(s) used as input.
-w, --working-dir TEXT          Working Directory
-m, --mets TEXT                 METS URL to validate
--help                          Show this message and exit.
(env-ocrd) user@hostname:~$
```
#### ocrd_tesserocr

```bash=bash
# Install tesseract
(env-ocrd) user@hostname:~$sudo apt-get install libtesseract-dev tesseract-ocr
[...]
Do you want to continue? [Y/n] 'Enter'
[...]
(env-ocrd) user@hostname:~$
```

:information_source: Setting up virtual environment will take a while!

```bash=bash
(env-ocrd) user@hostname:~$pip install ocrd_tesserocr
Collecting ocrd_tesserocr
[...]
Successfully installed kraken-0.9.16 ocrd-kraken-0.1.0 regex-2019.3.12
(env-ocrd) user@hostname:~$
```

##### Test Installation

```bash=bash
(env-ocrd) user@hostname:~$ocrd-tesserocr-recognize --help
Usage: ocrd-tesserocr-recognize [OPTIONS]
Options:
-V, --version                   Show version
-l, --log-level [OFF|ERROR|WARN|INFO|DEBUG|TRACE]
                                Log level
-J, --dump-json                 Dump tool description as JSON and exit
-p, --parameter PATH
-g, --page-id TEXT              ID(s) of the pages to process
-O, --output-file-grp TEXT      File group(s) used as output.
-I, --input-file-grp TEXT       File group(s) used as input.
-w, --working-dir TEXT          Working Directory
-m, --mets TEXT                 METS URL to validate
--help                          Show this message and exit.
(env-ocrd) user@hostname:~$
```

## Install PAGE Viewer

PAGE Viewer allows you to view a PAGE file together with the image.

Download the appropriate version for your OS from the [PRIMA Labs Website](https://www.primaresearch.org/alternative_download_links.html)

## Yay :fireworks: :tada:

:fireworks: :tada:

If all steps were successful you are well prepared for the workshop.

If not don't hesitate to contact us via [gitter](https://gitter.im/OCR-D/Lobby).
