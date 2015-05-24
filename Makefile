TRASH := ./.trash-$(shell date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")
CRUFT := $(addprefix termmenu.,aux glo hd idx log out pdf tex)

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

termmenu.pdf: termmenu.dtx
	arara termmenu.dtx

termmenu.tex: termmenu.dtx
	yes | tex termmenu.ins

termmenu.zip: termmenu.pdf termmenu.dtx termmenu.ins README.md
	mkdir -p termmenu
	cp  README       termmenu/
	cp  termmenu.pdf termmenu/
	cp  termmenu.dtx termmenu/
	cp  termmenu.ins termmenu/
	zip termmenu.zip termmenu/*

termmenu.tar.gz: termmenu.pdf termmenu.tex README
	ctanify "termmenu.ins=tex/generic/termmenu" \
	"termmenu.pdf=doc/generic/termmenu" \
	"README=doc/generic/termmenu" \
	"termmenu.tex=tex/generic/termmenu" \
	"termmenu.dtx=source/generic/termmenu"

ctan: | termmenu.tar.gz clean
