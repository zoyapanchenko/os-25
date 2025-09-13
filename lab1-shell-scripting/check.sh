#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <variant_number> <student_script.sh>"
    exit 1
fi

variant=$1
student_script=$2
output_tmp="./student_output.txt"
expected="expected_outputs/variant${variant}.txt"

./setup.sh > /dev/null

if [ ! -x "$student_script" ]; then
    echo "Error: student script not found or not executable."
    exit 1
fi

case $variant in
  1) /bin/bash "$student_script" testdata "file1" > "$output_tmp" ;;
  2) /bin/bash "$student_script" testdata "log" > "$output_tmp" ;;
  3) /bin/bash "$student_script" testdata "file" > "$output_tmp" ;;
  4) /bin/bash "$student_script" testdata "start" > "$output_tmp" ;;
  5) /bin/bash "$student_script" testdata > "$output_tmp" ;;
  6) /bin/bash "$student_script" testdata > "$output_tmp" ;;
  *)
    echo "Unknown variant"
    exit 1
    ;;
esac

if diff -q "$expected" "$output_tmp" > /dev/null; then
    echo "✅ OK"
else
    sort "$expected" > expected_sorted.tmp
    sort "$output_tmp" > output_sorted.tmp
    if diff -q expected_sorted.tmp output_sorted.tmp > /dev/null; then
        echo "⚠️ Wrong order"
    else
        echo "❌ Wrong result"
    fi
    rm -f expected_sorted.tmp output_sorted.tmp
fi

rm -f "$output_tmp"
