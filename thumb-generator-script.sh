#!/bin/bash
#
# Set the location.
THUMBSDIR=`pwd -P`
echo $THUMBSDIR
# Check for changes in directory.
if [[ -n $(find $THUMBSDIR -mtime -14 -name \*.html) ]]
# If new files are found then write the new list over the old.
then
  find $THUMBSDIR/ -name \*.html | sort -r | sed '/index.html/d' > $THUMBSDIR/index_files/email-html.list
else
# Otherwise, exit.
  exit 0
fi

# delete the old file
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

# Only make thumbs for those HTML files modified within the last 30 days.
while read SERVERURLS
  do
    if test ! `find $SERVERURLS -mtime +5` 
    then
      echo "Rendering thumbs for" $SERVERURLS
      WEBURLS=$(sed -r 's|.{40}|dev-misc.peets.com|' <<< $SERVERURLS)
      phantomjs $THUMBSDIR/render_multi_url_email_thumbs.js $WEBURLS
    fi
  done < $THUMBSDIR/index_files/email-html.list

echo "PNGs made"

# Convert PNGs to JPGs
for i in $THUMBSDIR/images/*.png
  do
    if test ! `find $i -mtime +1` 
      then
        convert $i -resize 250 $i.jpg
    fi
  done

echo "JPGs made"

cat > index.html <<INDEX_HEAD
<!DOCTYPE html>
<html>
<head>
<title>Peet&rsquo;s Coffee &amp; Tea E-Commerce Marketing Emails</title>
<style type="text/css">
.year-container {border:1px solid green;}
.thumb {float:left;text-align:center;}
.hidden {display:none;}
.visible {display:block;}
#t-2011-list {border:1px solid red;}
#t-2012-list {border:1px solid blue;}
#t-2013-list {border:1px solid pink;}
#t-2014-list {border:1px solid yellow;}
#t-2015-list {border:1px solid orange;}
</style>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
INDEX_HEAD

for i in index_files/2015.list index_files/2014.list index_files/2013.list index_files/2012.list index_files/2011.list
  do
    echo "<div class=\"year-container\" id=\"c-`basename $i | tr "." "-"`\"> `basename $i`" >> index.html
    echo "<div id=\"t-`basename $i | tr "." "-"`\">" >> index.html
    while read line
      do 
        caption=$(basename $line)
        thumb_url="$(echo $line | tr "/" "_").png.jpg"
cat >> index.html <<INDEX_BODY
<div class="thumb">
  <div class="caption">$caption</div>
  <a href="http://$line"><img src="images/$thumb_url" width="250" alt="" /></a>
</div>
INDEX_BODY
      done < $i
    echo "<div style=\"clear:both;\">&nbsp;</div>" >> index.html
    echo "</div>" >> index.html
    echo "</div>" >> index.html
  done
cat >> index.html <<INDEX_FOOT
<script>
jQuery.noConflict();
jQuery('#c-2011-list').click(function()  {
  if (jQuery('#t-2011-list').css('display')=='none'){
    jQuery('#t-2011-list').css('display', 'block');
  } else {
    jQuery('#t-2011-list').css('display', 'none');
  }
}); 
</script>
</body>
</html>
INDEX_FOOT

echo "All done!"

exit 0
