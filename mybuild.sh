###################################################################
## Instruction how to build site locally and then push to github ##
###################################################################
## Thomas added on 01-Dec-2025

## New git clone instance
git clone git@github.com:systemPipeR/systemPipeR.github.io.git
git submodule update --init --recursive
## if there is an error blogdown loading site pay attetion to version .Rprofile
# options(blogdown.hugo.version = "0.87.0")
options(blogdown.hugo.version = "0.123.7")


## One necessary fix (one time setup change) was to ignore jekyll in build, which gave errors
## under github actions. Adding a .nojekyll file fixed this.
git checkout main # just in case
touch .nojekyll # this file instructs to ignor jekyll
git add .nojekyll
git commit -am “no_render” # Tell github action not to render.
git push

###################################################
## Deploy/update site from local (run as script) ##
###################################################
#!/bin/bash

# STEP 0: SYNC (Crucial to prevent conflicts)
# Ensures you have the latest changes from your other computer before starting.
git checkout main
git pull origin main

## -> do site update work here

# STEP 1: BUILD
# --cleanDestinationDir: Wipes the public folder to remove old files.
# --logLevel info: The modern replacement for --verbose.
hugo --logLevel info --cleanDestinationDir

# STEP 2: PREPARE ASSETS
# Manually copies .nojekyll to ensure GitHub doesn't break the site.
cp .nojekyll public/

# STEP 3: COMMIT SOURCE FILES
# Adds both your source code changes AND the new public/ build files.
git add .
git commit -m "Update site content and build"

# STEP 4: PUSH SOURCE CODE
# Sends your markdown/Rmd files to the main branch.
# (No need to wait for GitHub Actions; you are building the site locally below).
git push origin main

# STEP 5: DEPLOY (FORCE PUSH)
# Splits the 'public' folder and forces it onto the gh-pages branch.
# This makes the site live immediately.
git push origin `git subtree split --prefix public`:gh-pages --force





