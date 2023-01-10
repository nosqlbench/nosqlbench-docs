#!/bin/bash

# This script takes a zip file named exported_docs.zip, containing exported
# markdown from the main NoSQLBench build as input.
# This zip file is produced by running "nb5 export-docs"
#
# Each top-level directory in this zip file correspondes to a specific subsection
# in the docs site structure. There is also another directory in this repo called
# _import_overlays. The _import_overlays directory controls how files are
# unfurled from the exported_docs.zip file into the main site/content directory.
#
# Here are the basic rules:
# 1. The exported docs are unzipped into a directory called import/.
# 2. For each top-level directory $name in the import directory,
#    IF and ONLY IF there exists a same-named directory for it
#    under _import_overlays/$name, then
#    1. The contents of  _import_overlays/$name are copied into
#       the import/$name directory.
#    2. The contents of the named import directory are then transferred
#       (with deletions) to the same-named path under site/content/$name.
#
# Error handling:
# If any base directory in the zip file does not have a skel directory, then
# it is gracefully skipped over, *however* a warning is sent to stderr so that
# this can be diagnosed in build logs.

#set -x
rm -rf import
unzip -l exported_docs.zip
unzip exported_docs -d import

for dirname in $(ls import); do
 skeldir="_import_overlays/$dirname"
 importdir="import/$dirname"
 printf "dirname:%s importdir:%s skeldir:%s\n" ${dirname} ${importdir} ${skeldir}
 if [ -d ${skeldir} ]
 then
  rsync -av $skeldir/ $importdir/
  rsync -av --delete $importdir/ site/content/$dirname/
 else
  printf "docs for $dirname were not deployed due to a missing skel template\n" 1>&2
 fi
done
