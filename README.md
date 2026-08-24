# 兰州大学研究生学位论文 LaTeX 模板（LZUThesis-PhD）

> 2023 新标准，参考 [兰州大学博士硕士学位论文写作格式示例.PDF](https://ge.lzu.edu.cn/xiazaizhuanqu/xuewei/2023/0328/210732.html)。
> 本仓库仅含**研究生**（博士/硕士）模板。

## 特点

- 非官方！！！！与 word 版本会略有差异。
- Linux、Mac、Windows 均可编译（Linux 需注意字体问题，见 [QA](QA.md)）。
- 布局对齐 thuThesis 工程实践：键值配置、`data/` 模块化、latexmk 一键编译、CI 防回归。

## 文档

- [**使用手册 USAGE.md**](USAGE.md) —— 快速开始、`\lzusetup` 键值参考表、正文结构、参考文献、编译打包
- [常见问题 QA.md](QA.md)
- [更新日志 CHANGELOG.md](CHANGELOG.md)

## 快速开始

```bash
make build            # 一键编译，产物 build/template-PhD.pdf
make clean            # 清理 build/
make dist             # 编译并打包发布 zip：build/LZUThesis-PhD_<版本>_<日期>.zip
```

写论文只改 `data/` 下的文件：`setup.tex`（封皮）→ `abstract.tex`（摘要）→ `chapNN.tex`（正文各章）→ `acknowledgements.tex`（致谢）。详见 [USAGE.md](USAGE.md)。

## 项目结构

```
LZUThesis-PhD.cls        格式逻辑（一般不用动）
template-PhD.tex         主文件，纯组装
data/                    论文内容（封皮/声明/摘要/正文/成果/致谢）
ref/refs.bib             参考文献数据库
figures/                 图片
build/                   编译产物（make clean 清空）
latexmkrc + Makefile     编译与打包工具链
.github/workflows/       CI 自动编译
```

## 遇到问题

先看 [QA.md](QA.md)，解决不了去 [github - issue](https://github.com/konosubakonoakua/LZUThesis2020/issues?q=) 提问。

---

更多 LaTeX 模板资源：[latexstudio](https://www.latexstudio.net)
