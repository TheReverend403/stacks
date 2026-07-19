# stacks

Docker Compose stacks for self-hosted services. One directory per service, each holding a `compose.yaml` plus `config/`, and `data/` where applicable.

## Usage

```sh
cd <stack>
cp .env.example .env
docker compose up -d --pull=always --remove-orphans
```
