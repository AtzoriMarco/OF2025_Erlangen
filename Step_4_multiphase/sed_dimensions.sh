#!/bin/bash

for file in $(find . -type f -name "alpha.*"); do
    echo "Processing $file"
    sed -i 's/\[\];/[0 0 0 0 0 0 0];/g' "$file"
done



