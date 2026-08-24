# Makefile for LZUThesis-PhD
# 用法：
#   make build    latexmk -xelatex -outdir=build 一键编译，所有产物（含 PDF）直接进 build/
#   make clean    清理 build/ 与旧 disk/ 残留
#   make dist     编译并打包发布 zip（输出到 build/）
#   make all      同 build
#   make help     显示本帮助

# 模板名与版本：打包文件名 = $(TEMPLATE)_$(VERSION)_$(DATE).zip
# （纯 ASCII 命名，避免中文文件名在控制台/zip 工具/CI 中乱码）
# VERSION 为模板版本号（大版本 5.x 起为 2026-08 工程化重构后），发布时手动递增；
# 对应标准的年份（2023 新标准）见 README/CHANGELOG。
TEMPLATE = LZUThesis-PhD
VERSION = 5.0.0
# 日期优先取最近提交日期（git 在任意 shell 都可用），无 git 时回退系统 date
FILE_DATE = `git log -1 --format=%cs 2>/dev/null || date +%Y-%m-%d`
LATEXMK = latexmk
MAIN = template-PhD
DIST_ZIP = $(TEMPLATE)_$(VERSION)_$(FILE_DATE).zip

.PHONY: all build clean clear dist help

all: build

# latexmk 从编译一开始就把 aux/bbl/pdf 全部写入 build/，根目录保持纯源码
build:
	$(LATEXMK) -xelatex -outdir=build $(MAIN)

clean:
	$(LATEXMK) -c -outdir=build $(MAIN)
	rm -rf build disk

clear: clean

# 打包：PDF + 模板源 + 文档 + 数据，zip 输出到 build/$(DIST_ZIP)
dist: build
	rm -rf build/dist
	mkdir -p build/dist
	cp build/$(MAIN).pdf build/dist/
	cp $(TEMPLATE).cls build/dist/
	cp template-PhD.tex build/dist/
	cp -r data build/dist/
	cp -r ref build/dist/
	cp -r figures build/dist/
	find build/dist/figures -name '*.psd' -delete
	cp README.md USAGE.md QA.md CHANGELOG.md LICENSE build/dist/
	cd build/dist && zip -r ../$(DIST_ZIP) . > /dev/null
	ls -l build/$(DIST_ZIP)

help:
	@echo "make build  - compile into build/ (latexmk -xelatex -outdir=build)"
	@echo "make clean  - remove build/ and stale disk/"
	@echo "make dist   - build + package zip -> build/$(DIST_ZIP)"
	@echo "make all    - alias for build"
