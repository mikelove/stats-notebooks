#!/usr/bin/env bash
set -euo pipefail

SRC="randomness.qmd"
DST="randomness-exercise.qmd"

awk '
BEGIN { yaml_count = 0 }

/^---$/ {
  yaml_count++
  print
  if (yaml_count == 2) {
    print ""
    print "{{< include ./_extensions/r-wasm/live/_knitr.qmd >}}"
    print "{{< include ./_extensions/r-wasm/live/_gradethis.qmd >}}"
  }
  next
}

/^  html:$/                   { print "  live-html:"; next }
/^    embed-resources: true$/ { next }
/^params:/                    {
  print "webr:"
  print "  packages:"
  print "    - palmerpenguins"
  print $0; next
}
/^```\{r\}$/                  { print "```{webr}"; next }
/^```\{r /                    { sub(/^```\{r /, "```{webr "); print; next }
/^#\| eval: false$/           { next }

{ print }
' "$SRC" > "$DST"

echo "Created $DST"
