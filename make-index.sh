#!/bin/bash
#
# this is script 3 of 3
#
file_url="dev-misc.peets.com/email-thumbs/EMAIL_2015/1st_qtr/150201-esn-vday/150201-esn-vday.html"
thumb_url="dev-misc.peets.com_email-thumbs_EMAIL_2015_1st_qtr_150201-esn-vday_150201-esn-vday.html.png"
cat > index.html <<INDEX_HEAD
<!DOCTYPE html>
<html>
<head>
<title>Peet&rsquo;s Coffee &amp; Tea E-Commerce Marketing Emails</title>
<style type="text/css">
.thumb {float:left;text-align:center;}
</style>
</head>
<body>
INDEX_HEAD

for i in index_files/2015.list index_files/2014.list index_files/2013.list index_files/2012.list index_files/2011.list
  do
    echo "<div class=\"year-container\" id=\"t-`basename $i`\">"
    while read line
      do 
        caption=$(basename $line)
        echo "  <div class=\"thumb\">"
        echo "    <div class=\"caption\">$caption</div>"
        echo "    <a href=\"http://$line\"><img src=\"images/$thumb_url\" width=\"250\" alt=\"\" /></a>"
        echo "  </div>"
      done < $i
    echo "</div>"
  done
cat >> index.html <<INDEX_FOOT
</body>
</html>
INDEX_FOOT

