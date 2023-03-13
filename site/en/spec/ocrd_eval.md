---
layout: page
lang: en
lang-ref: ocrd_eval.md
toc: true
title: Quality Assurance in OCR-D
id: ocrd-eval
---

# Quality Assurance in OCR-D

## Rationale

Evaluating the quality of OCR requires comparing the OCR results on representative **ground truth** (GT)
– i.e. realistic data (images) with manual transcriptions (segmentation, text).
OCR results can be obtained via several distinct **OCR workflows**.

The comparison requires evaluation tools which themselves build on a number of established
evaluation metrics.
The evaluation results must be presented in a way that allows factorising and localising aberrations,
both within documents (page types, individual pages, region types, individual regions) and across classes of similar documents.

 All this needs to  work together in a well-defined and automatically repeatable manner, so
 users can make informed decisions about which OCR workflow works best for which material and use case.

## Evaluation Metrics

The evaluation of the quality (accuracy and precision) of OCR is a complex task, for which multiple methods and metrics are available.
It needs to capture several aspects corresponding to the interdependent subtasks of an OCR workflow, viz. layout analysis and text recognition, which themselves require different methods and metrics.

Furthermore, the time and resources required for OCR processing also have to be captured. Here we describe the metrics that were selected for use in OCR-D, how exactly they are applied, and what was the motivation.

### Scope of These Definitions

At this stage (Q3 2022) these definitions serve as a basis of common understanding for the metrics used in the benchmarking presented in OCR-D QUIVER. Further implications for evaluation tools do not yet apply.

### Text Evaluation

The most important measure to assess the quality of OCR is the accuracy of the recognized text.
The majority of metrics for this are based on the Levenshtein distance, an algorithm to compute the distance between two strings.
In OCR, one of these strings is generally the Ground Truth text and the other the recognized text which is the result of an OCR.
The text is concatenated at page level from smaller constituents in reading order.

#### Characters

