#!/bin/bash

# remove existing output files
rm -f slides/*

# generate html slides
for file_path in src/*.md; do
    slide=$(basename "$file_path" .md).html
    markdown-to-slides -d "$file_path"  -o slides/"$slide" -s template/style.css -l template/template.html
    slide_index="$slide_index \"$slide\", "
done

# write index json file
echo "{ \"slides\": [$slide_index] }" | sed 's/\(.*\),/\1 /' >> slides/index.json

# copy images
mkdir slides/images
cp images/* slides/images/
