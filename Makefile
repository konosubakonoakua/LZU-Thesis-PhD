# Makefile for LZUThesis-PhD
# 用法：
#   make build    latexmk -xelatex 一键编译（自动调度 biber，等价于 xelatex->biber->xelatex->xelatex）
#   make clean    清理编译中间产物与 build/disk 目录
#   make dist     编译并打包发布 zip（cls/tex/data/figures/bib/PDF）
#   make all      同 build

VERSION = 2023-standard
FILE_DATE = `date +%Y-%m-%d`
LATEXMK = latexmk
MAIN = template-PhD

.PHONY: all build clean clear dist

all: build

build:
	$(LATEXMK) -xelatex $(MAIN)

clean:
	$(LATEXMK) -c $(MAIN)
	rm -rf build disk

clear: clean

dist: build
	rm -rf build/dist disk
	mkdir -p disk build/dist
	cp $(MAIN).pdf build/dist/
	cp LZUThesis-PhD.cls build/dist/
	cp template-PhD.tex build/dist/
	cp -r data build/dist/
	cp -r ref build/dist/
	cp -r figures build/dist/
	rm -f build/dist/figures/*.psd
	cd build/dist && zip -r ../../disk/研究生_$(VERSION)_$(FILE_DATE).zip . > /dev/null
	ls -l disk/
