#!/bin/bash

rm -rf testdata
mkdir -p testdata

mkdir -p testdata/alpha testdata/beta testdata/gamma/subgamma

echo "111" > testdata/alpha/file1.txt
echo "22222" > testdata/alpha/file2.log
echo "3333333" > testdata/beta/file1.log
echo "4444444444" > testdata/beta/another.txt
echo "555" > testdata/gamma/subgamma/start_file.txt
echo "666666" > testdata/gamma/subgamma/start_other.log

touch -a -t 202509010101 testdata/alpha/file1.txt
touch -a -t 202509020202 testdata/alpha/file2.log
touch -a -t 202509030303 testdata/beta/file1.log
touch -a -t 202509040404 testdata/beta/another.txt
touch -a -t 202509050505 testdata/gamma/subgamma/start_file.txt
touch -a -t 202509060606 testdata/gamma/subgamma/start_other.log