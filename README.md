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

Install the extension once inside the directory, then render or preview:

```bash
cd data-comm && quarto add r-wasm/quarto-live
quarto preview data-comm/tidy-data.qmd
```

### Static notebooks (`randomness/`, `exploratory/`)

Requires Quarto and a local R installation with the relevant packages (see `CLAUDE.md` for the full package list).

```bash
quarto preview randomness/randomness.qmd
```
