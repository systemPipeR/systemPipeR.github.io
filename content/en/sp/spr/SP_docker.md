---
title: "SPR Docker container" 
author: "Author: Daniela Cassol (danielac@ucr.edu)"
date: "Last update: 28 October, 2021" 
output:
  BiocStyle::html_document:
    toc_float: true
    code_folding: show
  BiocStyle::pdf_document: default
package: systemPipeR
fontsize: 14pt
type: docs
weight: 10
---

> Guidelines from [bioconductor_docker](https://github.com/Bioconductor/bioconductor_docker).

# Running the `systemPipeR` with Docker 

## Get a copy of the public docker image


```bash
docker pull systempipe/systempipe_docker:latest
```

## To run RStudio Server:


```bash
docker run -e PASSWORD=systemPipe -p 8787:8787 \
        systempipe/systempipe_docker:latest
```

You can then open a web browser pointing to your docker host on
port 8787.  If you're on Linux and using default settings, the docker
host is `127.0.0.1` (or `localhost`, so the full URL to RStudio would
be `http://localhost:8787)`. If you are on Mac or Windows and running
`Docker Toolbox`, you can determine the docker host with the
`docker-machine ip default` command.

In the above command, `-e PASSWORD=` is setting the RStudio password
and is required by the RStudio Docker image. It can be whatever you
like except it cannot be `rstudio`. Log in to RStudio with the
username `rstudio` and whatever password was specified, in this 
example `systemPipe`.

## To run R from the command line:


```bash
docker run -it --user rstudio systempipe/systempipe_docker:latest R
```

## To open a Bash shell on the container:


```bash
docker run -it --user rstudio systempipe/systempipe_docker:latest bash
```

<!-- # Full Documentation -->

<!-- This tutorial shows how to create, access, run, build a Docker container. -->

<!-- ## Table of Content -->

<!-- 1. [Install](#Install) -->
<!-- 2. [Docker Hub Account](#dockerHub) -->
<!-- 3. [Log in to the Docker Hub](#login) -->
<!-- 4. [Run Docker](#run) -->
<!-- 5. [Create your first repository](#create) -->
<!-- 6. [Make changes to the container and Create the new image](#changes) -->
<!-- 7. [Commands](#commands) -->
<!-- 8. [Docker and GitHub Actions](#github) -->
<!-- 9. [Common Problems](#faq) -->
<!-- 10. [Singularity Container](#singularity) -->
<!-- 11. [Resources](#resources) -->

* * *
<div id='Install'/>


# Install

**Prerequisites**: 
[Linux](https://docs.docker.com/installation/) 
[Mac](http://docs.docker.com/installation/mac/)
[Windows](http://docs.docker.com/installation/windows/)

Instructions [here](https://docs.docker.com/engine/install/ubuntu/) on how to install Docker Engine on Ubuntu.

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
 
## Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world
```
 
## Uninstall

```
sudo apt-get remove docker docker-engine docker.io containerd runc
```
* * *
<div id='dockerHUb'/>

# Docker Hub Account

To be able to share a custom image, please go to https://hub.docker.com and 
create a free account.

* * *
<div id='login'/>

## Log in to the Docker Hub locally

Login with your Docker ID to push and pull images from Docker Hub. If you don't
have a Docker ID, head over to https://hub.docker.com to create one.

```
docker login
# Username: XXXX
# Password: xxx
# Login Succeeded
```

* * *
<div id='run'/>

# Run Docker 

```
docker run-dP systempipe/systempipe_docker:latest
```

Make sure the container is running:
```
docker ps
# CONTAINER ID   IMAGE                                    COMMAND   CREATED         STATUS         PORTS                     # NAMES
#5d007f66a7b3   systempipe/systempipe_docker:latest   "/init"   5 minutes ago   Up 5 minutes   0.0.0.0:49153->8787/tcp   determined_easle
```

## Login to the container

Please check the `NAMES` in this example, `determined_easle,` to login into the container.

```
docker exec -it determined_easle /bin/bash
```

## Other alternatives to run the container

### To run RStudio Server:

```
docker run -e PASSWORD=systemPipe -p 8787:8787 \
    systempipe/systempipe_docker:latest
```

### To run R from the command line:

```
docker run -it --user rstudio systempipe/systempipe_docker:latest R
```

### To open a Bash shell on the container:

```
docker run -it --user rstudio systempipe/systempipe_docker:latest bash
```

### Check R Version into the container 

```
R --version
```
## Stop Docker

```
docker stop determined_easle
```

* * *
<div id='create'/>

# Create your first repository [Link](https://docs.docker.com/docker-hub/)

## Create a repository:

- Sign in to Docker Hub.
- Click Create a Repository on the Docker Hub welcome page:
- Name it <your-username>/my-repo.
- Click Create.

## Build and push a container image to Docker Hub from your computer

### Start by creating a *Dockerfile* to specify your application

```
mkdir docker_test
cd docker_test
touch Dockerfile
```

```
# Docker inheritance
FROM systempipe/systempipe_docker:latest

## Install BiocStyle
RUN R -e 'BiocManager::install("BiocStyle")'

# Install required Bioconductor package from devel version
RUN R -e 'BiocManager::install("tgirke/systemPipeR")'
RUN R -e 'BiocManager::install("tgirke/systemPipeRdata")'

WORKDIR /home/rstudio/SPRojects

COPY --chown=rstudio:rstudio . /home/rstudio/SPRojects

# Metadata
LABEL name="systempipe/systempipe_docker" \
      version=$BIOCONDUCTOR_DOCKER_systempipe \
      url="https://github.com/systemPipeR/systempipe/systempipe_docker" \
      vendor="systemPipeR Project" \
      maintainer="email@gmail.com" \
      description="Bioconductor docker image containing the systemPipeR Project" \
      license="Artistic-2.0"
```

### Run `docker build` to build your Docker image

```
docker build -t systempipe/systempipe_docker . 
```

### Run `docker run` to test your Docker image locally

```
docker run -e PASSWORD=systemPipe -p 8787:8787 systempipe/systempipe_docker:latest
```

### Run `docker push` to push your Docker image to Docker Hub

```
docker push systempipe/systempipe_docker
```

- Your repository in Docker Hub should now display a new latest tag under `Tags`
 
* * *
<div id='changes'/>

# Make changes to the container and Create the new image

Create a folder, for example:
```
docker run -dP systempipe/systempipe_docker
docker ps ## To check the NAME <lucid_grothendieck>
docker exec -it lucid_grothendieck /bin/bash
root@33c758eb1626:/# R
```

```r
setwd("home/rstudio/")
systemPipeRdata::genWorkenvir("rnaseq")
```

```
exit
docker commit -m "Added rnaseq template" -a "Dani Cassol" lucid_grothendieck dcassol/systempipeworkshop2021:rnaseq
docker push systempipe/systempipe_docker:rnaseq
```

Run the new image:

```
docker run -e PASSWORD=systemPipe -p 8787:8787 systempipe/systempipe_docker:rnaseq
```

* * *
<div id='commands'/>

# Commands

## List which docker machines are available locally
```docker images```

## List running containers
```docker ps```

## List all containers
```docker ps -a```

## Resume a stopped container
```docker start <CONTAINER ID>```

## Shell into a running container
```docker exec -it <CONTAINER ID> /bin/bash```

## Stop OR remove a cointainer
```docker stop <CONTAINER ID>```
```docker rm <CONTAINER ID>```

## Remove a image
```docker rmi dcassol/systempipeworkshop2021:rnaseq```

* * *
<div id='github'/>

# Docker and GitHub Actions

1. To create a new token, go to Docker Hub Settings

1.1. Account Settings >> Security >> New Access Token
1.2. Add Access Token Description >> Create
1.3. Copy the Access Token >> Copy and Close

2. Go to the Repository at GitHub

2.1. Settings > Secrets > New repository secret
2.2. Create a new secret with the name `DOCKER_HUB_USERNAME` and your `Docker ID` as value
2.3. Click at Add secret
2.4. Create a new secret with the name `DOCKER_HUB_ACCESS_TOKEN` and your `Personal Access Token (PAT)` as value (generated in the previous step)

3. Set up the GitHub Actions workflow

```
    steps:
    
      - name: Checkout Repo 
        uses: actions/checkout@v2

      - name: Login to Docker Hub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
```

* * *
<div id='faq'/>


# Common Problems

```
## Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.24/auth: dial unix /var/run/docker.sock: connect: permission denied
```
Solution:

```bash
sudo chmod 666 /var/run/docker.sock
```

* * *
<div id='singularity'/>

# Singularity Container

Please download the Docker image of systemPipe, as follow:


```bash
singularity pull docker://systempipe/systempipe_docker:latest
```

You can also use the `build` command to download pre-built images from Docker. 
Unlike `pull`, `build` will convert the image to the latest Singularity image format after 
downloading it.


```bash
singularity build systempipe_docker_latest.sif docker://systempipe/systempipe_docker:latest
```

To run the container:


```bash
singularity shell systempipe_docker_latest.sif
```

* * *
<div id='resources'/>

# Resources

- [Docker Run: How to create images from an application](https://www.mirantis.com/blog/how-do-i-create-a-new-docker-image-for-my-application/)
- [Docker Hub Quickstart](https://docs.docker.com/docker-hub/)
- [Configure GitHub Actions](https://docs.docker.com/ci-cd/github-actions/)
- [Singularity](https://sylabs.io/guides/3.0/user-guide/quick_start.html#interact-with-images)
