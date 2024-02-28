# syntax=docker/dockerfile:1

FROM caddy:builder AS builder

RUN --mount=type=cache,target=${GOPATH}/pkg/mod \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:latest

# For healthchecks
RUN --mount=type=cache,target=/var/cache/apk \
    apk update && \
    apk add curl

COPY docker/rootfs /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

HEALTHCHECK --start-interval=1s --start-period=10s --interval=10s --timeout=5s CMD ["/docker-healthcheck.sh"]
