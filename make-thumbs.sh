#!/bin/bash
#
# this is script 2 of 3
#
# set the location
THUMBSDIR=`pwd -P`
# first delete the old file
rm $THUMBSDIR/index_files/thumbs-url.list
# then make a new one
# the file "email-html.list" must be generated first by the "check-index-list.sh" script
# we're using THUMBSDIR to mask the actual directory location and to aid in portability
# the sed instruction below 's|.{40}|...' simply swaps the first 40 characters from each
# line with the domain and will need to be changed if the HTML files' location changes

# thumbs-url.list will be used to create the main index file.
while read line
  do echo $line | sed -r 's|.{40}|dev-misc.peets.com|' >> $THUMBSDIR/index_files/thumbs-url.list
done < $THUMBSDIR/index_files/email-html.list

echo "main file done"

# split the url list up into smaller files based on year 
awk -F, '/EMAIL_2015/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2015.list
awk -F, '/EMAIL_2014/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2014.list
awk -F, '/EMAIL_2013/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2013.list
awk -F, '/EMAIL_2012/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2012.list
awk -F, '/EMAIL_2011/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2011.list

echo "mini files done!"

# then run the thumbs command on the mini lists
# for i in $THUMBSDIR/index_files/2015.list $THUMBSDIR/index_files/2014.list $THUMBSDIR/index_files/2013.list $THUMBSDIR/index_files/2012.list $THUMBSDIR/index_files/2011.list
#while read LINE1
#  do
# Only make thumbs for those HTML files modified within the last 30 days.
    while read SERVERURLS
      do
        if test ! `find $SERVERURLS -mtime +30` 
        then
          echo "Rendering thumbs for" $SERVERURLS
          WEBURLS=$(sed -r 's|.{40}|dev-misc.peets.com|' <<< $SERVERURLS)
          phantomjs $THUMBSDIR/render_multi_url_email_thumbs.js $WEBURLS
        fi
      done < $THUMBSDIR/index_files/email-html.list
#      done

echo "PNGs made"

for i in $THUMBSDIR/images/*.png
  do
    if test ! `find $i -mtime +1` 
      then
        convert $i -resize 250 $i.jpg
    fi
  done

echo "JPGs made"

exit 0
