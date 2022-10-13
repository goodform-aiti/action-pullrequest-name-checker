#!/bin/bash

echo "Branch name: ${BRANCH_NAME}"
echo "Pull request title: ${PULL_REQUEST_TITLE}"
echo "**********************************************"

JIRA_PREFIX="GF"
IS_RELEASE_BRANCH=$( echo ${BRANCH_NAME} | grep -P "^(release|revert).*/" | wc -l)



if [[ $IS_RELEASE_BRANCH != "1" ]]
then
  IS_BRANCH_NAME_VALID=$( echo ${BRANCH_NAME} | grep -P "^(bug|feature|hotfix)/$JIRA_PREFIX-\d+" | wc -l)
else
  IS_BRANCH_NAME_VALID=$( echo ${BRANCH_NAME} | grep -P "^(release|revert).+" | wc -l)
fi


if [[ $IS_BRANCH_NAME_VALID == "1" && $IS_RELEASE_BRANCH == "1" ]]
then
  echo "Script not check the PR name of release and revert branches "
  exit 0
fi




VALID_COMMIT_MESSAGE_PREFIX=$(echo ${BRANCH_NAME} | grep -oP "$JIRA_PREFIX-\d+")
IS_PULL_REQUEST_TITLE_VALID=$(echo $PULL_REQUEST_TITLE | grep -P "^"$VALID_COMMIT_MESSAGE_PREFIX".+" | wc -l)


if [[ $IS_BRANCH_NAME_VALID != "1" ]]
then
  echo "The branch name( $BRANCH_NAME ) is not valid, for more information please look to coding standards"
  exit 101
fi





if [[ $IS_PULL_REQUEST_TITLE_VALID != "1" ]]
then
  echo "The pull request title( $PULL_REQUEST_TITLE ) is not valid, it should be in this format: ${VALID_COMMIT_MESSAGE_PREFIX} title from JIRA task"
  exit 101
fi

