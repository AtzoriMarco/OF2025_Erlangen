#!/bin/bash

for file in $(find . -type f -name "yPlus*"); do
    echo "Processing $file"
    sed -i 's/\[\];/[0 0 0 0 0 0 0];/g' "$file"
done



