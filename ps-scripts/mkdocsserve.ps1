# Script to serve an existing mkdocs site using our Docker image

Write-Host 
"Serve mkdocs site (from current directory)
===========================================
This script serves an mkdocs site using the raspberryvalley/mkdocs image (version 1.0.1)
in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Bitbucket  : https://bitbucket.org/dynapac/docker-mkdocs
"

# docker run -it --rm -v $(pwd):/mysite -p 8000:8000 mkdocs serve -a 0.0.0.0:8000

$command = "docker run -it --rm -v $(pwd):/mysite -p 8000:8000 raspberryvalley/mkdocs:1.0.1 serve -a 0.0.0.0:8000"
Write-Output $command
iex $command