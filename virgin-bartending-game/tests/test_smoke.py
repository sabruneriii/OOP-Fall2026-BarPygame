"""Basic smoke test that does not require a graphical display."""
import pygame


def test_pygame_can_initialize_headlessly() -> None:
    pygame.display.init()
    try:
        display = pygame.display.set_mode((1, 1))
        assert display.get_size() == (1, 1)
    finally:
        pygame.display.quit()
