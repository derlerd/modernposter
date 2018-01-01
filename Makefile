PROJECT       = modernposter

SRC           = modernposter.cls
DOC_SRC       = doc/modernposter.tex
DOC_PDF       = $(DOC_SRC:%.tex=%.pdf)
DEMO_SRC      = demo.tex
DEMO_PDF      = $(DEMO_SRC:%.tex=%.pdf)

ARCHIVE       = modernposter.zip

TEMP_DIR      = .temp

LATEXMK_FLAGS = -pdf -output-directory=$(TEMP_DIR)
LATEXMK       = latexmk $(LATEXMK_FLAGS) 

TEXMF_SRC     = ~/texmf/tex/latex/modernposter/
TEXMF_DOC     = ~/texmf/doc/latex/modernposter/

CTAN_CONTENT = README.md $(SRC) $(DOC_PDF) $(DEMO_SRC) $(DEMO_PDF)


all: ctan

doc: $(DOC_PDF) $(DEMO_PDF)

install: $(DOC_PDF)
	mkdir -p $(TEXMF_SRC)
	mkdir -p $(TEXMF_DOC)
	cp $(SRC) $(TEXMF_SRC)
	cp $(DOC_PDF) $(TEXMF_DOC)

clean:
	rm -rf $(TEMP_DIR) $(DOC_PDF) $(DEMO_PDF) $(ARCHIVE) $(PROJECT)

ctan: doc
	mkdir $(PROJECT)
	cp -t $(PROJECT) $(CTAN_CONTENT)
	zip -r $(ARCHIVE) $(PROJECT)
	
$(DOC_PDF): 
	$(LATEXMK) $(DOC_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DOC_PDF)) $(dir $(DOC_PDF))

$(DEMO_PDF): 
	$(LATEXMK) $(DEMO_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DEMO_PDF)) $(dir $(DEMO_PDF))

