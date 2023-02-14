#!/bin/bash
#Support to SED
export LC_CTYPE=C
export LANG=C

ORIGINAL_NAME="mvvm-c"
ORIGINAL_BUNDLE_ID="com.outlook@amaral"
ORIGINAL_ORG_NAME="Caseiro"

echo "Before any configuration setup the correct name of project."
echo "You can cancel the process pressioning 'CTRL + C'. If you make a mistake, dont worry, run the command: 'git checkout .' and try again!"

echo "Type new name to project (Not use space, special characters, character '@' and accented letters!!!):"
echo "example: com.mydomain-my.name"
read NEWNAME

echo "Type new bundle identifier (Not use space or special characters or accented letters!!!):"
read NEW_BUNDLE_IDENTIFIER

echo "Type the organization name (Not use space or special characters or accented letters!!!):"
read NEW_ORG_NAME

find . -type f -not -path "*git/*" -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_NAME/$NEWNAME/g"

find . -type f -not -path "*git/*" -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_BUNDLE_ID/$NEW_BUNDLE_IDENTIFIER/g"

find . -type f -not -path "*git/*" -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_ORG_NAME/$NEW_ORG_NAME/g"