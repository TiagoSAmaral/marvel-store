#!/bin/bash
echo "Type new name to project:"
read NEWNAME
find . -type f -not -path "*git/*" -print0 | xargs -0 sed -i ""  "s/mvv-c/$NEWNAME/g"