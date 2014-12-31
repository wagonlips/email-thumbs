#!/bin/bash
# set the location
THUMBSDIR=`pwd -P`
# first delete the old file
rm $THUMBSDIR/index_files/thumbs-url.list
# then make a new one
while read line
  do echo $line | sed 's|$THUMBSDIR/|dev-misc.peets.com/|' >> $THUMBSDIR/index_files/thumbs-url.list
done < $THUMBSDIR/index_files/email-html.list

echo "main file done"

# split the url list up into smaller files based on year 
awk -F, '/EMAIL_2015/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2015.list
awk -F, '/EMAIL_2014/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2014.list
awk -F, '/EMAIL_2013/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2013.list
awk -F, '/EMAIL_2012/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2012.list
awk -F, '/EMAIL_2011/' $THUMBSDIR/index_files/thumbs-url.list > $THUMBSDIR/index_files/2011.list

echo "mini files done!"
exit 0

# then run the thumbs command on the mini lists
while read LINE
  do phantomjs $THUMBSDIR/render_multi_url_email_thumbs.js $LINE
done < $THUMBSDIR/index_files/thumbs-url.list

exit 0
