# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Git

Do not offer to commit changes. The user will commit when ready.

## What this is

Statistics lecture notebooks prepared for UBDS³ (July 2025), authored by Michael Love. All notebooks are Quarto (`.qmd`) documents with embedded R code, licensed CC-BY.

## Rendering notebooks

**Static notebooks** (`randomness/`, `exploratory/`):

```bash
quarto render randomness/randomness.qmd
quarto render randomness/randomness_and_linear.qmd
quarto render exploratory/exploratory.qmd
```

Rendered HTML files are gitignored. To preview while editing:

```bash
quarto preview randomness/randomness.qmd
```

**Interactive notebook** (`data-comm/`): requires the `quarto-live` extension. Install once from inside the directory:

```bash
cd data-comm && quarto add r-wasm/quarto-live
```

`tidy-data.qmd` is the source file — it uses standard `{r}` chunks and renders as a plain HTML notebook. It is editable in Positron/RStudio. To preview the interactive (webR) version:

```bash
cd data-comm && ./preview.sh
```

`preview.sh` calls `make-exercise.sh`, which generates `tidy-data-exercise.qmd` by swapping `{r}` → `{webr}`, restoring the `live-html` format and `webr: packages:` YAML, adding the gradethis include lines, and removing `#| eval: false` from student exercise chunks. Then it runs `quarto preview` on the generated file. `tidy-data-exercise.qmd` is gitignored.

## Notebook structure

### Static notebooks (`randomness/`, `exploratory/`)

Shared YAML conventions:

- `format: html` with `embed-resources: true` — standalone HTML, no external dependencies
- `params: skip_execution / skip_answers` — not yet fully wired up
- `code-tools: true` — toolbar for toggling code visibility

### Variable definitions in `tidy-data.qmd`

Never redefine a variable (e.g. `counts_wide`, `counts_long`) that is already defined earlier in the script. quarto-live uses a shared compute environment across chunks, so libraries loaded and variables defined in earlier chunks are available inside exercise chunks. Setup chunks (`#| setup: true`) do not need to reload libraries or redefine variables.

### Interactive notebook (`data-comm/tidy-data.qmd`)

The source file uses standard `{r}` chunks and `format: html` so it works in any editor. `make-exercise.sh` transforms it into `tidy-data-exercise.qmd` for the browser using [`quarto-live`](https://r-wasm.github.io/quarto-live/). The generated file differs from the source in these ways:

- `{r}` → `{webr}` on all chunk fences
- `html:` → `live-html:` in the YAML format key; `embed-resources: true` is dropped
- `webr: packages:` block added to YAML (dplyr, tidyr, palmerpenguins)
- Two gradethis include lines added after the YAML front matter
- `#| eval: false` removed from student exercise chunks (those chunks have unparseable `______` placeholders)

**gradethis exercise pattern** — four blocks per exercise (in the generated file):

1. Setup block: ` ```{webr} ` with `#| exercise: name` + `#| setup: true`
2. Student block: ` ```{webr} ` with `#| exercise: name` (contains `______` placeholders)
3. Solution div: `::: {.solution exercise="name"}` containing a ` ```{webr} ` block with `#| solution: true`
4. Check block: ` ```{webr} ` with `#| exercise: name` + `#| check: true`, body is `gradethis::grade_this_code()`

## Data path note

The exploratory notebook reads data via `here("labs/exploratory/counts.txt.gz")`. The `here` package resolves paths from the project root (where `.git` lives). This means the notebook expects to run within a parent project where this repo is mounted at `labs/`, not directly from the repo root. If running the exploratory notebook standalone, either adjust those `here()` calls to `here("exploratory/counts.txt.gz")` or create a symlink `labs -> .` at the repo root.

## Notebook summaries

- **`randomness/randomness.qmd`** — Covers estimation, bias, and sampling variance via R simulations (`rnorm`, `replicate`, `lapply`/`sapply`). Demonstrates how estimate variance scales with sample size and data variance, and introduces statistical power.

- **`randomness/randomness_and_linear.qmd`** — Covers the linear model (OLS derivation via calculus and geometry), properties of $\hat{\beta}$, effects of correlated predictors, ANOVA, and bootstrapping. Uses `lm()`, `broom`, `mvtnorm`, and `car::Boot`.

- **`exploratory/exploratory.qmd`** — Walks through EDA on a genomics dataset (Alasoo et al. 2018 ATAC-seq/RNA-seq). Covers data import, `skim`/`glimpse`, ggplot2, PCA, and organizing data into `SummarizedExperiment` objects. Uses Bioconductor packages: `DESeq2`, `SummarizedExperiment`, `plyranges`, `nullranges`.

- **`data-comm/tidy-data.qmd`** — Interactive notebook on tidy data principles and tidyverse wrangling (`pivot_longer`, `pivot_wider`, `dplyr` verbs). Uses `quarto-live` + `gradethis` for in-browser exercises with auto-grading.

## Key R packages

| Topic | Packages |
|---|---|
| Simulation | base R (`rnorm`, `replicate`), `mvtnorm` |
| Linear models | `lm`, `broom`, `car` |
| Tabular data | `tibble`, `dplyr`, `tidyr`, `readr`, `here` |
| Visualization | `ggplot2`, `DataExplorer`, `skimr` |
| Bioconductor | `SummarizedExperiment`, `DESeq2`, `plyranges`, `nullranges`, `plyxp`, `tidySummarizedExperiment`, `iSEE` |
| Missing data | `naniar` |
| Interactive exercises | `quarto-live` (extension), `gradethis` |
