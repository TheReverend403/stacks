# stacks

Docker Compose stacks for self-hosted services. One directory per service, each holding a `compose.yaml` plus `config/`, and `data/` where applicable.

## Usage

```sh
cd <stack>/
cp .env.example .env # Edit .env
chown -R uid:gid data/ config/ # Use the same values as PUID and PGID from .env
docker compose up -d --pull=always --remove-orphans
```
