#!/bin/bash
# Loop through PNGs in the $THUMBSDIR,
# test for date, return string "new" for files more recent than a week old.
# 
#
THUMBSDIR=`pwd -P`
i=$THUMBSDIR/index_files/email-html.list
while read LINE
  do
    if test ! `find $LINE -mtime +30` 
    then
      echo $LINE
    fi
  done < $i
