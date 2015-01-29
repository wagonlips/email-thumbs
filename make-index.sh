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

