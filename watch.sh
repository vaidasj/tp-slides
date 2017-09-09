#!/bin/bash

slide=$(basename "$1" .md).html
markdown-to-slides -d "$1"  -o tmp/"$slide" -s template/style.css -l template/template.html -w
