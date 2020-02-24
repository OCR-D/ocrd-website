# Demonstration OCR-D-GroundTruth-Repository DHd 2019

## List all Documents
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/bagit
The list shows all ingested documents with its '***resourceID***', '***Link for Download***', '***Referenced Files***', '***Metadata***', and '***Semantic Labeling***'
(Upload is only available for authorized users)

## Download Document
https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/data/buerger_gedichte_1778.ocrd.zip
Download of the complete document.

## List all Files inside Document
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/files
All files referenced inside the mets.xml are listed here.

## Download single file
https://ocr-d-repo.scc.kit.edu/api/v1/dataresources/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/data/bagit/data/OCR-D-IMG/OCR-D-IMG_0001
Download/view single file. (Tiff)

## List Metadata
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/metadata
List metadata of the document. (e.g.: title, author, year, identifier, languages, classifications)
## List Ground Truth Metadata
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/f15fb8c8-3842-4314-9a44-5e8b472d7bfc/groundtruth
List all semantic labels.

## Search for Semantic Label
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/labeling?label=condition/acquisition/method-flaws/imaging/uneven-illumination
Search for documents with uneven illumination.

## Search for Documents containing two Semantic Labels at once
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/labeling?label=condition/acquisition/method-flaws/imaging/uneven-illumination,condition/acquisition/content-or-background/included-objects/preceeding-or-proceeding

## Search for Documents with Classification 'Fachtext'
https://ocr-d-repo.scc.kit.edu/api/v1/metastore/mets/classification?class=Fachtext
