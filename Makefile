# Makefile for LZUThesis-PhD
# 用法：
#   make build    latexmk -xelatex -outdir=build 一键编译，所有产物（含 PDF）直接进 build/
#   make clean    清理 build/disk 目录
#   make dist     编译并打包发布 zip（cls/tex/data/ref/figures/PDF）
#   make all      同 build

VERSION = 2023-standard
FILE_DATE = `date +%Y-%m-%d`
LATEXMK = latexmk
MAIN = template-PhD

.PHONY: all build clean clear dist

all: build

# latexmk 从编译一开始就把 aux/bbl/pdf 全部写入 build/，根目录保持纯源码
build:
	$(LATEXMK) -xelatex -outdir=build $(MAIN)

clean:
	$(LATEXMK) -c -outdir=build $(MAIN)
	rm -rf build disk

clear: clean

dist: build
	rm -rf build/dist disk
	mkdir -p disk build/dist
	cp build/$(MAIN).pdf build/dist/
	cp LZUThesis-PhD.cls build/dist/
	cp template-PhD.tex build/dist/
	cp -r data build/dist/
	cp -r ref build/dist/
	cp -r figures build/dist/
	rm -f build/dist/figures/*.psd
	cd build/dist && zip -r ../../disk/研究生_$(VERSION)_$(FILE_DATE).zip . > /dev/null
	ls -l disk/
