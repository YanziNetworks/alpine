# Build and Push Automation

These scripts are automatically called by the Docker hub infrastructure
whenever a build of this project is requested. The script will figure out the
list of current [tags] for the official source repository and automatically
build (and push) a version of this image with the same tag. The name of the
official (and local) tag is passed through the `SRCTAG` variable as a build
argument.

  [tags]: https://raw.githubusercontent.com/docker-library/official-images/master/library/alpine