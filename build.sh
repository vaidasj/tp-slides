#!/bin/bash

# remove existing output files
rm -rf slides/
mkdir slides

# generate html slides and pdfs
for file_path in src/*.md; do
    slide=$(basename "$file_path" .md)
    markdown-to-slides -d "$file_path"  -o slides/"$slide".html -s template/style.css -l template/template.html
#    markdown-pdf -o pdf/"$slide".pdf $file_path
    slide_index="$slide_index \"$slide\", "
done

# write index json file
echo "{ \"slides\": [$slide_index] }" | sed 's/\(.*\),/\1 /' >> slides/index.json

# copy images
mkdir slides/images
cp images/* slides/images/