A text consists of a set of characters that have a certain meaning.
In OCR-D, a character is technically defined as a grapheme cluster, i.e. one or more Unicode (or Private Use Area) codepoint(s) that represents an element of a writing system in NFC (see [Unicode Normalization](#unicode-normalization)).
White spaces are considered as characters.

Special codepoints like Byte-Order Marks or directional marks are ignored.

##### Examples

* the character `ä` in the word `Kälte` is encoded by Unicode `U+00E4`
* the character `ܡܿ` in the word `ܡܿܢ` is encoded by Unicode `U+0721` + `U+073F`

#### Levenshtein Distance (Edit Distance)

Levenshtein distance between two strings is defined as the (minimum) number of (single-character) edit operations needed to turn the one into the other.
Edit operations depend on the specific variant of the algorithm but for OCR, relevant operations are deletion, insertion and substitution.
To calculate the edit distance, the two strings first have to be (optimally) aligned.

The Levenshtein distance forms the basis for the calculation of [CER/WER](https://pad.gwdg.de/#CERWER).
As there are different implementations of the edit distance available (e.g. [rapidfuzz](https://maxbachmann.github.io/RapidFuzz/Usage/distance/Levenshtein.html), [jellyfish](https://jamesturk.github.io/jellyfish/functions/#levenshtein-distance), …), the OCR-D coordination project will provide a recommendation in the final version of this document.

##### Example

Given a Ground truth that reads `ſind` and the recognized text `fmd`.

The Levenshtein distance between these texts is 3, because 3 single-character edit operations are necessary to turn `fmd` into `ſind`. For example:

* `fmd` --> `ſmd` (substitution)
* `ſmd` --> `ſimd` (insertion)
* `ſimd` --> `ſind` (substitution)

#### CER and WER

##### Character Error Rate (CER)

The character error rate (CER) is defined as the quotient of the edit distance over the length
with respect to the character string pair of GT and OCR text. It thus describes an empirical estimate
of the probability of some random character to be misrecognised.

Thus, CER defines a (single-character) **error** in terms of the above three categories of edit operations:

* **deletion**: a character that is present in the text has been deleted from the output.

Example:
![A Fraktur sample reading "Sonnenfinſterniſſe:"](https://pad.gwdg.de/uploads/d7fa6f23-7c79-4fb2-ad94-7e98084c69d6.jpg)

This reads `Sonnenfinſterniſſe:`. The output contains `Sonnenfinſterniſſe`, deleting `:`.

* **substitution**: a character is replaced by another character in the output.

Example:

![A Fraktur sample reading "Die Finſterniſſe des 1801ſten Jahrs"](https://pad.gwdg.de/uploads/b894049b-8d98-4fe7-ac31-71b2c9393a6c.jpg)

This heading reads `Die Finſterniſſe des 1801ſten Jahrs`. The output contains `180iſten`, replacing `1` with `i`.

* **insertion**: a new character is introduced in the output.

Example:

![A Fraktur sample reading "diese Strahlen, und"](https://pad.gwdg.de/uploads/e6b6432e-d79c-4568-9aef-15a026c05b39.jpg)

This reads `diese Strahlen, und`. The output contains `Strahlen ,`, inserting a white space before the comma.

CER can be defined in multiple ways, depending on what exactly counts as the **length** of the text.

Given $i$ as the number of insertions, $d$ the number of deletions, $s$ the number of substitutions of the OCR text,
and $n$ the total number of characters of the GT text, the CER can be obtained by

$CER = \frac{i + s+ d}{n}$

If the CER value is calculated this way, it represents the percentage of characters incorrectly recognized by the OCR engine. Also, we can easily reach error rates beyond 100% when the output contains a lot of insertions.

Sometimes, this is mitigated by defining $n$ as the maximum of both lengths, or by clipping the rate at 100%.
Neither of these strategies yields an unbiased estimate.

The *normalized* CER avoids this effect by considering the number of correct characters (or identity operations), $c$:

$CER_n = \frac{i + s+ d}{i + s + d + c}$

In OCR-D's benchmarking we calculate the *normalized* CER where values naturally range between 0 and 100%.

###### CER Granularity

In OCR-D we distinguish between the CER per **page** and the **overall** CER of a document. The reasoning behind this is that the material OCR-D mainly aims at (historical prints) is very heterogeneous: Some pages might have an almost simplistic layout while others can be highly complex and difficult to process. Providing only an overall CER would cloud these differences between pages.

Currently we only provide CER per page; higher-level CER results might be calculated as a weighted aggregate at a later stage.

##### Word Error Rate (WER)

Word error rate (WER) is analogous to CER: While CER operates on (differences between) characters,
WER measures the percentage of incorrectly recognized words in a text.

A **word** in that context is usually defined as any sequence of characters between white space (including line breaks), with leading and trailing punctuation removed (according to [Unicode TR29 Word Boundary algorithm](http://unicode.org/reports/tr29/#Word_Boundaries)).

CER and WER share categories of errors, and the WER is similarly calculated:

$WER = \frac{i_w + s_w + d_w}{i_w + s_w + d_w + c_w}$

where $i_w$ is the number of inserted, $s_w$ the number of substituted, $d_w$ the number of deleted and $c_w$ the number of correct words.

More specific cases of WER consider only the "significant" words, omitting e.g. stopwords from the calculation.

###### WER Granularity

In OCR-D we distinguish between the WER per **page** and the **overall** WER of a document. The reasoning here follows the one of CER granularity.

Currently we only provide WER per page; higher-level WER results might be calculated at a later stage.

#### Bag of Words

In the "Bag of Words" (BaW) model, a text is represented as a multiset of the words (as defined in the previous section) it contains, regardless of their order.

Example:

![A sample paragraph in German Fraktur](https://pad.gwdg.de/uploads/4d33b422-6c77-436c-a3e6-bf27e67dc203.jpg)

> Eine Mondfinsternis ist die Himmelsbegebenheit welche sich zur Zeit des Vollmondes ereignet, wenn die Erde zwischen der Sonne und dem Monde steht, so daß die Strahlen der Sonne von der Erde aufgehalten werden, und daß man so den Schatten der Erde in dem Monde siehet. In diesem Jahre sind zwey Monfinsternisse, davon ist ebenfalls nur Eine bey uns sichtbar, und zwar am 30sten März des Morgens nach 4 Uhr, und währt bis nach 6 Uhr.

To get the Bag of Words of this paragraph a multiset containing each word and its number of occurence is created:

$BoW_{GT}$ =

```json=
{
    "Eine": 2, "Mondfinsternis": 1, "ist": 2, "die": 2, "Himmelsbegebenheit": 1, 
    "welche": 1, "sich": 1, "zur": 1,  "Zeit": 1, "des": 2, "Vollmondes": 1,
    "ereignet,": 1, "wenn": 1, "Erde": 3, "zwischen": 1, "der": 4, "Sonne": 2,
    "und": 4, "dem": 2, "Monde": 2, "steht,": 1, "so": 2, "daß": 2, 
    "Strahlen": 1, "von": 1, "aufgehalten": 1, "werden,": 1, "man": 1, "den": 1, 
    "Schatten": 1, "in": 1, "siehet.": 1, "In": 1, "diesem": 1, "Jahre": 1, 
    "sind": 1, "zwey": 1, "Monfinsternisse,": 1, "davon": 1, "ebenfalls": 1, "nur": 1, 
    "bey": 1, "uns": 1, "sichtbar,": 1, "zwar": 1, "am": 1, "30sten": 1, 
    "März": 1, "Morgens": 1, "nach": 2, "4": 1, "Uhr,": 1, "währt": 1, 
    "bis": 1, "6": 1, "Uhr.": 1
}
```

##### Bag-of-Words Error Rate

Based on the above concept, the Bag-of-Words Error Rate is defined as the sum over the modulus of the GT count minus OCR count of each word, divided by the sum total of words in GT and OCR.

The BoW error therefore describes how many words are misrecognized (positively or negatively), independent of a page's layout (order/segmentation).

$$ BWE = \frac{|BoW_{GT} - BoW_{OCR}|}{ {n_w}_{GT} + {n_w}_{OCR} } $$

###### Example

Given the GT text `der Mann steht an der Ampel`, recognised by OCR as `cer Mann fteht an der Ampel`:

$$ BoW_{GT} = \{ \text{Ampel}: 1, \text{an}: 1, \text{der}: 2, \text{Mann}: 1, \text{steht}: 1 \} $$

and

$$ BoW_{OCR} = \{ \text{Ampel}: 1, \text{an}: 1, \text{cer}: 1, \text{der}: 1, \text{Mann}: 1, \text{fteht}: 1 \} $$

results in:

$$ BWE = \frac{|1 - 1| + |1 - 1| + |2 - 1| + |0 - 1| + |1 - 1| + |1 - 0| + |0 - 1|}{12} = \frac{0 + 0 + 1 + 1 + 0 + 1 + 1}{12} = 0.33 $$

In this example, 66% of the words have been correctly recognized.

### Layout Evaluation

A good text segementation is the basis for measuring text accuracy.

An example can help to illustrate this:
Given in a document containing two columns these two columns are detected by layout analysis as just one.
The OCR result will then contain the text for the first lines of the first and second column, followed by the second lines of the first and second column asf. which does not correspond to the sequence of words and paragraphs given in the Ground Truth.
Even if all characters and words may be recognized correctly, all downstream processes to measure text accuracy will be defeated.

While the comprehensive evaluation of OCR with consideration of layout analysis is still a research topic, several established metrics can be used to capture different aspects of it.
For pragmatic reasons we set aside errors resulting from misdetecting the reading order for the moment (though this might be implemented in the future).

Any layout evaluation in the context of OCR-D focusses on region level which should be sufficient for most use cases.

#### Reading Order (Definition)

Reading order describes the order in which segments on a page are intended to be read. While the reading order might be easily obtained in monographs with a single column where only a few page segments exist, identifying the reading order in more complex layouts (e.g. newspapers or multi-column layouts) can be more challenging.

Example of a simple page layout with reading order:

![A sample page in German Fraktur with a simple page layout showing the intended reading order](https://pad.gwdg.de/uploads/bc5258cb-bf91-479e-8a91-abf5ff8bbbfa.jpg)

(<http://resolver.sub.uni-goettingen.de/purl?PPN1726778096>)

Example of a complex page layout with reading order:

![A sample page in German Fraktur with a complex page layout showing the intended reading order](https://pad.gwdg.de/uploads/100f14c4-19b0-4810-b3e5-74c674575424.jpg)

(<http://resolver.sub.uni-goettingen.de/purl?PPN1726778096>)

See [Reading Order Evaluation](#reading-order-evaluation) for the actual metric.

#### IoU (Intersection over Union)

Intersection over Union is a term which describes the degree of overlap of two regions of a (document) image defined either by a bounding box or polygon. Example:

![A sample heading in German Fraktur illustrating a Ground Truth bounding box and a detected bounding box](https://pad.gwdg.de/uploads/62945a01-a7a7-48f3-86c2-6bb8f97d67fe.jpg)

(where green represents the Ground Truth and red the detected bounding box)

Given a region A with an area $area_1$, a region B with the area $area_2$, and their overlap (or intersection) $area_o$, the IoU can then be expressed as

$IoU = \frac{area_o}{area_1+area_2-area_o}$

where $area_1+area_2-area_o$ expresses the union of the two regions ($area_1+area_2$) while not counting the overlapping area twice.

The IoU ranges between 0 (no overlap at all) and 1 (the two regions overlap perfectly). Users executing object detection can choose a [threshold](#Threshold) that defines which degree of overlap must be given to define a prediction as correct. If e.g. a threshold of 0.6 is chosen, all prediction that have an IoU of 0.6 or higher are correct.

In OCR-D we use IoU to measure how well segments on a page are recognized during the segmentation step. The area of one region represents the area identified in the Ground Truth, while the second region represents the area identified by an OCR-D processor.

### Resource Utilization

Last but not least, it is important to collect information about the resource utilization of each processing step, so that informed decisions can be made when e.g. having to decide between results quality and throughput speed.

#### CPU Time

CPU time is the time taken by the CPU(s) on the processors. It does not include idle time, but does grow with the number of threads/processes.

#### Wall Time

Wall-clock time (or elapsed time) is the time taken on the processors including idle time but ignoring concurrency.

#### I/O

I/O (input / output) bandwith is the (average/peak) number of bytes per second read and written from disk during processing.

#### Memory Usage

Memory usage is the (average/peak) number of bytes the process allocates in memory (RAM), i.e. resident set size (RSS) or proportional set size (PSS).

#### Disk Usage

Disk usage is the total number of bytes the process reads and writes on disk.

### Unicode Normalization

In Unicode there can be multiple ways to express characters that have multiple components, such as a base letter and an accent. For evaluation it is essential that both Ground Truth and OCR results are normalized *in the same way* before evaluation.

For example, the letter `ä` can be expressed directly as `ä` (`U+00E4` in Unicode) or as a combination of `a` and `◌̈` (`U+0061 + U+0308`). Both encodings are semantically equivalent but technically different.

Unicode has the notion of *normalization forms* to provide canonically normalized text. The most common forms are *NFC* (Normalization Form Canonical Composed) and *NFD* (Normalization Form Canonical Decomposed). When a Unicode string is in NFC, all decomposed codepoints are replaced with their decomposed equivalent (e.g. `U+0061 + U+0308` to `U+00E4`). In an NFD encoding, all decomposed codepoints are replaced with their composed equivalents (e.g. `U+00E4` to `U+0061 + U+0308`).

<!-- There's also NFKC and NFKD - necessary to explain? -->

In accordance with the concept of [GT levels in OCR-D](https://ocr-d.de/en/gt-guidelines/trans/trLevels.html), it is preferable for strings to be normalized as NFC.

The Unicode normalization algorithms rely on data from the Unicode database on equivalence classes and other script- and language-related metadata. For graphemes from the Private Use Area (PUA), such as MUFI, this information is not readily available and can lead to inconsistent normalization. Therefore, it is essential that evaluation tools normalize PUA codepoints in addition to canonical Unicode normalization.

<!-- Reference to GT rules here? -->

### Metrics Not in Use Yet

The following metrics are not part of the MVP (minimal viable product) and will (if ever) be implemented at a later stage.

#### GPU Metrics

##### GPU Avg Memory

GPU avg memory refers to the average amount of memory of the GPU (in GiB) that was used during processing.

##### GPU Peak Memory

GPU peak memory is the maximum GPU memory allocated during the execution of a workflow in MB.

#### Text Evaluation

##### Letter Accuracy

Letter Accuracy is a metric that focusses on a pre-defined set of characters classes for evaluation while ignoring others.
Letters in a common sense do not include white spaces and punctuations or Arabic and Indic digits.
Furthermore, even letter capitalization might be ignored.
The relevant character classes must be removed from both the candidate text and the ground truth before evaluation.

Letter Accuracy can be calculated as follows:

Let $|L_{GT}|$ be the number of relevant letters in the ground truth, $|L_{r}|$ the number of recognized letters, then

$LA = 1 - \frac{|L_{GT}| - |L_{r}|}{|L_{GT}|}$

##### Flexible Character Accuracy Measure

The Flexible Character Accuracy (FCA) measure has been introduced to mitigate a major drawback of CER:
CER (if applied naively by comparing concatenated page-level texts) is heavily dependent on the reading order an OCR engine detects.
Thus, where text blocks are rearranged or merged, no suitable text alignment can be made, so CER is very low,
even if single characters, words and even lines have been perfectly recognized.

FCA avoids this by splitting the recognized text and GT into lines and, if necessary, sub-line chunks,
finding pairs that align maximally until only unmatched lines remain (which must be treated as errors),
and measuring average CER of all pairs.

The algorithm can be summarized as follows:

> 1. Split both input texts into text lines
> 2. Sort the GT lines by length  
>      (in descending order)
> 3. For the top GT line, find the best fully or partially matching OCR line  
>      (by lowest edit distance and highest coverage)
> 4. If full match (i.e. full length of line)
>     a. Mark as done and remove line from both lists
>     b. Else mark matching part as done,  
>         then cut off unmatched part and add to respective list of text lines; resort
> 5. If any more lines available repeat step 3
> 6. Count remaining unmatched lines as insertions or deletions (depending on origin – GT or OCR)
> 7. Calculate the (micro-)average CER of all marked pairs and return as overall FCER

(paraphrase of C. Clausner, S. Pletschacher and A. Antonacopoulos / Pattern Recognition Letters 131 (2020) 390–397, p. 392)

#### Layout Evalutation

##### Reading Order Evaluation

[Clausner, Pletschacher and Antonacopoulos 2013](https://www.primaresearch.org/www/assets/papers/ICDAR2013_Clausner_ReadingOrder.pdf) 
propose a method to evaluate reading order by classifying relations between any two regions:
direct or indirect successor / predecessor, unordered, undefined.

Next, text regions on both sides, ground truth and detected reading order, are matched and assigned (depending on overlap area). 
A GT region can have multiple corresponding detections. Then, for each pair of regions, the relation type
on GT is compared to the relation types of the corresponding predictions. Any deviation introduces costs,
depending both on the kind of relation (e.g. direct vs indirect, or successor vs predecessor)
and the relative size of the overlap.

The authors introduce a predefined penalty matrix where the cost for each misclassification is given.
(Direct opposition is more expensive than indirect.)

For example, if the relation given in GT is "somewhere after (but unordered group involved)",
but the detected relation is "directly before", then the penalty will be lower (`10`) than
if the GT relation is "directly after" (`40`) – because the latter is more specific than the former.

To calculate the success measure $s$ of the detected reading order, first the costs obtained from comparing all GT to all detected relations are summed up ($e$).
Then this error value is normalised by the hypothetical error value at 50% agreement ($e_{50}$):

$e_{50} = p_{max} * n_{GT} / 2$

where $p_{max}$ is the highest single penality and $n_{GT}$ is the number of regions in the ground truth.

The success measure is then given by

$s = \frac{1}{e * (1/e_{50}) + 1}$

##### mAP (mean Average Precision)

This score was originally devised for object detection in photo scenery (where overlaps are allowed and cannot conflict with text flow).
It is not adequate for document layout for various reasons, but since it is a standard metric in the domain of neural computer vision,
methods and tools of which are increasingly used for layout analysis as well, it is still somewhat useful for reference.

The following paragraphs will first introduce the intermediate concepts needed to define the mAP metric itself.

###### Precision and Recall

**Precision** describes to which degree the predictions of a model are correct.
The higher the precision of a model, the more confidently we can assume that each prediction is correct
(e.g. the model having identified a bicycle in an image actually depicts a bicycle).
A precision of 1 (or 100%) indicates all predictions are correct (true positives) and no predictions are incorrect (false positives). The lower the precision value, the more false positives.

In the context of object detection in images, it measures either

* the ratio of correctly detected segments over all detected segments
  (where *correct* is defined as having sufficient overlap with some GT segment), or
* the ratio of correctly segmented pixels over the image size  
  (assuming all predictions can be combined into some coherent segmentation).

**Recall**, on the other hand,  describes to which degree a model predicts what is actually present.
The higher the recall of a model, the more confidently we can assume that it covers everything to be found
(e.g. the model having identified every bicycle, car, person etc. in an image).
A recall of 1 (or 100%) indicates that all objects have a correct prediction (true positives) and no predictions are missing or mislabelled (false negatives). The lower the recall value, the more false negatives.

In the context of object detection in images, it measures either

* the ratio of correctly detected segments over all actual segments, or
* the ratio of correctly segmented pixels over the image size.

Notice that both goals are naturally conflicting each other. A good predictor needs both high precision and recall.
But the optimal trade-off depens on the application.

For layout analysis though, the underlying notion of sufficient overlap itself is inadequate:

* it does not discern oversegmentation from undersegmentation
* it does not discern splits/merges that are allowable (irrelevant w.r.t. text flow) or not (break up or conflate lines)
* it does not discern foreground from background, or when partial overlap starts breaking character legibility or introducing ghost characters

###### Prediction Score

Most types of model can output a confidence score alongside each predicted object,
which represents the model's certainty that the prediction is correct.
For example, when a model tries to identify ornaments on a page, if it returns a segment (polygon / mask)
with a prediction score of 0.6, the model asserts there is a 60% probability that there is an ornament at that location.
Whether this prediction is then considered to be a positive detection, depends on the chosen threshold.

###### IoU Thresholds

For object detection, the metrics precision and recall are usually defined in terms of a threshold for the degree of overlap
(represented by the IoU as defined [above](#iou-intersection-over-union)), ranging between 0 and 1)
above which pairs of detected and GT segments are qualified as matches.

(Predictions that are non-matches across all GT objects – false positives – and GT objects that are non-matches across all predictions – false negatives – contribute indirectly in the denominator.)

Example:
Given a prediction threshold of 0.8, an IoU threshold of 0.6 and a model that tries to detect bicycles in an image which depicts two bicycles.
The model returns two areas in an image that might be bicycles, one with a confidence score of 0.4 and one with 0.9. Since the prediction threshold equals 0.8, the first candidate gets immediately tossed out. The other
is compared to both bicycles in the GT. One GT object is missed (false negative), the other intersects the remaining prediction, but the latter is twice as large.
Therefore, the union of that pair is more than double the intersection. But since the IoU threshold equals 0.6, even the second candidate is not regarded as a match and thus also counted as false negative. Overall, both precision and recall are zero (becaue 1 kept prediction is a false positive and 2 GTs are false negatives).

###### Precision-Recall Curve

By varying the prediction threshold (and/or the IoU threshold), the tradeoff between precision and recall can be tuned.
When the full range of combinations has been gauged, the result can be visualised in a precision-recall curve (or receiver operator characteristic, ROC).
Usually the optimum balance is where the product of precision and recall (i.e. area under the curve) is maximal.

Given a dataset with 100 images in total of which 50 depict a bicycle. Also given a model trying to identify bicycles on images. The model is run 7 times using the given dataset while gradually increasing the threshold from 0.1 to 0.7.

| run | threshold | true positives | false positives | false negatives |precision | recall |
|-----|-----------|----------------|-----------------|-----------------|----------|--------|
| 1   | 0.1       |  50            | 25              | 0               | 0.66     | 1      |
| 2   | 0.2       |  45            | 20              | 5               | 0.69     | 0.9    |
| 3   | 0.3       |  40            | 15              | 10              | 0.73     | 0.8    |
| 4   | 0.4       |  35            | 5               | 15              | 0.88     | 0.7    |
| 5   | 0.5       |  30            | 3               | 20              | 0.91     | 0.6    |
| 6   | 0.6       |  20            | 0               | 30              | 1        | 0.4    |
| 7   | 0.7       |  10            | 0               | 40              | 1        | 0.2    |

For each threshold a pair of precision and recall can be computed and plotted to a curve:

![A sample precision/recall curve](https://pad.gwdg.de/uploads/2d3c62ff-cab4-4a12-8043-014fe0440459.png)

This graph is called Precision-Recall-Curve.

###### Average Precision

Average Precision (AP) describes how well (flexible and robust) a model can detect objects in an image,
by averaging precision over the full range (from 0 to 1) of confidence thresholds (and thus, recall results).
It is equal to the area under the Precision-Recall Curve.

![A sample precision/recall curve with highlighted area under curve](https://pad.gwdg.de/uploads/799e6a05-e64a-4956-9ede-440ac0463a3f.png)

The Average Precision can be computed with the weighted mean of precision at each confidence threshold:

$AP = \displaystyle\sum_{k=0}^{k=n-1}[r(k) - r(k+1)] * p(k)$

with $n$ being the number of thresholds and $r(k)/p(k)$ being the respective recall/precision values for the current confidence threshold $k$.

Example:
Given the example above, we get:

$$
\begin{array}{ll}
AP &  = \displaystyle\sum_{k=0}^{k=n-1}[r(k) - r(k+1)] * p(k) \\
& = \displaystyle\sum_{k=0}^{k=6}[r(k) - r(k+1)] * p(k) \\
& = (1-0.9) * 0.66 + (0.9-0.8) * 0.69 + \text{...} + (0.2-0) * 1\\
& = 0.878
\end{array}
$$

Usually, AP calculation also involves *smoothing* (i.e. clipping local minima) and *interpolation* (i.e. adding data points between the measured confidence thresholds).

###### Mean Average Precision

Mean Average Precision (mAP) is a metric used to measure the full potential of an object detector over various conditions.
AP is merely an average over confidence thresholds. But as [stated earlier](#iou-thresholds), the IoU threshold can be chosen freely,
so AP only reflects the performance under that particular choice. In general though, how accurately every object must be matched may depend on the use-case, and on the class or size of the objects.
That's why the mAP metric has been introduced: It is calculated by computing the AP over a range of IoU thresholds, and averaging over them:

$mAP = \displaystyle\frac{1}{N}\sum_{i=1}^{N}AP_i$ with $N$ being the number of thresholds.

Often, this mAP for a range of IoU thresholds gets complemented by additional mAP runs for a set of fixed values, or for various classes and object sizes only.
The common understanding is that those different measures collectively allow drawing better conclusions and comparisons about the model's quality.

##### Scenario-Driven Performance Evaluation

Scenario-driven, layout-dedicated, text-flow informed performance evaluation as described in
[Clausner et al., 2011](https://primaresearch.org/publications/ICDAR2011_Clausner_PerformanceEvaluation)
is currently the most comprehensive and sophisticated approach to evaluate the quality of layout analysis.

It is not a single metric, but comprises a multitude of measures derived in a unified method, which considers
the crucial effects that segmentation can have on text flow, i.e. which kinds of overlaps (merges and splits)
amount to benign deviations (extra white-space) or pathological ones (breaking lines and words apart).
In this approach, all the derived measures are aggregated under various sets of weights, called evaluation scenarios,
which target specific use cases (like headline or keyword extraction, linear fulltext, newspaper or figure extraction).

## Evaluation JSON schema

<!-- normative -->

The results of an evaluation should be expressed in JSON according to
the [`ocrd-eval.json`](https://ocr-d.de/en/spec/ocrd-eval.schema.json).

## Tools

See [OCR-D workflow guide](https://ocr-d.de/en/workflows#evaluation).

## References

* CER/WER:
  * <https://sites.google.com/site/textdigitisation/qualitymeasures>
  * <https://towardsdatascience.com/evaluating-ocr-output-quality-with-character-error-rate-cer-and-word-error-rate-wer-853175297510#5aec>
* IoU:
  * <https://medium.com/analytics-vidhya/iou-intersection-over-union-705a39e7acef>
* mAP:
  * <https://blog.paperspace.com/mean-average-precision/>
  * <https://jonathan-hui.medium.com/map-mean-average-precision-for-object-detection-45c121a31173>
* BoW:
  * <https://en.wikipedia.org/wiki/Bag-of-words_model>
* FCA:
  * <https://www.primaresearch.org/www/assets/papers/PRL_Clausner_FlexibleCharacterAccuracy.pdf>
* Letter Accuary:
  * <https://www.o-bib.de/bib/article/view/5888/8845>
* Reading Order Evaluation:
  * <https://www.primaresearch.org/www/assets/papers/ICDAR2013_Clausner_ReadingOrder.pdf>

* More background on evaluation of OCR
  * <https://doi.org/10.1145/3476887.3476888>
  * <https://doi.org/10.1515/9783110691597-009>
