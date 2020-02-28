---
layout: page
author: Elisabeth Engel
date: 2020-02-04T19:16:54+01:00
lang: en
lang-ref: from-novice-to-pro
toc: true
---

# Example METS

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mets:mets xmlns:mets="http://www.loc.gov/METS/"
           xmlns:xlink="http://www.w3.org/1999/xlink"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="info:lc/xmlns/premis-v2 http://www.loc.gov/standards/premis/v2/premis-v2-0.xsd
                               http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-6.xsd 
                               http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version17/mets.v1-7.xsd 
                               http://www.loc.gov/mix/v10 http://www.loc.gov/standards/mix/mix10/mix10.xsd">
  <mets:metsHdr CREATEDATE="2020-02-28T07:52:41.141812">
    <mets:agent TYPE="OTHER" OTHERTYPE="SOFTWARE" ROLE="CREATOR">
      <mets:name>ocrd/core v2.3.1</mets:name>
    </mets:agent>
  </mets:metsHdr>
  <mets:dmdSec ID="DMDLOG_0001">
    <mets:mdWrap MDTYPE="MODS">
      <mets:xmlData>
        <mods:mods xmlns:mods="http://www.loc.gov/mods/v3">
          <mods:identifier type="purl">uniqueID</mods:identifier>
        </mods:mods>
      </mets:xmlData>
    </mets:mdWrap>
  </mets:dmdSec>
  <mets:amdSec ID="AMD">
    </mets:amdSec>
  <mets:fileSec>
    <mets:fileGrp USE="OCR-D-IMG">
      <mets:file MIMETYPE="image/jpg" ID="OCR-D-IMG_00001">
        <mets:FLocat LOCTYPE="OTHER" OTHERLOCTYPE="FILE" xlink:href="OCR-D-IMG/OCR-D-IMG_0001.jpg"/>
      </mets:file>
    </mets:fileGrp>
  </mets:fileSec>
  <mets:structMap TYPE="PHYSICAL">
    <mets:div TYPE="physSequence">
      <mets:div TYPE="page" ID="P_00001">
        <mets:fptr FILEID="OCR-D-IMG_00001"/>
      </mets:div>
    </mets:div>
  </mets:structMap>
</mets:mets>
```


