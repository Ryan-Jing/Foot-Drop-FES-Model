#!/bin/bash

python3 /Users/ryanjing/MatLab_Projects/355_Project/Foot-Drop-FES-Model/get_code_googledocs.py

# Change directory to your repository path
cd /Users/ryanjing/MatLab_Projects/355_Project/Foot-Drop-FES-Model

# Add the modified file to the staging area
git add BME_355_Project_Model_Implementation.m

# Commit the changes
git commit -m "Update from Google Docs"

# Push changes to the remote repository
git push origin code-group-uploads