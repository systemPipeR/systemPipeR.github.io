###################################################################
## Instruction how to build site locally and then push to github ##
###################################################################
## Thomas added on 01-Dec-2025

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
cp .nojekyll public
git add . # needs to be done to account for changes in `public/`
git commit -am "no_render" # tell github action not to render. 
git push origin main
git push origin `git subtree split --prefix public`:gh-pages --force # use only to resolve possible error in push
# git subtree push --prefix public origin gh-pages # alternative not used

