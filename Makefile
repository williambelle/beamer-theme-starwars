TEMPLATE_DIR=/tex/latex/beamer/themes/starwars
SOURCE_DIR=src
TO_COPY=beamerthemeStarWars.sty background.pdf starwars-logo.pdf
DEST_DIR := $(shell kpsewhich -var-value=TEXMFHOME)
DEST_DIR := $(DEST_DIR)$(TEMPLATE_DIR)

.PHONY: install
install:
	@echo "[install beamer theme] $(DEST_DIR)"; \
	mkdir -p $(DEST_DIR); \
	for FILE in $(TO_COPY); do \
	echo "[copy] $(SOURCE_DIR)/$$FILE"; \
	cp $(SOURCE_DIR)/$$FILE $(DEST_DIR); \
	done; \
	sudo texhash; \

.PHONY: uninstall
uninstall:
	@echo "[uninstall beamer theme] $(DEST_DIR)"; \
	rm -fr $(DEST_DIR); \
	sudo texhash; \
	
.PHONY: create-thumbs
create-thumbs:
	@echo "[create thumbs]"; \
	cd examples; \
	pdftoppm -r 300 document.pdf thumbs; \
	mogrify -format png -geometry 320x240 *.ppm; \
	rm *.ppm; \
