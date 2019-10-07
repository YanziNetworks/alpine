# glibc-capable Alpine

These images are almost identical to the official `alpine` images at the Docker
[hub], while being able to execute binaries that depend on glibc. This is made
possible through [this][glibc-compat] wonderful glibc compatibility layer.
[Hooks] ensure that, for each build, identical copies to the current list of
available [tags] for the official [alpine][hub] are automatically (re)built.

  [hub]: https://hub.docker.com/_/alpine
  [glibc-compat]: https://github.com/sgerrand/alpine-pkg-glibc
  [Hooks]: ./hooks/
  [tags]: https://hub.docker.com/_/alpine?tab=tags

## Example

A self-contained and rather contrieved example would consist in running the
`docker` command-line from a Ubuntu (or similar) host using this image. This
works by giving away the Docker socket together with the binary from the Ubuntu
host to the Alpine-based container and running the mapped binary from within
the container.

```shell
docker run \
    --rm \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v /usr/bin/docker:/usr/bin/docker:ro
    yanzinetworks/alpine
    docker ps
```

Using this technique allows to run `docker` from any image based on this image,
much similarily to the official [docker] image.

  [docker]: https://hub.docker.com/_/docker

## Acknowledgements

The idea behind this image comes from this [attempt] to run [grafana] under an
Alpine image.

  [attempt]: https://github.com/grafana/grafana/pull/14913#issuecomment-492237190
  [grafana]: https://grafana.com/