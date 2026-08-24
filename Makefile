VERSION = 2023-standard
FILE_DATE = `date +%Y-%m-%d`

clear:
	rm -rf disk
	rm -rf build


PhD:
	rm -rf build/PhD disk/PhD*
	mkdir -p disk
	mkdir -p build/PhD

	cp references.bib build/PhD/
	cp -r figures build/PhD/
	rm build/PhD/figures/*.psd

	cp template-PhD.tex build/PhD/template.tex
	cp LZUThesis-PhD.cls build/PhD/

	cd build && mv PhD_${VERSION}_${FILE_DATE} && zip -r ../disk/PhD.zip 研究生_${VERSION}_${FILE_DATE}

	ls -l disk/


all: clear PhD


test: all
	cd build/研究生_${VERSION}_${FILE_DATE} && xelatex template.tex && biber template && xelatex template.tex && xelatex template.tex

