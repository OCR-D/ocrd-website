---
layout: page
lang: de
lang-ref: page.md
toc: true
---

# Conventions for PAGE

In addition to these conventions, refer to the [PAGE API
docs](https://ocr-d.de/en/gt-guidelines/trans/trPage.html) for extensive
documentation on the PAGE XML format itself.

## Media Type

The [preliminary media type](https://github.com/OCR-D/spec/issues/33) of a PAGE
document is `application/vnd.prima.page+xml`, which MUST be used [as the `MIMETYPE` of a `<mets:file>`
representing a PAGE document](https://ocr-d.de/en/spec/mets#media-type-for-page-xml).

## One page in one PAGE

A single PAGE XML file represents one page in the original document.
Every `<pc:Page>` element MUST have an attribute `image` which MUST always be the source image.
The PAGE XML root element `<pc:PcGts>` MUST have exactly one `<pc:Page>`.

## Images

### URL for imageFilename / filename

The `imageFilename` of the `<pg:Page>` and `filename` of the
`<pg:AlternativeImage>` element MUST be a filename relative to the `mets.xml`.

All URL used in `imageFilename` and `filename` [MUST be referenced in a fileGrp
in METS](https://ocr-d.de/en/spec/mets#if-in-page-then-in-mets).

### Original image as imageFilename

The `imageFilename` attribute of the `<pg:Page>` MUST reference the original
image and MUST NOT change between processing steps.

### AlternativeImage for derived images

To encode images derived from the original image, the `<pc:AlternativeImage>`
should be used. Its `filename` attribute should reference the URL of the
derived image.

The `comments` attribute SHOULD be used according to the [AlternativeImage classification](#alternativeimage-classification).

### AlternativeImage: classification

The `comments` attribute of the `<pg:AlternativeImage>` attribute should be used

  * `binarized`
  * `grayscale_normalized`
  * `deskewed`
  * `despeckled`
  * `cropped`
  * `rotated-90` / `rotated-180` / `rotated-270`
  * `dewarped`

### AlternativeImage on sub-page level elements

For the results of image processing that changes the positions of pixels (e.g.
cropping, rotation, dewarping), `AlternativeImage` on page level and polygon of
recognized zones is not sufficient for accessing the section of the image that a region is based on
since coordinates are always relative to the original image.

For such use cases, `<pg:AlternativeImage>` may be used as a child of
`<pg:TextRegion>`, `<pg:TextLine>`, `<pg:Word>` or `<pg:Glyph>`.

## Attaching text recognition results to elements

A PAGE document can attach recognized text to typographical units of
a page at different levels, such as region (`<pg:TextRegion>`), line
(`<pg:TextLine>`), word (`<pg:Word>`) or glyph (`<pg:Glyph>`).

To attach recognized text to an element `E`, it must be encoded as
`UTF-8` in a single `<pg:Unicode>` element `U` within a `<pg:TextEquiv>`
element `T` of `E`.

`T` must be the last element of `E`.

Leading and trailing whitespace (`U+0020`, `U+000A`) in the content of a
`<pg:Unicode>` is not significant and must be removed from the string by
processors.

To encode an actual space character at the start or end of the content
`<pg:Unicode>`, use a non-breaking space `U+00A0`.

## Text recognition confidence

The confidence score describing the assumed correctness of the text recognition results in a
`<pg:TextEquiv>` can be expressed in an attribute `@conf` as a float value
between `0` and `1`, where `0` means "certainly wrong" and `1` means "certainly
correct".

<a name="multiple-textequivs"/>
## Attaching multiple text recognition results to elements

Alternative text recognition results can be expressed by using multiple
`<pg:TextEquiv>` wherever a single `<pg:TextEquiv>` would be allowed. When
using multiple `<pg:TextEquiv>`, they each must have an attribute `@index` with
an integer number unique per set of `<pg:TextEquiv>` that allows ranking them
in order of preference. `@index` of the first (preferred) `<pg:TextEquiv>` must be
the value `1`.

## Consistency of text results on different levels

Since text results can be defined on different levels and those levels can be
nested, text results information can be redundant. To avoid inconsistencies,
the following assertions must be true:

  1. text of `<pg:Word>` must be equal to the text of all `<pg:Glyph>`
    contained within, concatenated with empty string
  2. text of `<pg:TextLine>` must be equal to the text of all
    `<pg:Word>` contained  within, concatenated with a single space (`U+0020`).
  3. text of `<pg:TextRegion>` must be equal to the text of all
    `<pg:TextLine>` contained within, concatenated with a newline (`U+000A`).

**NOTE:** "Concatenation" means joining a list of strings with a separator, no
separator is added to the start or end of the resulting string.

These assertions are only to be enforced for the first `<pg:TextEquiv>` of both
containing and contained elements, i.e. the only `<pg:TextEquiv>` of an element
or the `<pg:TextEquiv>` with `@index = 1` if [multiple text
results](#multiple-textequivs) are attached.

### Consistency strictness

A consistency checker must support four levels of strictness:

#### `strict`

If any of the assertions fail for a PAGE document, an exception
should be raised and the document no further processed

#### `lax`

If any of the assertions fail for a PAGE document, another comparison
disregarding all whitespace shall be made. If this still fails, an exception
should be raised and the document no further processed

#### `fix`

If any of the assertions fail for a specific element in PAGE document, the text
results of this element must be recreated, by concatenating the text results of
its children elements. This algorithm needs to be recursive, i.e. if any of the
children elements is itself inconsistent, its text results must be recreated in
the same way before concatenation.

#### `off`

These consistency checks are so restrictive to spot data that cannot be
unambigiously processed. However, there are valid use cases where the
"index-1-consistency" is too narrow, esp. in post-correction with language
models. For such use cases, it must be possible to disable the consistency
validation altogether in the workflow.

### Example

<a name="inconsistency-example"/>
```xml
<Word>
  <Glyph>
    <TextEquiv index="1"><Unicode>f</Unicode></TextEquiv>
    <TextEquiv index="2"><Unicode>t</Unicode></TextEquiv>
  </Glyph>
  <Glyph>
    <TextEquiv index="1"><Unicode>o</Unicode></TextEquiv>
  </Glyph>
  <Glyph>
    <TextEquiv><Unicode>o</Unicode></TextEquiv>
  </Glyph>
  <Glyph>
    <TextEquiv><Unicode>t</Unicode></TextEquiv>
  </Glyph>
  <TextEquiv index="1"><Unicode>foof</Unicode></TextEquiv>
  <TextEquiv index="2"><Unicode>toot</Unicode></TextEquiv>
</Word>
```

In this [example](#inconsistency-example), the `<pg:Word>` has text `foof` but
the concatenation of the first text results of the contained `<pg:Glyphs>`
spells `foot`. As a result:

  * Validation should raise an exception for inconsistency.
  * Data consumers should assume the text result to be `foot`.

## `TextStyle`

Typographical information (type, cut etc.) must be documented in PAGE XML using the
`<TextStyle>` element.

See [the PAGE documentation on TextStyle](http://www.ocr-d.de/sites/all/gt_guidelines/pagecontent_xsd_Complex_Type_pc_TextStyleType.html?hl=textstyle) for all possible values.

The `<TextStyle>` element can be used in all relevant elements: 

  * `<TextRegion>`
  * `<TextLine>`
  * `<Word>`
  * `<Glyph>`

Example:

```xml
<Word>
  <TextStyle fontFamily="Arial" fontSize="17.0" bold="true"/>
  <!-- [...] -->
</Word>
```

### Font families

The `pg:TextStyle/@fontFamily` attribute can list one or more font
families, separated by comma (`,`).

```
font-families    := font-family ("," font-family)*
font-family      := font-family-name (":" confidence)?
font-family-name := ["A" - "Z" | "a" - "z" | "0" - "9"]+ | '"' ["A" - "Z" | "a" - "z" | "0" - "9" | " "]+ '"'
confidence       := ("0" | "1")? "." ["0" - "9"]+
```

Font family names that contain a space must be quoted with double quotes (`"`).

### Clusters of typesets

Sometimes it is necessary to not express that an element is typeset in a
specific **font family** but in font family from **a cluster of related font groups**.

For such typeset clusters, the `pg:TextStyle/@fontFamily` attribute should be re-used.

This specification doesn't restrict the naming of font families.
However, we recommend to choose one of the following list of type groups names if
applicable:

  * `textura`
  * `rotunda`
  * `bastarda`
  * `antiqua`
  * `greek`
  * `hebrew`
  * `italic`
  * `fraktur`

### Font families and confidence

Providing multiple font families means that the element in
question is set in **one of the font families listed**.

It is not possible to declare that **multiple font families are used in an
element**. Instead, data producers are advised to increase output granularity
until every element is set in a single font family.

The degree of confidence in the font family can be expressed by concatenating
font family names with colon (`:`) followed by a float between `0` (information
is certainly wrong) and `1` (information is certainly correct).

If a font family is not suffixed with a confidence value, the confidence is
considered to be `1`.

Examples

```xml
<TextStyle fontFamily="Arial:0.8, Times:0.7, Courier:0.4"/>
<TextStyle fontFamily="Arial:.8, Times:0.5"/>
<TextStyle fontFamily="Arial:1"/>
<TextStyle fontFamily="Arial"/>
```

## Columns

To model columns, use constructs in the `<pg:ReadingOrder>` of the PAGE
document.

A grid layout must be wrapped in a `<pg:OrderedGroup>` with a
`@caption` that has the form `column_<horizontal>_<vertical>` where
`<vertical>` is the number of columns and `<horizontal>` is the number of rows.

```xml
<OrderedGroup caption="column_1_1"> <!-- the default: single column layout -->
<OrderedGroup caption="column_1_2"> <!-- two-column layout -->
<OrderedGroup caption="column_1_3"> <!-- three-column layout -->
<OrderedGroup caption="column_2_3"> <!-- three-column layout split in top and bottom -->
```

Regions that belong to the same column must be grouped within
`<pg:OrderedGroupIndexed>` with a caption that begins with `column_<y>_<x>`
where `<y>` is the row position and `<x>` is the column position (counting starts at `1`):

```xml
<OrderedGroup caption="column_2_2"> <!-- two-column two-row layout -->
    <OrderedGroupIndexed caption="column_1_1">...</OrderedGroupIndexed> <!-- upper-left column -->
    <OrderedGroupIndexed caption="column_1_2">...</OrderedGroupIndexed> <!-- upper-right column -->
    <OrderedGroupIndexed caption="column_2_1">...</OrderedGroupIndexed> <!-- lower-left column -->
    <OrderedGroupIndexed caption="column_2_2">...</OrderedGroupIndexed> <!-- lower-right column -->
</OrderedGroup>
```
