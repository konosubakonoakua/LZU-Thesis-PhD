# Makefile for LZUThesis-PhD
# 用法：
#   make build    latexmk -xelatex 一键编译（自动调度 biber），产物 PDF 输出到 build/
#   make clean    清理编译中间产物与 build/disk 目录
#   make dist     编译并打包发布 zip（cls/tex/data/ref/figures/PDF）
#   make all      同 build

VERSION = 2023-standard
FILE_DATE = `date +%Y-%m-%d`
LATEXMK = latexmk
MAIN = template-PhD

.PHONY: all build clean clear dist

all: build

# 编译后在根目录生成 $(MAIN).pdf，随后移入 build/ 并清理中间产物
# （latexmk -c 只清 aux 类文件，不动已移走的 pdf）
build:
	$(LATEXMK) -xelatex $(MAIN)
	mkdir -p build
	mv -f $(MAIN).pdf build/
	$(LATEXMK) -c $(MAIN)

clean:
	$(LATEXMK) -c $(MAIN)
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
