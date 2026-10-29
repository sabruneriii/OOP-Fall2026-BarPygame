
"""Tests for the main Pygame application."""

import os
from unittest.mock import patch

os.environ["SDL_VIDEODRIVER"] = "dummy"

import pygame  # noqa: E402
from main import GameApp  # noqa: E402


def test_game_app_initialization() -> None:
    """Verify that GameApp initializes the correct window size."""
    try:
        app = GameApp()

        assert app.screen.get_size() == (960, 540)
        assert app.running is True
    finally:
        pygame.quit()


def test_game_app_quits_on_escape() -> None:
    """Verify that pressing Escape exits the application."""
    app = GameApp()

    escape_event = pygame.event.Event(
        pygame.KEYDOWN, {"key": pygame.K_ESCAPE}
    )

    try:
        with patch("pygame.event.get", return_value=[escape_event]):
            app.run()

        assert app.running is False
    finally:
        pygame.quit()


def test_game_app_quits_on_window_close() -> None:
    """Verify that closing the window exits the application."""
    app = GameApp()

    quit_event = pygame.event.Event(pygame.QUIT)

    try:
        with patch("pygame.event.get", return_value=[quit_event]):
            app.run()

        assert app.running is False
    finally:
        pygame.quit()
