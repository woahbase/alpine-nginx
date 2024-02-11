# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
RUN set -xe \
    && apk add --no-cache --purge -uU \
        apache2-utils \
        nginx \
        nginx-mod-stream \
        nginx-mod-http-headers-more \
        openssl \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
HEALTHCHECK \
    --interval=2m \
    --retries=5 \
    --start-period=5m \
    --timeout=10s \
    CMD \
    wget --quiet --tries=1 --no-check-certificate --spider ${HEALTHCHECK_URL:-"http://localhost:80/"} || exit 1
#
VOLUME /config/
#
EXPOSE 80 443
#
ENTRYPOINT ["/init"]
