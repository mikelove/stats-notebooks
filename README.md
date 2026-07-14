# statistics lectures as notebooks

Originally prepared as part of UBDS^3 in July 2025.

## Notebooks

| Notebook | Description |
|---|---|
| `randomness/randomness.qmd` | Estimation, bias, sampling variance, statistical power |
| `randomness/randomness_and_linear.qmd` | Linear models, OLS, ANOVA, bootstrapping |
| `exploratory/exploratory.qmd` | EDA on genomics data, ggplot2, PCA, SummarizedExperiment |
| `tidy-data/tidy-data.qmd` | Interactive: tidy data, pivot, dplyr (runs R in the browser) |

## Requirements

### Interactive notebook (`tidy-data/`)

Only [Quarto](https://quarto.org/docs/get-started/) is required — R runs in the browser via WebAssembly ([quarto-live](https://r-wasm.github.io/quarto-live/)).

Install the extension once inside the directory:

```bash
cd tidy-data && quarto add r-wasm/quarto-live
```

`tidy-data.qmd` is the editable source file (standard `{r}` chunks, works in Positron/RStudio). To preview the interactive version, run:

```bash
cd tidy-data && ./preview.sh
```

This generates `tidy-data-exercise.qmd` (with `{webr}` chunks) and opens it in the browser. The exercise file is gitignored.

To view the rendered exercise file locally without `preview.sh`, serve it over HTTP (the webR runtime does not work with `file://` URLs):

```bash
cd tidy-data
quarto render tidy-data-exercise.qmd
python3 -m http.server 8000
```

Then open `http://localhost:8000/tidy-data-exercise.html` in a browser.

To share the exercise publicly, render the file, then drag a folder containing both `tidy-data-exercise.html` and the `tidy-data-exercise_files/` directory onto [netlify.com/drop](https://app.netlify.com/drop). Netlify will prompt you to rename the HTML to `index.html`; accept this. Netlify serves it over HTTPS and provides a shareable URL; no account required.

### Static notebooks (`randomness/`, `exploratory/`)

Requires Quarto and a local R installation with the relevant packages (see `CLAUDE.md` for the full package list).

```bash
quarto preview randomness/randomness.qmd
```
