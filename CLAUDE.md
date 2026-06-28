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

Then render or preview normally:

```bash
quarto render data-comm/tidy-data.qmd
quarto preview data-comm/tidy-data.qmd
```

## Notebook structure

### Static notebooks (`randomness/`, `exploratory/`)

Shared YAML conventions:

- `format: html` with `embed-resources: true` — standalone HTML, no external dependencies
- `params: skip_execution / skip_answers` — not yet fully wired up
- `code-tools: true` — toolbar for toggling code visibility

### Interactive notebook (`data-comm/tidy-data.qmd`)

Uses the [`quarto-live`](https://r-wasm.github.io/quarto-live/) extension, which runs R in the browser via WebAssembly (webR). Key differences from static notebooks:

- Format is `live-html` (not `html`); `embed-resources` is omitted
- Packages for the browser runtime are declared under `webr: packages:` in the YAML
- Interactive code blocks use ` ```{webr} ` instead of ` ```{r} `
- Two include lines after the YAML header wire up gradethis grading:
  ```
  {{< include ./_extensions/r-wasm/live/_knitr.qmd >}}
  {{< include ./_extensions/r-wasm/live/_gradethis.qmd >}}
  ```

**gradethis exercise pattern** — four blocks per exercise:

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
