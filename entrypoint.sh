#!/bin/bash

IS_BRANCH_NAME_VALID=$( echo ${BRANCH_NAME} | grep -P "^(bug|feature|hotfix|epic|release|revert)/PZ-\d{4}" | wc -l)
VALID_COMMIT_MESSAGE_PREFIX=$(echo ${BRANCH_NAME} | grep -oP "PZ-\d{4}")
IS_PULL_REQUEST_TITLE_VALID=$(echo $PULL_REQUEST_TITLE | grep -P "^"$VALID_COMMIT_MESSAGE_PREFIX".+" | wc -l)


if [[ $IS_BRANCH_NAME_VALID != "1" ]]
then
  echo "The branch name( $BRANCH_NAME ) is not valid, for more information visit: https://github.com/ateli-development/shipgratis/wiki/Coding-standards"
  echo "Once you changed the Pull-request title, you should create a new commit and push it."
  exit 101
fi





if [[ $IS_PULL_REQUEST_TITLE_VALID != "1" ]]
then
  echo "The pull request title( $PULL_REQUEST_TITLE ) is not valid, it should be in this format: ${VALID_COMMIT_MESSAGE_PREFIX} here is the jira title"
  exit 101
fi

