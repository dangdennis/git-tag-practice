#!/bin/sh

# This script will be executed after commit in placed in .git/hooks/post-commit

# Semantic Versioning 2.0.0 guideline
# 
# Given a version number MAJOR.MINOR.PATCH, increment the:
# MAJOR version when you make incompatible API changes,
# MINOR version when you add functionality in a backwards-compatible manner, and
# PATCH version when you make backwards-compatible bug fixes.

echo "Starting the tagging process based on commit message +semver: xxxxx"

VERSION=`git describe --tags`

# Split string into arrays
VERSION_BITS=(${VERSION//./ })

echo "Latest version tag: $VERSION"

# Get the version numbers and increment minor
VNUM1=${VERSION_BITS[0]}
VNUM1=(${VNUM1/v/}) # Removes the v
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}
# VNUM2=$((VNUM2+1))

echo $VNUM1 $VNUM2 $VNUM3 $VNUM4

# get last commit message and extract the count for "semver: (major|minor|patch)"
LAST_COMMIT_MSG_SEMVER_MAJOR=`git log -1 --pretty=%B | egrep -c '\+semver:\s?(breaking|major)'`
LAST_COMMIT_MSG_SEMVER_MINOR=`git log -1 --pretty=%B | egrep -c '\+semver:\s?(feature|minor)'`
LAST_COMMIT_MSG_SEMVER_PATCH=`git log -1 --pretty=%B | egrep -c '\+semver:\s?(fix|patch)'`

if [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_MAJOR -gt 0 ]; then
    VNUM1=$((VNUM1+1)) 
fi
if [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_MINOR -gt 0 ]; then
    VNUM2=$((VNUM2+1)) 
fi
if [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_PATCH -gt 0 ]; then
    VNUM3=$((VNUM3+1)) 
fi

echo $LAST_COMMIT_MSG_SEMVER_MAJOR $LAST_COMMIT_MSG_SEMVER_MINOR $LAST_COMMIT_MSG_SEMVER_PATCH

# # count all commits for a branch
# # GIT_COMMIT_COUNT=`git rev-list --count HEAD`
# echo "Commit count: $GIT_COMMIT_COUNT" 
# export BUILD_NUMBER=$GIT_COMMIT_COUNT

# #create new tag
# NEW_TAG="$VNUM1.$VNUM2.$VNUM3"

# echo "Updating $VERSION to $NEW_TAG"

# #only tag if commit message have version-bump-message as mentioned above
# if [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_MAJOR -gt 0 ] ||  [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_MINOR -gt 0 ] || [ $COUNT_OF_COMMIT_MSG_HAVE_SEMVER_PATCH -gt 0 ]; then
#     echo "Tagged with $NEW_TAG (Ignoring fatal:cannot describe - this means commit is untagged) "
#     git tag "$NEW_TAG"
# else
#     echo "Already a tag on this commit"
# fi

# git tag -a "$NEW_TAG"  -m "autogenerated"