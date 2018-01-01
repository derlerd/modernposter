SRC           = modernposter.cls
DOC_SRC       = doc/modernposter.tex
DOC_PDF       = $(DOC_SRC:%.tex=%.pdf)
DEMO_SRC      = demo.tex
DEMO_PDF      = $(DEMO_SRC:%.tex=%.pdf)

ARCHIVE       = modernposter.zip

TEMP_DIR      = .temp

LATEXMK_FLAGS = -pdf -output-directory=$(TEMP_DIR)
LATEXMK       = latexmk $(LATEXMK_FLAGS) 

doc: $(DOC_PDF) $(DEMO_PDF)

clean:
	rm -rf $(TEMP_DIR) $(DOC_PDF) $(DEMO_PDF) $(ARCHIVE)

ctan: doc
	zip -j $(ARCHIVE) $(SRC) $(DOC_PDF) $(DEMO_SRC) $(DEMO_PDF)

$(DOC_PDF): 
	$(LATEXMK) $(DOC_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DOC_PDF)) $(dir $(DOC_PDF))

$(DEMO_PDF): 
	$(LATEXMK) $(DEMO_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DEMO_PDF)) $(dir $(DEMO_PDF))

