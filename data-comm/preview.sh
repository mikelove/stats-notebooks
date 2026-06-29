#!/usr/bin/env bash
set -euo pipefail

bash make-exercise.sh
quarto preview tidy-data-exercise.qmd
