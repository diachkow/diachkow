#!/usr/bin/env bash

set -euo pipefail

input_file="${1:-CV.md}"
output_file="${2:-${input_file%.*}.pdf}"
generated_file="${input_file%.*}.pdf"
pdf_options='{"format":"A4","printBackground":true,"margin":{"top":"16mm","right":"14mm","bottom":"16mm","left":"14mm"}}'

if [[ ! -f "$input_file" ]]; then
  printf 'Input file not found: %s\n' "$input_file" >&2
  exit 1
fi

if ! command -v bunx >/dev/null 2>&1; then
  printf 'Need bunx (Bun) to build the PDF.\n' >&2
  exit 1
fi

bunx md-to-pdf "$input_file" --pdf-options "$pdf_options"

if [[ "$generated_file" != "$output_file" ]]; then
  cp "$generated_file" "$output_file"
fi

printf 'Wrote %s\n' "$output_file"
