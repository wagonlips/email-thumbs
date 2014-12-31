#!/bin/bash
ARGS=1        # Number of arguments expected.
E_BADARGS=85  # Exit value if incorrect number of args passed.
test $# -ne $ARGS && \
echo "Usage: `basename $0` and the file containing the URLs that start wwww (no http://) to capture. " && exit $E_BADARGS
THUMBSDIR=`pwd -P`

date
while read LINE
  do
    phantomjs $THUMBSDIR/render_multi_url_email_thumbs.js $LINE
  done < $1
date
exit 0
