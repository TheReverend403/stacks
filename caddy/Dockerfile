FROM caddy:builder AS builder

RUN --mount=type=cache,target=$GOPATH/pkg/ \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
