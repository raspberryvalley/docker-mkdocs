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