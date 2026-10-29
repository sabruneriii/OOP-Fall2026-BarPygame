PLANTUML = plantuml
UML_DIR = docs/uml
PNG_DIR = $(UML_DIR)/png
PUML_FILES = $(wildcard $(UML_DIR)/*.puml)
PNG_FILES = $(patsubst $(UML_DIR)/%.puml,$(PNG_DIR)/%.png,$(PUML_FILES))

.DEFAULT_GOAL := help
.PHONY: all uml create-uml clean-uml help

all: create-uml

create-uml: uml

uml: $(PNG_FILES)
	@rm -f $(PNG_DIR)/*.cmapx

$(PNG_DIR):
	mkdir -p $(PNG_DIR)

$(PNG_DIR)/%.png: $(UML_DIR)/%.puml | $(PNG_DIR)
	$(PLANTUML) -tpng -o png $<

clean-uml:
	rm -f $(PNG_DIR)/*.png $(PNG_DIR)/*.cmapx

help:
	@echo "make create-uml / make uml - Generate PlantUML diagrams"
	@echo "make clean-uml           - Remove UML images and maps"
