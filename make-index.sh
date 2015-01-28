#!/bin/bash
#
# this is script 3 of 3
#
file_url="dev-misc.peets.com/email-thumbs/EMAIL_2015/1st_qtr/150201-esn-vday/150201-esn-vday.html"
thumb_url="dev-misc.peets.com_email-thumbs_EMAIL_2015_1st_qtr_150201-esn-vday_150201-esn-vday.html.png"
caption=$(basename $file_url)
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
<div class="year-container" id="thumbs-2015">
  <div class="thumb">
    <div class="caption">$caption</div>
    <a href="http://$file_url"><img src="images/$thumb_url" width="250" alt="" /></a>
  </div>
</div>
</body>
</html>
INDEX_HEAD


