
# PlantUML configuration
PLANTUML = plantuml
UML_DIR = docs/uml
PNG_DIR = $(UML_DIR)/png

# Find all PlantUML source files
PUML_FILES = $(wildcard $(UML_DIR)/*.puml)

# Determine corresponding PNG output files
PNG_FILES = $(patsubst $(UML_DIR)/%.puml,$(PNG_DIR)/%.png,$(PUML_FILES))

.PHONY: all uml clean-uml help

# Default target
all: uml

# Generate all UML diagrams
uml: $(PNG_FILES)
	@rm -f $(PNG_DIR)/*.cmapx

# Create output directory
$(PNG_DIR):
	mkdir -p $(PNG_DIR)

# Convert each .puml file to PNG
$(PNG_DIR)/%.png: $(UML_DIR)/%.puml | $(PNG_DIR)
	$(PLANTUML) -tpng -o png $<

# Remove generated images and image maps
clean-uml:
	rm -f $(PNG_DIR)/*.png $(PNG_DIR)/*.cmapx

# Display available commands
help:
	@echo "Available commands:"
	@echo "  make uml        - Generate all UML PNG diagrams"
	@echo "  make clean-uml  - Remove generated UML files"
	@echo "  make all        - Build all project targets"
