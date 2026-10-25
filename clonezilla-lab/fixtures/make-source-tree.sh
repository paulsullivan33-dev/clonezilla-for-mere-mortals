#!/bin/sh
# Build the lab's practice filesystem: a directory of invented
# files, then an ext4 filesystem inside an ordinary file,
# populated by mkfs.ext4 -d. No loop device, no mount.
# Usage: sh make-source-tree.sh [workdir]
set -e
cd "${1:-.}"

mkdir -p src-tree/documents src-tree/data
printf 'Field notes for the workshop inventory project.\nEverything in this image is invented for practice.\n' > src-tree/readme.txt
printf '# Spare parts manual\n\nKeep the torque wrench in the blue cabinet.\nOil the press every second Friday.\n' > src-tree/documents/manual.md
printf 'day,temperature_c,pressure_kpa\n1,21.4,101.2\n2,22.1,101.0\n3,20.8,100.7\n' > src-tree/data/measurements.csv
head -c 1048576 /dev/urandom > src-tree/data/blob.bin
head -c 2097152 /dev/zero    > src-tree/data/zeros.bin
touch src-tree/data/empty.txt

truncate -s 64M src.img
mkfs.ext4 -q -F -L FIELDNOTES -d src-tree src.img
echo "src.img: 64 MiB ext4 filesystem, label FIELDNOTES"
