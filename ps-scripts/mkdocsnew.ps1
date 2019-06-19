# Script to create a new mkdocs repository using our Docker image

Write-Host 
"Create new mkdocs site
=======================
This script creates a new mkdocs site using the raspberryvalley/mkdocs image (version 1.0.1)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Bitbucket  : https://bitbucket.org/dynapac/docker-mkdocs
"

# docker run -it -v $(pwd):/mysite mkdocs new .
$command = "docker run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.0.1 new ."
Write-Output $command
iex $command