# Script to build an existing mkdocs site using the Raspberry Valley Docker image

Write-Host 
"Raspberry Valley mkdocs Docker Image Podman launcher
=====================================================
This script uses the raspberryvalley/mkdocs docker image (version 1.3.1). Launches 
the site in the current directory.

Docker Hub : https://hub.docker.com/r/raspberryvalley/mkdocs/
Github : aaa
"

$param1=$args[0]

switch ($param1)
{
    "new" {
        Write-Host("Creating new mkdocs site in $pwd");
        $command = "podman run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.3.1 new .";
        Invoke-Expression($command);
        Break
    }
    "serve" {
        Write-Host("Serving mkdocs site from $pwd");
        $command = "podman run -it --rm -v $(pwd):/mysite -p 8000:8000 raspberryvalley/mkdocs:1.3.1 serve -a 0.0.0.0:8000";
        Invoke-Expression($command);
        Break
    }
    "build" {
        Write-Host("Building mkdocs site in $pwd");
        $command = "podman run -it --rm -v $(pwd):/mysite raspberryvalley/mkdocs:1.3.1 build";
        Invoke-Expression($command);
        Break
    }
    default {
        Write-Host("Unknown parameter - Usage: docker-mkdocs.ps1 [new|serve|build] `n");
        Break
    }
}
