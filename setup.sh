#!/bin/bash

# Uh...This script is redundant if used from the repository...

if git clone https://github.com/addictgamer/Terrastation-13.git .
then
	:
else
	echo "Error: Failed to clone." && exit 1
fi # if git clone https://github.com/addictgamer/Terrastation-13.git .



if git checkout main-server
then
	:
else
	echo "Error: Failed to checkout branch main-server." && exit 1
fi # if git checkout main-server
