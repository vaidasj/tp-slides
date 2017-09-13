#!/bin/bash

slide=$(basename "$1" .md).html

rm -rf tmp/
mkdir tmp
mkdir tmp/images
cp images/* tmp/images

markdown-to-slides -d "$1"  -o tmp/"$slide" -s template/style.css -l template/template.html -w
