.PHONY: clean

termmenu.pdf: termmenu.dtx
	arara termmenu.dtx

clean:
	rm termmenu.zip
	rm -rf termmenu

termmenu.zip: termmenu.pdf termmenu.dtx termmenu.ins README.md
	mkdir -p termmenu
	cp  README.md    termmenu/README
	cp  termmenu.pdf termmenu/
	cp  termmenu.dtx termmenu/
	cp  termmenu.ins termmenu/
	zip termmenu.zip termmenu/*
