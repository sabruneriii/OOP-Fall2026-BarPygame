import pygame


class GameApp:
    """Main application responsible for the Pygame window."""

    def __init__(self) -> None:
        pygame.init()

        self.screen = pygame.display.set_mode((960, 540))
        pygame.display.set_caption("Virgin Bartending Game")

        self.clock = pygame.time.Clock()
        self.running = True

    def run(self) -> None:
        """Execute the main game loop."""
        try:
            while self.running:
                for event in pygame.event.get():
                    if event.type == pygame.QUIT:
                        self.running = False
                    elif event.type == pygame.KEYDOWN:
                        if event.key == pygame.K_ESCAPE:
                            self.running = False

                self.screen.fill((30, 35, 45))
                pygame.display.flip()
                self.clock.tick(60)
        finally:
            pygame.quit()


if __name__ == "__main__":  # pragma: no cover
    GameApp().run()
