DOCKER = docker compose
SERVICE = game
GAME_DIR = virgin-bartending-game
TEST_ARGS = -s --verbose --color=yes
TYPE_ARGS = --strict --allow-untyped-decorators --ignore-missing-imports
RUN = $(DOCKER) run --rm --no-deps $(SERVICE)
HEADLESS = $(DOCKER) run --rm --no-deps -e SDL_VIDEODRIVER=dummy $(SERVICE)

.DEFAULT_GOAL := help
.PHONY: all build run check-style fix-style check-type check-types \
    run-security-check run-test run-test-coverage create-docs create-uml \
    uml clean clean-uml help

all: check-style check-types run-security-check run-test
	@echo "All checks passed!"

build:
	$(DOCKER) build $(SERVICE)

# WSLg X11 access is provided only to the interactive run target.
run:
	$(DOCKER) run --rm --no-deps \
		-e DISPLAY="$${DISPLAY:-:0}" \
		-e SDL_VIDEODRIVER=x11 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(SERVICE)

check-style:
	$(HEADLESS) flake8 main.py tests

fix-style:
	$(HEADLESS) autopep8 --in-place --recursive --aggressive --aggressive main.py tests

check-types:
	$(HEADLESS) mypy $(TYPE_ARGS) main.py

check-type: check-types

run-security-check:
	$(HEADLESS) bandit -r main.py

.PHONY: run-test
run-test:
	docker compose run --rm --no-deps \
		-e SDL_VIDEODRIVER=dummy \
		game python -m pytest -s --verbose --color=yes tests/

.PHONY: run-test-coverage
run-test-coverage:
	docker compose run --rm --no-deps \
		-e SDL_VIDEODRIVER=dummy \
		game python -m pytest -s --verbose --color=yes \
		--cov=main \
		--cov-report=term-missing \
		--cov-report=html:docs/htmlcov tests/

create-docs:
	$(HEADLESS) pdoc -o docs/code-docs main

create-uml:
	$(HEADLESS) make create-uml

uml: create-uml

clean-uml:
	$(HEADLESS) make clean-uml

clean:
	find $(GAME_DIR) -type d \
		\( -name __pycache__ -o -name .pytest_cache -o -name .mypy_cache -o -name .hypothesis \) \
		-prune -exec rm -rf {} +
	find $(GAME_DIR) -type f -name .coverage -delete

help:
	@echo "make build              Build the unified Docker image"
	@echo "make run                Open the Pygame window via WSLg"
	@echo "make check-style        Run flake8 in Docker"
	@echo "make fix-style          Apply autopep8 in Docker"
	@echo "make check-types        Run strict mypy in Docker"
	@echo "make run-security-check Run Bandit in Docker"
	@echo "make run-test           Run headless pytest in Docker"
	@echo "make run-test-coverage  Generate pytest coverage report"
	@echo "make create-docs        Generate pdoc documentation"
	@echo "make create-uml         Generate PlantUML diagrams"
	@echo "make clean-uml          Clean generated UML PNG files"
	@echo "make clean              Remove Python test caches"
	@echo "make all                Run all quality checks"
