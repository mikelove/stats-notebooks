---
title: "Exploratory EDA Notebook — Question Answers"
format:
  html:
    embed-resources: true
    toc: true
---

**1.** How many experiments do you spot per cell line donor?

4 experiments per donor, corresponding to the four conditions: naive (N), IFNγ (I), Salmonella (S), and IFNγ + Salmonella (I+S).

---

**2.** How would you describe the distribution of the different numeric columns in the peaks table? Do these distributions make sense?

The `start` and `end` columns are chromosomal coordinates, so they increase monotonically across the first 1,000 regions of chromosome 1 — roughly spanning some contiguous window. The `percentage_gc_content` column is likely roughly normally distributed, centered around 40–60%, reflecting the GC content of open-chromatin peaks (regulatory elements). These distributions make sense: positions are ordered along the chromosome, and GC content is relatively consistent across ATAC-seq peaks.

---

**3.** What is a typical value for `assigned_frac`? For a typical sample, are most observations within the peaks?

Typical ATAC-seq assigned fractions are around 0.3–0.5 (30–50%). So for most samples, fewer than half the reads fall within called peaks. This is expected: peaks cover only a small fraction of the genome, so much of the sequencing depth lands in non-peak regions.

---

**4.** What is the general number of peaks for a typical sample? Is the distribution left or right skewed? What is a typical value for `assigned`?

___ (need actual skim output to give specific values). In typical ATAC-seq, `assigned` (total fragments in peaks) is in the hundreds of thousands. The distribution of `peak_count` is often right-skewed, with most samples having a similar moderate count but a tail of high-outlier samples. The distribution of `assigned` is similarly right-skewed.

---

**5.** What is a typical value for the column sum of the counts matrix?

___ (need actual ecdf plot values). Given we are looking at only 1,000 peaks (a small subset), column sums in thousands would be well below typical whole-genome totals.

---

**6.** What do you notice about the row sum in contrast to the column sum? Any outliers?

Row sums are far more variable than column sums. Column sums are relatively consistent across samples (total library size is similar), but row sums vary enormously: some peaks are highly accessible across all samples while many have very few counts. The row sum ecdf likely has a long right tail, indicating a few outlier peaks with very high total accessibility across all samples.

---

**7.** What's a typical value for the row sum?

___ (need actual xlim-zoomed ecdf). The zoomed plot with `xlim=c(0,10)` suggests most peaks have row sums between roughly 1,000 and 5,000 total counts across all samples, with a median probably around 1,000–3,000.

---

**8.** Check out the possible geoms. Try different plots for various columns in `coldata`.

Open-ended exercise. Useful options include: `geom_boxplot` or `geom_violin` for numeric by condition, `geom_bar` for categorical columns, `geom_density` for distributions, `geom_point` for scatterplots of numeric pairs. Students should note how condition separates `assigned` and `peak_count`.

---

**9.** Advanced: try using a different smoothing method.

Alternatives include `method = "loess"` (local polynomial, captures non-linear trends), `method = "gam"` (generalized additive model, similar to loess but uses splines), or `method = "glm"` with a family argument. Using `loess` would reveal curved relationships that a linear `lm` would miss.

---

**10.** What could you say about the first six samples in terms of these plots? And the alignment-check question for omics-familiar readers.

The first six samples likely show highly similar distributions (overlapping histograms, similar QQ shapes) and high pairwise correlations (>0.9), consistent with technical replicates or samples from similar conditions. For checking alignment across RNA-seq and ATAC-seq: identify peaks overlapping gene promoters (e.g., within 2 kb of the TSS), extract accessibility counts for those peaks, and correlate with expression values for the same gene — in the same sample. Open promoters should correlate positively with gene expression. Steps: (1) load gene annotation, (2) find overlaps between peaks and promoter windows, (3) match samples by ID across the two matrices, (4) compute per-gene Pearson or Spearman correlation between accessibility and expression.

---

**11.** What do you observe in the PCA plot colored by sample condition?

Samples cluster strongly by condition. The naive condition forms a distinct cluster separated from immune-stimulated samples along PC1 or PC2. The combined IFNγ+Salmonella treatment likely shows the most extreme separation from naive. IFNγ-only and Salmonella-only conditions fall between naive and the combined treatment. This indicates that the dominant source of variation in chromatin accessibility is immune stimulation, not donor-to-donor differences.

---

**12.** What pattern does PC1 represent across these highlighted peaks?

PC1 captures immune-responsive chromatin remodeling. Peaks with high PC1 loading are more accessible in stimulated conditions (especially IFNγ+SL1344) and less accessible in naive cells. These peaks likely correspond to enhancers or regulatory elements activated during immune response. The plotCounts panels should show increasing counts from naive to SL1344 to IFNγ to IFNγ+SL1344 (or some similar ordering reflecting stimulation).

---

**13.** Why would it be useful to always work with data that has a specified genome with chromosome lengths?

Without chromosome lengths: (1) tiles or sliding windows can extend past chromosome ends, producing invalid ranges; (2) tools that compute enrichment relative to background (e.g., overlap permutation tests) cannot know the total genomic space; (3) liftover to a different genome build requires knowing the source coordinates are valid; (4) genome browsers and visualization tools need chromosome sizes to properly frame the data. Having `seqinfo` prevents silent bookkeeping errors in downstream genomic arithmetic.

---

**14.** Is there any relationship between GC content (`gc`) and contribution to PC1 in tiles?

There may be a weak positive association, since regulatory elements (immune-responsive enhancers) tend to be GC-rich, and these are the peaks driving PC1. However, GC content also varies for many other reasons (gene density, replication timing, etc.). A scatterplot of tile-level mean GC vs `sum_pc1` would be needed to assess this concretely. Any observed relationship could also reflect a technical artifact (GC bias in ATAC-seq library preparation).
