ARG SRCTAG=latest
FROM alpine:${SRCTAG}

ARG GLIBC_VER="2.31-r0"
RUN apk add --update --no-cache ca-certificates tzdata curl && \
  ALPINE_GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
  curl -Ls https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
  curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-${GLIBC_VER}.apk > /tmp/${GLIBC_VER}.apk && \
  apk add /tmp/${GLIBC_VER}.apk && \
  curl -Ls ${ALPINE_GLIBC_REPO}/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk > /tmp/${GLIBC_VER}-bin.apk && \
  apk add /tmp/${GLIBC_VER}-bin.apk && \
  apk del curl  && \
  rm -rf /tmp/*.apk /var/cache/apk/*

# Fix glibc ldd command - see https://github.com/sgerrand/alpine-pkg-glibc/issues/103.
RUN sed -i s/lib64/lib/ /usr/glibc-compat/bin/ldd

# OCI Annotation: https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.title="alpine"
LABEL org.opencontainers.image.description="glibc-capable Alpine"
LABEL org.opencontainers.image.authors="Emmanuel Frecon <efrecon+github@gmail.com>"
LABEL org.opencontainers.image.url="https://github.com/YanziNetworks/alpine"
LABEL org.opencontainers.image.documentation="https://github.com/YanziNetworks/alpine/README.md"
LABEL org.opencontainers.image.source="https://github.com/YanziNetworks/alpine"
LABEL org.opencontainers.image.version="$SRCTAG"
LABEL org.opencontainers.image.created="$BUILD_DATE"
LABEL org.opencontainers.image.vendor="Yanzi Networks AB"
LABEL org.opencontainers.image.licenses="MIT"
