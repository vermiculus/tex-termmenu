.PHONY: clean all

all: termmenu.tex termmenu.pdf termmenu.zip
	$(info Complete)

clean:
	rm termmenu.zip
	rm -rf termmenu

termmenu.pdf: termmenu.dtx
	arara termmenu.dtx

termmenu.tex: termmenu.dtx
	rm -f termmenu.tex
	tex termmenu.ins

termmenu.zip: termmenu.pdf termmenu.dtx termmenu.ins README.md
	mkdir -p termmenu
	cp  README.md    termmenu/README
	cp  termmenu.pdf termmenu/
	cp  termmenu.dtx termmenu/
	cp  termmenu.ins termmenu/
	zip termmenu.zip termmenu/*
