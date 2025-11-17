FROM alpine:3.22
LABEL maintainer="MajorP93" \
      org.opencontainers.image.title="majorp93/unbound-minimal" \
      org.opencontainers.image.description="a validating, recursive, and caching DNS resolver" \
      org.opencontainers.image.url="https://github.com/MajorP93/unbound-docker-minimal" \
      org.opencontainers.image.vendor="MajorP93" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/MajorP93/unbound-docker-minimal"

ENV NAME=unbound-minimal \
    SUMMARY="unbound is a validating, recursive, and caching DNS resolver." \
    DESCRIPTION="unbound is a validating, recursive, and caching DNS resolver."

RUN apk add --update unbound drill bash perl coreutils && \
	rm -rf /var/cache/apk/* /etc/unbound/unbound.conf

COPY data/ /

RUN chmod +x /unbound.sh && \
    ln -sf /dev/stdout /var/log/unbound.log

EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=15s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/unbound.sh"]