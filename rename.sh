#!/bin/bash
#Support to SED
export LC_CTYPE=C
export LANG=C

ORIGINAL_NAME="ios-base-project"
ORIGINAL_NAME_FILE="ios-base-project.xcodeproj"
ORIGINAL_BUNDLE_ID="com.domain-developer"
ORIGINAL_ORG_NAME="developer_organization_name"

echo "Before any configuration setup the correct name of project."
echo "You can cancel the process pressioning 'CTRL + C'. If you make a mistake, dont worry, run the command: 'git checkout .' and try again!"

echo "Type new name to project (Not use space, special characters, character '@' and accented letters!!!):"
# read NEWNAME
read -p "New name: " NEWNAME

echo "Type new bundle identifier. This is like your e-mail, but inverted. (Not use space or special characters or accented letters!!!):"
echo "example: com.mydomain-my.name"
read -p "New bundle identifier: " NEW_BUNDLE_IDENTIFIER

echo "Type the organization name (Not use space or special characters or accented letters!!!):"
echo "example: My business"
read -p "New organization name: " NEW_ORG_NAME

find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_NAME/$NEWNAME/g"

find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_BUNDLE_ID/$NEW_BUNDLE_IDENTIFIER/g"

find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_ORG_NAME/$NEW_ORG_NAME/g"



mv $ORIGINAL_NAME_FILE "$NEWNAME.xcodeproj"