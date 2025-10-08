#!/usr/bin/env bash
set -euo pipefail

# Використання: ./my_solution.sh <DIR> <SUBSTRING>

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <directory> <substring>" >&2
  exit 1
fi

dir="$1"
substring="$2"

if [ ! -d "$dir" ]; then
  echo "Error: '$dir' is not a directory" >&2
  exit 2
fi

# Функція для отримання розміру у байтах
get_size() {
  if stat --version >/dev/null 2>&1; then
    stat -c %s -- "$1"
  else
    stat -f %z -- "$1"
  fi
}

# Пошук файлів, які містять рядок у назві
{
  while IFS= read -r -d '' file; do
    size="$(get_size "$file" || echo 0)"
    printf '%s\t%s\n' "$size" "$file"
  done < <(find "$dir" -type f -name "*$substring*" -print0)
} | sort -n -k1,1 | cut -f2-
