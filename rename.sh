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

# Prompt by new name of project
echo "Type new name to project (Not use space, special characters, character '@' and accented letters!!!):"
read -p "New name: " NEWNAME

# Prompt by new bundle identifier
echo "Type new bundle identifier. This is like your e-mail, but inverted. (Not use space or special characters or accented letters!!!):"
echo "example: com.mydomain-my.name"
read -p "New bundle identifier: " NEW_BUNDLE_IDENTIFIER

# Prompt by new name organization
echo "Type the organization name (Not use space or special characters or accented letters!!!):"
echo "example: My business"
read -p "New organization name: " NEW_ORG_NAME

#Rename the name of project
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_NAME/$NEWNAME/g"

#Rename the BUNDLE ID
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_BUNDLE_ID/$NEW_BUNDLE_IDENTIFIER/g"

#Rename Organization Name
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_ORG_NAME/$NEW_ORG_NAME/g"

# Rename file of project with new name.
mv $ORIGINAL_NAME_FILE "$NEWNAME.xcodeproj"

# Update git remote URL
echo "This is the current ORIGIN URL of folder: \n"
git remote -v

echo "\n"
echo "Do you want update this URL?"
echo -p "Update url? (y/n)" IS_TO_UPDATE_GIT_REMOTE_URL

if [[$IS_TO_UPDATE_GIT_REMOTE_URL -eq "y"]]
then
    echo -p "Enter the new valid URL: " URL_GIT_REMOTE
    git remote set-url $URL_GIT_REMOTE
    echo "Done! After finish setup, commit the changes and push!."
fi
 
echo "Congratulations! Finish the inital setup. Go ahead to Readme file."