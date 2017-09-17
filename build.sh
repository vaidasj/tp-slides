#!/bin/bash

# remove existing output files
rm -rf slides/

# create output directory
mkdir slides

# generate html slides
for file_path in src/*.md; do
    slide="$(basename "$file_path" .md).html"
    first_line=$(head -n 1 $file_path)
    markdown-to-slides -d "$file_path"  -o slides/"$slide" -s template/style.css -l template/template.html
    slide_index="$slide_index { \"file\": \"$slide\", \"name\": \"${first_line:2}\" }, "
done

# write index json file
echo "{ \"slides\": [$slide_index] }" | sed 's/\(.*\),/\1 /' >> slides/index.json

# copy images
mkdir slides/images
cp images/* slides/images/
