# Claude Code Dev Container

A Docker container for running [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with a mounted local project directory. Authenticates via your Claude Pro/Max subscription — no API key required.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- A [Claude Pro or Max](https://claude.ai) subscription

## Quick Start

1. **Clone the repo:**

   ```bash
   git clone https://github.com/jonesjaycob/docker-cluade.git
   cd docker-cluade
   ```

2. **Create your `.env` file:**

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and set `PROJECT_DIR` to the absolute path of the project you want to work on:

   ```
   PROJECT_DIR=/home/you/projects/my-app
   ```

3. **Build and run:**

   ```bash
   docker compose run --rm claude-code
   ```

4. **Log in (first time only):**

   On first launch you'll see a URL in the terminal. Open it in your browser and sign in with your Claude account. Your session is saved automatically — you won't need to log in again unless the auth volume is removed.

## What's Included

The container is based on **Node.js 22 (Debian Bookworm)** and comes with common development tools pre-installed:

| Tool | Purpose |
|------|---------|
| git | Version control |
| build-essential | C/C++ compiler toolchain |
| python3 / pip | Python development |
| ripgrep / fd-find | Fast search utilities |
| curl / wget / jq | HTTP and JSON tools |
| vim / nano | Text editors |

Claude Code is installed globally via npm.

## How It Works

- Your local project directory is mounted at `/workspace` inside the container.
- A non-root `developer` user (UID/GID 1000) runs all commands, with passwordless `sudo` available.
- Login credentials are stored in a named Docker volume (`claude-auth`) so they persist across container restarts.

## Usage Examples

**Start an interactive Claude Code session:**

```bash
docker compose run --rm claude-code
```

**Run a one-off prompt against your project:**

```bash
docker compose run --rm claude-code claude -p "explain this project"
```

**Drop into a bash shell (no Claude):**

```bash
docker compose run --rm claude-code bash
```

## Customization

### Matching your host user UID/GID

If your host user isn't UID/GID 1000, update the build args in `docker-compose.yml` to avoid file permission issues on the mounted volume:

```yaml
build:
  args:
    USER_UID: 1001
    USER_GID: 1001
```

Then rebuild:

```bash
docker compose build
```

### Resetting your login

If you need to re-authenticate, remove the auth volume and run the container again:

```bash
docker volume rm docker-cluade_claude-auth
docker compose run --rm claude-code
```
