#!/bin/bash
THUMBSDIR=`pwd -P`
find $THUMBSDIR/ -name \*.html | sort -r | sed '1d' > /tmp/current-html.list

# check for changes in directory structure
if diff /tmp/current-html.list $THUMBSDIR/index_files/email-html.list >/dev/null
  then 
# if Same
# then quit
    exit
  else
# if Different
# then write the new list over the old and make a new index file
    cp /tmp/current-html.list $THUMBSDIR/index_files/email-html.list
#   here a script to write the new index file will be

fi

# record the modification times of each file
while read line
  do echo $(stat -c %Y-%n $line) >> $THUMBSDIR/file-times.list
done < $THUMBSDIR/index_files/email-html.list
