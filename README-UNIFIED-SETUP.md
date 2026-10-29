# Unified Docker + Pygame setup

This is a **merge overlay** for `~/CSCI375/OOP-Fall2026-BarPygame`, not a replacement repository. It does not include your existing game `main.py`, UML sources, code, CI files, or git history.

## Before copying

1. At the repository root, ensure `virgin-bartending-game/main.py` exists and is the baseline Pygame app that already opened successfully.
2. Back up `Dockerfile`, `docker-compose.yml`, `Makefile`, `requirements.txt`, `virgin-bartending-game/Makefile`. Do not overwrite your `.env` or existing project files.
3. Review the `requirements.txt` compatibility with Python 3.10. This overlay retains your supplied list, including optional class tools like `kattis-cli`, `jupyter`, and `pymongo[srv]`. If pip cannot resolve a package, inspect the failing package rather than blindly replacing versions.
4. Copy the overlay files into matching paths in the repository. Keep your existing `virgin-bartending-game/docs/uml/*.puml` files.

## Commands (from repository root)

    make build
    make run
    make run-test
    make check-style
    make check-types
    make run-security-check
    make create-uml
    make all

`make run` uses WSLg X11. The test and lint targets use SDL's dummy video driver and do not mount X11; this supports CI. The test is a Pygame display smoke test. It doesn't prove gameplay logic or the window rendering on Windows.

## Notes

- One Python version (3.10), one Dockerfile, one Compose service. No local venv needed.
- The original developer container has been replaced in this proposal. Keep a backup until the new image builds and checks pass.
- The Docker image runs as your host uid/gid (defaults to 1000:1000); override with `LOCAL_UID=$(id -u) LOCAL_GID=$(id -g) make run` if needed.
- Audio is deliberately disabled until PulseAudio/WSLg audio is configured.
- This package preserves the separate *root* and *game* Makefiles: the game Makefile handles UML generation; the root Makefile handles Docker and quality checks.
- If CI runs `make all`, build the image first with `make build`. CI runners need Docker Engine and Compose available.
- We could not test the Docker build here because Docker Engine isn't available in this workspace; `make -n` validation only checks command expansion.
