EPOCH=$(shell date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")

.PHONY: clean all ctan

all: clean ctan
	$(info Complete!)

README:
	cp README.md README

clean:
	mkdir .trash-$(EPOCH)
	(test -f README          && mv -f README            .trash-$(EPOCH)/) || true
	(test -f termmenu.aux    && mv -f termmenu.aux      .trash-$(EPOCH)/) || true
	(test -f termmenu.glo    && mv -f termmenu.glo      .trash-$(EPOCH)/) || true
	(test -f termmenu.hd     && mv -f termmenu.hd       .trash-$(EPOCH)/) || true
	(test -f termmenu.idx    && mv -f termmenu.idx      .trash-$(EPOCH)/) || true
	(test -f termmenu.log    && mv -f termmenu.log      .trash-$(EPOCH)/) || true
	(test -f termmenu.out    && mv -f termmenu.out      .trash-$(EPOCH)/) || true
	(test -f termmenu.pdf    && mv -f termmenu.pdf      .trash-$(EPOCH)/) || true
	(test -f termmenu.tar.gz && mv -f termmenu.tar.gz   .trash-$(EPOCH)/) || true
	(test -f termmenu.tex    && mv -f termmenu.tex      .trash-$(EPOCH)/) || true

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

ctan: termmenu.tar.gz
