# vim: set ft=perl:
# latexmk 配置：xelatex + biber 编译链（兰州大学研究生论文模板）
# 用法：latexmk -xelatex template-PhD   （或 make build）
# 它会自动判断何时运行 biber，重复编译直至引用稳定。

$pdf_mode = 1;   # xelatex 直接输出 PDF（无需 xdvipdfmx 环节）

$xelatex = "xelatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S";

# 参考文献：优先 biber（biblatex 后端），latexmk 根据 .bcf 自动调度
$bibtex_use = 1.5;
$biber = "biber %O %S";

$clean_ext = "bbl bcf run.xml synctex.gz xdv";
