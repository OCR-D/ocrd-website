---
layout: page
author: Volker Hartmann
toc: true
lang: en
lang-ref: ocrd-gt-repo
---
# Working with OCR-D-(Ground-Truth)-Repository 

## Upload bagit container from scratch to OCR-D(-GT)-Repository
Example to upload a scanned page to OCR-D-Repo.
### Preparation: Create Workspace
Requirements: ocrd (Version 1.0.0) [See Setup OCR-D Stack](http://kba.cloud/2019-03-25-dhd/setup-time)
#### Activate virtualenv
```bash=bash
user@hostname:~$source ~/env-ocrd/bin/activate
(env-ocrd) user@hostname:~$
```

#### Initialize Workspace 
```bash=bash
(env-ocrd) user@hostname:~$ ocrd workspace init communist_manifesto
(env-ocrd) user@hostname:~$ cd communist_manifesto
```
#### Create Folder for Scanned Page

```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ mkdir OCR-D-IMG
```

#### Download Image (Google)

```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ wget https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Manifesto_of_the_Communist_Party.djvu/page15-2745px-Manifesto_of_the_Communist_Party.djvu.jpg -O OCR-D-IMG/OCR-D-IMG_0015.jpg
```
#### Add Image to Workspace

```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ ocrd workspace add -g P0015 -G OCR-D-IMG -i OCR-D-IMG_0015 -m image/jpg OCR-D-IMG/OCR-D-IMG_0015.jpg
```
#### Set Unique ID for Workspace

```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ ocrd workspace set-id 'communist_manifesto'
```
#### Validate Workspace
For some images, the resolution of the image is not set. To avoid validation errors, the resolution check is skipped.
For further details see 'ocrd workspace validate --help'.
```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ ocrd workspace validate --skip pixel_density mets.xml
```
### Create BagIt Container

```bash=bash
(env-ocrd) user@hostname:~/communist_manifesto$ cd ..
(env-ocrd) user@hostname:~/$ ocrd zip bag -i communist_manifesto -d communist_manifesto/
```

### Validate BagIt Container

```bash=bash
(env-ocrd) user@hostname:~/$ ocrd zip validate communist_manifesto.ocrd.zip
[...]
OK
```
### Upload BagIt Container

```bash=bash
user@hostname:~/$ curl -u ingest:GENERATED_PASSWORD -v -F "file=@communist_manifesto.ocrd.zip" http://localhost:8080/api/v1/metastore/bagit 
[...]
OK
```
## Download all BagIt Containers
```bash=bash
user@hostname:~/Download$ wget -O listOfContainers.json https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit

user@hostname:~/Download$ ocrdzips=$(cat listOfContainers.json | tr ",[]\"" "\n")

user@hostname:~/Download$ for addr in $ocrdzips
do
  wget $addr
  filename=$(basename -- "$addr")
  directory="${filename%.*}"

  mkdir $directory
  cd $directory
  unzip ../$filename
  cd ..
done
```


## List all Documents (in Browser)
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit
The list shows all ingested documents with its 
- '***Upload Date***'
- '***Version***'
- '***OCR-D Identifier***'
- '***Link for Download***'
- '***Referenced Files***'
- '***Metadata***'
- and '***Semantic Labeling***'
(Upload is only available for authorized users)

## Download Document
https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/71e19490-343a-4d68-a5a7-7cf4c725c843/data/arent_dichtercharaktere_1885.zip
Download of the complete document as bagit container.

## List all Files inside Document
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/71e19490-343a-4d68-a5a7-7cf4c725c843/files
All files of given resourceID referenced inside the mets.xml are listed here.

## Download Single File
https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/71e19490-343a-4d68-a5a7-7cf4c725c843/data/bagit/data/DEFAULT/DEFAULT_0002
Download/view single file (Tiff) of given resourceID, file group and fileID. 

## List Metadata
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/71e19490-343a-4d68-a5a7-7cf4c725c843/metadata
List metadata of the document (e.g.: title, author, year, identifier, languages, classifications) of given resourceID.
## List Ground Truth Metadata
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/71e19490-343a-4d68-a5a7-7cf4c725c843/groundtruth
List all semantic labels of given resourceID.

## Search Inside Repository
All searches will return a list of fitting resourceIDs. In order to further investigate the found resources, the listings above can be used.
### Search via browser
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit/search
### Search on command line
#### Search for Semantic Label
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/labeling?label=condition/acquisition/method-flaws/imaging/uneven-illumination
Search for documents with e.g. uneven illumination.

#### Search for Documents Containing Multiple Semantic Labels at Once
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/labeling?label=condition/acquisition/method-flaws/imaging/uneven-illumination,condition/acquisition/content-or-background/included-objects/preceeding-or-proceeding

#### Search for Documents with Classification 'Fachtext'
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/classification?class=Fachtext

#### Search for Documents with Language 'deu'
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/language?lang=deu

#### Search for Documents with Identifier '16488'
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/identifier?identifier=16529

#### Search for Documents with Specific Identifier and Type
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/identifier?identifier=urn:nbn:de:kobv:b4-200905196929&type=urn
Search for document with specific identifier of a specific type.
Possible types are: 
- purl
- urn
- handle
- url
- dtaid
- ...
### Download selected BagIt Containers
E.g.: All with Classification 'Belletristik'
```bash=bash
# Get all containers
user@hostname:~/Download$ wget -O listOfAllContainers.json https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit

user@hostname:~/Download$ allocrdzips=$(cat listOfAllContainers.json | tr ",[]\"" "\n")

# Get IDs of fitting containers
user@hostname:~/Download$ wget -O filteredList.json https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/classification?class=Belletristik

user@hostname:~/Download$ filteredIds=$(cat filteredList.json | tr ",[]\"" "\n")

user@hostname:~/Download$ for bagitid in $filteredIds
do
  for addr in $allocrdzips
  do
    if echo "$addr" | grep -q "$bagitid"; then
      wget $addr
      filename=$(basename -- "$addr")
      directory="${filename%.*}"

      mkdir $directory
      cd $directory
      unzip ../$filename
      cd ..
    fi
  done
done
```




