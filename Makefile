PACKAGE = termmenu
TRASH := ./.trash-$(shell date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")
CRUFT := $(addprefix $(PACKAGE).,aux glo hd idx log out toc) README $(PACKAGE)-demo.log

.PHONY: clean all ctan

all: clean ctan
	$(info Complete!)

README:
	cp README.md README

clean:
	mkdir $(TRASH)
	mv $(foreach file,$(CRUFT),$(file)) $(TRASH)/ 2>/dev/null || true

hard-clean: clean
	rm -rf .trash-*/
	rm -f $(PACKAGE).pdf
	rm -f $(PACKAGE).tex

$(PACKAGE).pdf: $(PACKAGE).dtx
	arara $(PACKAGE).dtx

$(PACKAGE).tex: $(PACKAGE).dtx
	yes | tex $(PACKAGE).ins

$(PACKAGE).zip: $(PACKAGE).pdf $(PACKAGE).dtx $(PACKAGE).ins README.md
	mkdir -p $(PACKAGE)
	cp  README         $(PACKAGE)/
	cp  $(PACKAGE).pdf $(PACKAGE)/
	cp  $(PACKAGE).dtx $(PACKAGE)/
	cp  $(PACKAGE).ins $(PACKAGE)/
	zip $(PACKAGE).zip $(PACKAGE)/*

$(PACKAGE).tar.gz: $(PACKAGE).pdf $(PACKAGE).tex README
	ctanify "$(PACKAGE).ins=tex/generic/$(PACKAGE)" \
	"$(PACKAGE).pdf=doc/generic/$(PACKAGE)" \
	"README=doc/generic/$(PACKAGE)" \
	"$(PACKAGE)-demo.tex=doc/generic/$(PACKAGE)" \
	"$(PACKAGE).tex=tex/generic/$(PACKAGE)" \
	"$(PACKAGE).dtx=source/generic/$(PACKAGE)"

ctan: | $(PACKAGE).tar.gz clean
