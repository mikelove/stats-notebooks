# statistics lectures as notebooks

Originally prepared as part of UBDS^3 in July 2025.

## Notebooks

| Notebook | Description |
|---|---|
| `randomness/randomness.qmd` | Estimation, bias, sampling variance, statistical power |
| `randomness/randomness_and_linear.qmd` | Linear models, OLS, ANOVA, bootstrapping |
| `exploratory/exploratory.qmd` | EDA on genomics data, ggplot2, PCA, SummarizedExperiment |
| `data-comm/tidy-data.qmd` | Interactive: tidy data, pivot, dplyr (runs R in the browser) |

## Requirements

### Interactive notebook (`data-comm/`)

Only [Quarto](https://quarto.org/docs/get-started/) is required — R runs in the browser via WebAssembly ([quarto-live](https://r-wasm.github.io/quarto-live/)).

Install the extension once inside the directory:

```bash
cd data-comm && quarto add r-wasm/quarto-live
```

`tidy-data.qmd` is the editable source file (standard `{r}` chunks, works in Positron/RStudio). To preview the interactive version, run:

```bash
cd data-comm && ./preview.sh
```

This generates `tidy-data-exercise.qmd` (with `{webr}` chunks) and opens it in the browser. The exercise file is gitignored.

### Static notebooks (`randomness/`, `exploratory/`)

Requires Quarto and a local R installation with the relevant packages (see `CLAUDE.md` for the full package list).

```bash
quarto preview randomness/randomness.qmd
```
