# RaspberryValley MkDocks Docker Image

We write a lot at the [Raspberry Valley](https://raspberry-valley.azurewebsites.net) makerspace. To share our tools without the hassle of installation, we reverted recently to Docker deployments, both for techies and authors.

This is our Docker Image for running [MkDocs](http://www.mkdocs.org/). It is based on [Alpine](https://hub.docker.com/_/alpine/), a minimal Docker image based on Alpine Linux with a complete package index and only 5 MB in size. We were inspired by [elamperti](https://hub.docker.com/r/elamperti/docker-mkdocs/) and his MKDocks image.

Our Dockerfile and instructions are is available at [GitHub](https://github.com/raspberryvalley/docker-mkdocs). Read detailed release notes in our [ChangeLog](changelog.md) document.

---

**NOTE**: As of **release 1.2** we have changed to Python 3 in the backend, and to support of Jupyter notebooks via [mknotebooks](https://pypi.org/project/mknotebooks/). This results in a much larger image size. If you don't need Jupyter, you'll still be safe with **release 1.1**

---

## About

Raspberry Valley is a maker community in Karlskrona, Sweden, sponsored by [Dynapac](https://dynapac.com/en). We run makerspaces every week, working with Raspberry Pis, Arduinos and other interesting hardware.

This repository is here to support our community of makers. A lot of our achievements are based and inspired by the community at large. We wish to pay back and share our experiences and lessons learned. Join us!

You can find our pages here: [Raspberry Valley](https://raspberry-valley.azurewebsites.net). You can also join us on [Twitter](https://twitter.com/RaspberryValley) or check [Docker Hub](https://hub.docker.com/r/raspberryvalley/) for images of interest.

## Introduction

This documentation describes the creation and usage of the *MkDocs* image. On top we provide a few *PowerShell* scripts to simplify day-to-day authoring of content.

> If you don't want to roll your own, but start using the image, jump to the section **Pulling the image from Dockerhub** below. We do recommend to be careful about third party images and to validate the image before installing.

To learn more about setting up your project in *MkDocs* and working with the tool, see the [MkDocs Getting Started](http://www.mkdocs.org/#getting-started) manual.

> Please note: We always assume that you run all commands from the directory where your *MkDocs* site is, or will be. You can easily confirm you are in the right directory if you see the Yaml file.

---

Once you have setup your MkDocs/Docker environment, as described here, you might want to take the next step and automate your site deployment. If it's Azure you are targeting, you're in luck; we have a solution and guide for [Deployment of MkDocs to Azure](https://github.com/raspberryvalley/deploy-mkdocs-to-azure)

## Building the image

First, let us prepare our image.

* Navigate to an empty folder and pull this *Git* repository
* Open your shell (both the Dos prompt and PowerShell will work) and run the following

```bash
docker build -t raspberryvalley/mkdocs .
```

You should end up with output similar to this:

![mkdocs build](img/mkdocs-build.jpg)

**NOTE**: please don't forget the dot at the end of the command

## Push image

We can push our image to [Docker Hub](https://hub.docker.com). We assume here you have an account and can log in.

First, let's 'tag' the image. Basically give it a 'label' which identifies a version of the system, target platform etc.

```bash
docker tag raspberryvalley/mkdocs raspberryvalley/mkdocs:1.1.0
```

Let us now push the docker image to [Docker Hub](https://hub.docker.com) (you need to login first)

```bash
docker login
docker push raspberryvalley/mkdocs:1.1.0
```

You should see something similar to this:

![mkdocs push](img/mkdocs-push.jpg)

And, on your Docker repository, you can see the image for re-use. Don't forget to edit the title and the description. The example above obviously points to our hub, substitute '''raspberryvalley''' to a hub of your choice.

![mkdocs on Docker Hub](img/mkdocs-dockerhub.jpg)

---

## Pull MkDocs image from Docker hub

Now we have sorted out everything, we have our brand new image on [Docker Hub](https://hub.docker.com). If you want to skip all the above, you can simply use our image to get started. Time to Pull the image.

```bash
docker pull raspberryvalley/mkdocs:1.1.0
```

After a bit of downloading, you will be ready to create your own sites.

## Starting a new MkDocs project

You might need to start a new project using the MkDocs inbuilt features. It really is trivial and not always needed. But just in case, this is how you start one in the current directory.

```bash
docker run -it -v $(pwd):/mysite raspberryvalley/mkdocs:1.1.0 new .
```

## Serving an MkDocs project

The current project directory will be served and can be tested in your browser

```bash
docker run -it -v $(pwd):/mysite -p 8000:8000 raspberryvalley/mkdocs:1.1.0 serve -a 0.0.0.0:8000
```

## Building an MkDocs project

To generate a static site using the docker image, run

```bash
docker run -it -v $(pwd):/mysite raspberryvalley/mkdocs:1.1.0 build
```

**Notes**:

* We assume you are in a directory where a valid MkDocs site is
* **$(pwd)** expands the current directory. There are issues in Windows doing this. In such a case, expand to the full path in the command-line. It can be of interest, that if you use this expansion inside a PowerShell script, it will work.

```bash
docker run -it -v c:\somedirectory\somesite:/mysite raspberryvalley/mkdocs:1.1.0 build
```

or

```bash
docker run -it -v /c/somedirectory/somesite:/mysite raspberryvalley/mkdocs:1.1.0 build
```

* It's a good idea to remove the container immediately after it was used. Use the switch **--rm** to achieve this

## Powershell Scripts

It is tedious to always write the full docker command on the command line. Now I do not recommend to use the below scripts immediately (there's no better learning than getting the manual effort into your bloodstream), but once you are convinced you know how things work, it's time to start working with PowerShell Scripts.

Just copy them from our **ps-scripts** directory somewhere onto your path, or simply copy-paste the scripts from below.

## Creating a new website

To create a new website in mkdocs, simply use the script below. The name in the scripts directory is **mkdocsnew.ps1**. Note this scripts creates a new site in the current directory of your powershell console by utilizing our mkdocs image. The mkdocs parameter 'sitename' is ignored.

```powershell
# Script to create a new mkdocs repository using our Docker image

Write-Host
"Create new mkdocs site
=======================
This script creates a new mkdocs site using the raspberryvalley/mkdocs image (version 1.1.0)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Bitbucket  : https://bitbucket.org/dynapac/docker-mkdocs
"

# docker run -it -v $(pwd):/mysite mkdocs new .
$command = "docker run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.1.0 new ."
Write-Output $command
iex $command
```

Once you run the script on a directory, you can see something similar to the below:

![powershell script mkdocsnew](img/script-mkdocsnew.jpg)

## Serve existing mkdocs site

To serve an existing site you your local machine, yuu can use the powershell script **mkdocsserve.ps1**. Navigate to the directory where your site is (in powershell), then simply run the script (grab it from our repository or use the code below). If the script is on your path, you're in business.

```powershell
# Script to serve an existing mkdocs site using our Docker image

Write-Host
"Serve mkdocs site (from current directory)
===========================================
This script serves an mkdocs site using the raspberryvalley/mkdocs image (version 1.1.0)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Bitbucket  : https://bitbucket.org/dynapac/docker-mkdocs
"

# docker run -it --rm -v $(pwd):/mysite -p 8000:8000 mkdocs serve -a 0.0.0.0:8000

$command = "docker run -it --rm -v $(pwd):/mysite -p 8000:8000 raspberryvalley/mkdocs:1.1.0 serve -a 0.0.0.0:8000"
Write-Output $command
iex $command
```

Your output in the console can be similar to the below

![powershell script mkdocsserve](img/script-mkdocsserve.jpg)

## Build existing mkdocs site

Time to build an existing mkdocs site. You can use our script **mkdocsbuild.ps1** or simply copy the script below. Navigate to the directory with your mkdocs source and invoke the script.

```powershell
# Script to build an existing mkdocs site using our Docker image

Write-Host
"Build mkdocs site (from current directory)
===========================================
This script builds an mkdocs site using the raspberryvalley/mkdocs image (version 1.1.0)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Bitbucket  : https://bitbucket.org/dynapac/docker-mkdocs
"

$command = "docker run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.1.0 build"
Write-Output $command
iex $command
```

The output is as follows.

![powershell script mkdocsbuild](img/script-mkdocsbuild.jpg)

## Known Issues

This section is a list of fixes for known issues. We searched for a solution, so you don't have to.

### Error Starting userland Proxy

Recently we are getting this error on some configurations:

```bash
 Error response from daemon: driver failed programming external connectivity on endpoint tender_cocks (5678ab713xy7a2d97eb3b746352b8az2312341bcda8be3d58ea6959uytb): Error starting userland proxy: mkdir /port/tcp:0.0.0.0:8000:tcp:128.11.0.1:8000: input/output error.
```

It turns out that you probably have 'Fast Startup Mode' on your Windows 10 which can conflict with Docker. All you have to do is restart Docker. A good explanation of the issue can be found [here](https://coding-stream-of-consciousness.com/2018/11/16/docker-windows-error-starting-userland-proxy/)

## Links

* [GitHub home](https://github.com/raspberryvalley/docker-mkdocs)
* [Raspberry Valley MkDocs image on Docker Hub](https://hub.docker.com/r/raspberryvalley/mkdocs/)

And related to this article:

* [Docker Hub](https://hub.docker.com)
* [Alpine](https://hub.docker.com/_/alpine/)
* [3 biggest wins when using Alpine as a base image](https://diveintodocker.com/blog/the-3-biggest-wins-when-using-alpine-as-a-base-docker-image)
* [MkDocs](http://www.mkdocs.org/)

Raspberry Valley makerspace links

* [Raspberry Valley](https://raspberry-valley.azurewebsites.net) - Other things we make and do
* [Raspberry Valley on Twitter](https://twitter.com/RaspberryValley)
* [Raspberry Valley on Github](https://github.com/raspberryvalley)
* [Raspberry Valley Docker Hub Images](hub.docker.com/r/raspberryvalley/)
