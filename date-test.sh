#!/bin/bash
# Loop through PNGs in the $THUMBSDIR,
# test for date, return string "new" for files more recent than a week old.
# 
#
THUMBSDIR=`pwd -P`
i=$THUMBSDIR/index_files/2015.list
    while read LINE
      do echo $LINE
      done < $i
