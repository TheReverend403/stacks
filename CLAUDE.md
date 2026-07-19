# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Docker Compose stacks for self-hosted services, one directory per service
(caddy, gitea, frigate, mediaserver, vaultwarden, ...), each holding a
`compose.yaml` plus optional `Dockerfile`, `config/`, and `data/`. Services
needing secrets/settings ship a `.env.example` to copy to `.env` in the same
directory.

## Dev workflow

- Every stack tracks a `.gitkeep` in each directory its `compose.yaml`
  actually bind-mounts, so a fresh clone already has them and
  `docker compose up` never creates one as root. When you add a new bind
  mount, create a matching directory with a `.gitkeep` at that exact path,
  no deeper. Don't pre-create subdirectories an application creates for
  itself (e.g. deluge makes its own move-completed dirs) — only ones that
  error out if missing (e.g. Radarr/Sonarr root folders). `mediaserver/` is
  the reference example.
- The root `.gitignore` ignores all files under any `config/`/`data/` tree
  at any depth while keeping the directories themselves trackable, so
  `.gitkeep` placeholders show up but real runtime state (databases,
  secrets, media) never does, even under a stray `git add -A`. If a
  stack's data directory contains embedded git repos that would slip
  through this net (e.g. gitea-runner's act/cache checkouts), add a
  stack-local `.gitignore` rather than special-casing the root one.
- Each stack's `.env.example` documents `BASE_DIR` with a comment naming
  which of `config/`/`data/` it governs. Defaults to `.`; if set to
  anything else, the directory tree must already exist there, nothing
  creates it for you off-repo.
- `compose.override.yaml` is gitignored deliberately, it's where
  host-specific tweaks live (published ports, image pins, notification
  credentials) that shouldn't be in the tracked `compose.yaml`. Don't
  assume `compose.yaml` alone is the whole picture on a live host.
- Keep a stack's directory name and its compose network/container names in
  sync with what it actually runs, don't let them drift.
- Bring a stack up from its directory:
  `docker compose up -d --pull=always --build --remove-orphans`
- Lint: `uv run yamllint --strict .` or `uv run prek run --all-files`
  (yamllint plus end-of-file/trailing-whitespace/shebang checks, configured
  in `prek.toml`). uv is dev tooling only. There is no Python code here.
