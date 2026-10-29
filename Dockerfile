FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Developer tools, PlantUML, and SDL/X11 runtime libraries for Pygame.
RUN apt-get update && apt-get install -y --no-install-recommends \
    make git curl nano ca-certificates \
    default-jre graphviz plantuml \
    libgl1 libglib2.0-0 libx11-6 libxext6 libxrender1 libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/virgin-bartending-game
COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir -r /tmp/requirements.txt

# Source is mounted by Compose; image still contains all Python/build tools.
CMD ["python", "main.py"]
