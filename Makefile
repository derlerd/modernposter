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

CTAN_CONTENT  = README.md $(SRC) $(DOC_SRC) $(DOC_PDF) $(DEMO_SRC) $(DEMO_PDF)

VERSION      := $(shell cat version)

BUILD_FILE    = build
BUILD        := $(shell cat $(BUILD_FILE))

README        = README.md


all: archive

ctan: clean ctan-version archive

doc: $(DOC_PDF) $(DEMO_PDF)

install: $(DOC_PDF)
	mkdir -p $(TEXMF_SRC)
	mkdir -p $(TEXMF_DOC)
	cp $(SRC) $(TEXMF_SRC)
	cp $(DOC_PDF) $(TEXMF_DOC)

clean:
	rm -rf $(TEMP_DIR) $(DOC_PDF) $(DEMO_PDF) $(ARCHIVE)

archive: doc
	mkdir $(PROJECT)
	cp -t $(PROJECT) $(CTAN_CONTENT)
	zip -r $(ARCHIVE) $(PROJECT)
	rm -rf $(PROJECT)
	
ctan-version:
	sed -i -s 's@20[0-9][0-9]/[0-9]*/[0-9]* v[0-9]*.[0-9]*.[0-9]*@$(shell date "+%Y/%m/%d") v$(VERSION).$(BUILD)@' $(SRC) $(README)
	sed -i -s 's@[0-9]*.[0-9]*.[0-9]* 20[0-9][0-9]/[0-9]*/[0-9]*@$(VERSION).$(BUILD) $(shell date "+%Y/%m/%d")@' $(DOC_SRC) $(DEMO_SRC) $(SRC)
	echo $$(($(BUILD) + 1)) > $(BUILD_FILE) 

	
$(DOC_PDF): 
	$(LATEXMK) $(DOC_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DOC_PDF)) $(dir $(DOC_PDF))

$(DEMO_PDF): 
	$(LATEXMK) $(DEMO_SRC)
	cp  $(TEMP_DIR)/$(notdir $(DEMO_PDF)) $(dir $(DEMO_PDF))

