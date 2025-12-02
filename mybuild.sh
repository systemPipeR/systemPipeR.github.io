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

## Deploy site from local
git checkout main # just in case
hugo --verbose --cleanDestinationDir # build site. This creates rendered html files under `public/` 
#-> in new version use instead of --verbose: logLevel info
cp .nojekyll public
git add . # needs to be done to account for changes in `public/`
git commit -am "no_render" # tell github action not to render. 
git push origin main
git push origin `git subtree split --prefix public`:gh-pages --force # use only to resolve possible error in push
# git subtree push --prefix public origin gh-pages # alternative not used


# 1. Build the site
hugo --cleanDestinationDir 

# 2. Safety copy of .nojekyll (just in case)
cp .nojekyll public/

# 3. Stage and Commit
git add . 
git commit -m "Fix config warnings and update site"

# 4. Push Source to Main
git push origin main

# 5. Force Push to gh-pages (Your standard deployment command)
git push origin `git subtree split --prefix public`:gh-pages --force

