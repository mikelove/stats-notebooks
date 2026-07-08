#!/usr/bin/env bash
set -euo pipefail

bash make-exercise.sh
quarto preview randomness-exercise.qmd
