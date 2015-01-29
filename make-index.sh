#!/bin/bash
#
# this is script 3 of 3
#
cat > index.html <<INDEX_HEAD
<!DOCTYPE html>
<html>
<head>
<title>Peet&rsquo;s Coffee &amp; Tea E-Commerce Marketing Emails</title>
<style type="text/css">
.year-container {border:1px solid green;}
.thumb {float:left;text-align:center;}
.hidden {display:none;}
</style>
</head>
<body>
INDEX_HEAD

for i in index_files/2015.list index_files/2014.list index_files/2013.list index_files/2012.list index_files/2011.list
  do
    echo "<div class=\"year-container\" id=\"t-`basename $i`\"> `basename $i`" >> index.html
    echo "<div class=\"hidden\">" >> index.html
    while read line
      do 
        caption=$(basename $line)
        thumb_url="$(echo $line | tr "/" "_").png"
cat >> index.html <<INDEX_BODY
<div class="thumb">
  <div class="caption">$caption</div>
  <a href="http://$line"><img src="images/$thumb_url" width="250" alt="" /></a>
</div>
INDEX_BODY
      done < $i
    echo "</div>" >> index.html
    echo "</div>" >> index.html
  done
cat >> index.html <<INDEX_FOOT
</body>
</html>
INDEX_FOOT

