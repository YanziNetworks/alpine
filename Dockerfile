ARG SRCTAG=latest
FROM alpine:${SRCTAG}

ARG GLIBC_VER="2.30-r0"
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