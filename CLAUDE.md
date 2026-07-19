# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Docker Compose stacks for self-hosted services, one directory per service
(caddy, gitea, frigate, mediaserver, vaultwarden, ...), each holding a
`compose.yaml` plus optional `Dockerfile`, `config/`, and `data/`. Services
needing secrets/settings ship a `.env.example` to copy to `.env` in the same
directory.

## Dev workflow

- Before starting a stack, pre-create any host directories its `compose.yaml`
  bind-mounts (e.g. `data/`, `config/`) so Docker doesn't create them as
  root and cause permissions issues.
- Bring a stack up from its directory:
  `docker compose up -d --pull=always --build --remove-orphans`
- Lint: `uv run yamllint --strict .` or `uv run prek run --all-files`
  (yamllint plus end-of-file/trailing-whitespace/shebang checks, configured
  in `prek.toml`). uv is dev tooling only. There is no Python code here.
