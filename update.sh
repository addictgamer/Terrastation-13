#!/bin/bash

#TODO: Do something like this.


if git add -A
then
	:
else
	echo "Error: Failed to add all files." && exit 1
fi # if git add -A


if git commit -a -m "Automatic update."
then
	:
else
	echo "Error: Failed to commit." && exit 1
fi # if git commit -a -m "Automatic update."


if git push
then
	:
else
	echo "Error: Failed to push to remote." && exit 1
fi #if git push

# merge command to pull branch master into the main-server repo
if git merge overhaul
then
	:
else
	echo "Error: Failed to merge with branch overhaul."
fi # if git merge overhaul
