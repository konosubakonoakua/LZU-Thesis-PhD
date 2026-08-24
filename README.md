# 兰州大学毕业论文 LaTeX 模板

- 研究生：2023 新标准，[兰州大学博士硕士学位论文写作格式示例.PDF](https://ge.lzu.edu.cn/xiazaizhuanqu/xuewei/2023/0328/210732.html)

## 特点

- 非官方！！！！与 word 版本会略有差异。
- 仅包含 “研究生” 模板。
- 有问题可以 [github - issue](https://github.com/konosubakonoakua/LZUThesis2020/issues?q=)。
- Linux、Mac、Windows 都能使用，有问题看文档：[常见问题](QA.md)

---

## 使用方法

- 写完论文一定要再回来看看，在这期间模板是不是有所改变！！[更新日志](CHANGELOG.md)
- 遇到问题先看 [常见问题](QA.md)

### 编译方式

推荐用 `latexmk` 一键编译（自动调度 biber，等价于 xelatex → biber → xelatex → xelatex）：

```bash
make build            # 或 latexmk -xelatex template-PhD
make clean            # 清理中间产物
make dist             # 编译并打包发布 zip
```

或者手动四步：`xelatex template-PhD` → `biber template-PhD` → `xelatex template-PhD` → `xelatex template-PhD`。

双面打印版：`\documentclass[AutoFakeBold,print]{LZUThesis-PhD}`（默认 `electronic` 为单面电子版）。

---

## 项目主要文件

本项目精简了文件，只有 `*.cls` 和 `bib`、`figure` 文件夹是必须的

- [ref/refs.bib](ref/refs.bib) 是用来放你的参考文献的（与 thuThesis 布局一致；改名需同步改 `LZUThesis-PhD.cls` 里的 `\addbibresource`）

- [figure](figure) 文件夹是一个图和导师签名

- [LZUThesis.cls](LZUThesis.cls) 这是本科生模板配置文件，最初根据 [这个](https://github.com/suchot/LZUThesis2017) 修改的

- [template.tex](template.tex) 是本科生用来写论文的，这个文件名字可以修改

- [LZUThesis-PhD.cls](LZUThesis-PhD.cls) 这是研究生模板配置文件，来自 [这里](https://github.com/JChrysanthemum/LZUThesis2020-PgD-PhD.git)，他根据我这个修改的，改了很多很多，但是好像不维护了，有问题在我这里提问我来修改

- [template-PhD.tex](template-PhD.tex) 是研究生用来写论文的，这个文件名字可以修改；主文件只做组装，内容在 [data/](data/) 目录：
  - [data/setup.tex](data/setup.tex) —— 封皮信息，用 `\lzusetup{...}` 键值方式填写
  - [data/statement.tex](data/statement.tex) —— 诚信说明页 / 授权说明书（签名）
  - [data/abstract.tex](data/abstract.tex) —— 中英文摘要
  - [data/chap01.tex](data/chap01.tex) —— 正文第一章示例，后续章节复制为 `chap02.tex` 等并在主文件 `\input`
  - [data/achievements.tex](data/achievements.tex) —— 在学期间的研究成果
  - [data/acknowledgements.tex](data/acknowledgements.tex) —— 致谢

- [latexmkrc](latexmkrc) + [Makefile](Makefile) —— 一键编译与打包配置（`make build` / `make dist`）

---

## 代码贡献说明

[PR 说明](md/CONTRIBUTE.md)

## 其他

简单做了两个答辩 `latex` 的 PPT 模板：[这里](md/OTHER.md)

---

## 更新说明

[](CHANGELOG.md)

---

更多 LaTex 模板资源可以去：[latexstudio](https://www.latexstudio.net)，资源和一些教程确实不错
