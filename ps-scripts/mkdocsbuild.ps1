# Script to build an existing mkdocs site using our Docker image

Write-Host 
"Build mkdocs site (from current directory)
===========================================
This script builds an mkdocs site using the raspberryvalley/mkdocs image (version 1.3.1)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Github     : https://github.com/raspberryvalley/docker-mkdocs/
"

$command = "docker run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.3.1 build"
Write-Output $command
iex $command