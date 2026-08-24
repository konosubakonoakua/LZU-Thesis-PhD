# 常见问题（QA）

> 注意！！！`LaTeX模板` 只能是与 `学校论文要求` 尽可能相同，但不完全模仿学校给的 `word示例文件`，尤其是一些特殊字体，不会去适配。

使用前请先阅读 [USAGE.md](USAGE.md)；以下问题解决不了的，去 [github - issue](https://github.com/konosubakonoakua/LZUThesis2020/issues?q=) 提出。

## 编译

推荐一键编译（自动调度 biber）：

```bash
make build        # 产物在 build/template-PhD.pdf
```

等价手动四步：`xelatex template-PhD` → `biber template-PhD` → `xelatex template-PhD` → `xelatex template-PhD`。

- 不要用 `pdflatex`；编辑器（TeXStudio / VSCode）请把编译器设为 `xelatex`、参考文献设为 `biber`。
- 环境：TeX Live 或 MiKTeX 均可，保证 `xelatex`、`biber`、`latexmk` 已安装。

### 编译出来没有参考文献或目录，或直接失败

- 先确认走了完整四步（或 `make build`），单跑一遍 xelatex 不会有参考文献。
- 删除以 `template-PhD` 开头的缓存文件（`template-PhD.tex` 不要删！！）后重新编译；或 `make clean`。
- 换用 [overleaf](https://www.overleaf.com/project) 在线编译试试。

### 编译产物在哪？根目录怎么没有 pdf？

产物统一在 `build/` 下（`make build` 用 `latexmk -outdir=build`，从编译一开始就把 aux/pdf 全部写进 build/）。根目录只留源码，这是刻意设计，不是 bug。

### biber 报错：找不到 `ref/refs.bib`

你改过 bib 文件名或路径。同步修改 `LZUThesis-PhD.cls` 第 16 节里这一行即可：

```tex
\addbibresource{ref/refs.bib}
```

### 报错：`Unknown key 'xxx' in lzusetup` 之类

`data/setup.tex` 里的 `\lzusetup{...}` 键名写错了，对照 [USAGE.md 键值表](USAGE.md#3-封皮信息lzusetupkey--value-) 检查；键名里是连字符 `-`（如 `school-code`），不是下划线。

## 字体

### Linux 环境字体导致的问题

- linux 默认没有 Arial 字体：搜索 `LZUThesis-PhD.cls` 中的 `\fontspec{Arial}`，删除该命令（英文摘要的 "Abstract" 将使用默认字体，略不符合要求），或自行安装 Arial 字体（注意是安装后的字体名，不是文件名）。
- linux 无法显示 `玥` 等生僻字：自行安装字体后自定义中文字体族：

```tex
\setCJKfamilyfont{xsong}{新宋体}   % 字体名，不是文件名
\newcommand{\xsong}{\CJKfamily{xsong}}
% 使用：{\xsong{玥}}
```

### 字母/公式加粗、花体问题

- 模板使用 `mathptmx + newtxmath`，正文字体、公式英文字体与 Times New Roman 一致。
- 花体 `\mathcal` 与 `\mathscr` 相同是 mathptmx 的固有行为；`\boldsymbol` 加粗可用（`bm` 与 `newtxmath` 冲突，模板未启用 `bm`）。

### 单独的加粗字体

```tex
\setCJKfamilyfont{csong}{宋粗体}
\newcommand{\csong}{\CJKfamily{csong}}
% 使用：{\csong\zihao{3}{诚信责任书}}
```

## 参考文献

- 引用样式为 GB/T 7714-2015，数据库在 `ref/refs.bib`，正文 `\cite{key}`。
- **建议从 Web of Science 或期刊官网导出 bib**，不要用百度学术、谷歌学术的 bib（错误很多）。
- 默认引用为行内编号（非右上角标）；要右上角标，删除 `LZUThesis-PhD.cls` 第 16 节中 `citestyle=numeric` 部分。
- 遇到问题找答案：[biblatex-gb7714-2015](https://github.com/hushidong/biblatex-gb7714-2015?tab=readme-ov-file#tutorial%E4%BD%BF%E7%94%A8%E5%85%A5%E9%97%A8)

## 排版细节

### 签名没有对齐

- [见 Issue](https://gitee.com/yuhldr/LZUThesis2020/issues/I77IDC#note_18273533)

### chapter 间距问题

`4.1.1.2025` 起已默认修正：

- [讨论 1](https://github.com/yuhldr/LZUThesis2020/issues/7)
- [讨论 2](https://gitee.com/yuhldr/LZUThesis2020/issues/I6QZKG)

### “摘要”前面的标题想手动换行

打开 `LZUThesis-PhD.cls`，搜索：

```tex
% 中文摘要
\zihao{3}\bfseries\heiti \noindent\@title\the\titlextra
% 把 \@title\the\titlextra 替换成你自己想要的标题

% 英文摘要
\zihao{3} \bfseries \noindent \expandafter\MakeUppercase\expandafter{\the\entitle\the\entitletra}
% 把 \expandafter\MakeUppercase... 替换成你自己想要的标题
```

### 封面文字位置（校址那行跑偏）

题目太长导致。搜索 `LZUThesis-PhD.cls` 中“校址”上方的 `\vspace{40pt}`（或 `100pt`），调整数字。

### 正文第一章编号成了第二章

绪论应作为第一章；多数老师不认“第 0 章”。若绪论用 `\chapter*` 则不占编号；或用 `\setcounter{chapter}{0}` 手动归零。

### 目录有页码，但要求不需要

在 `template-PhD.tex` 的 `\customcontent` 前后自行用 `\thispagestyle{empty}` 调整。

## 双面打印

默认 `\documentclass[AutoFakeBold]{LZUThesis-PhD}` 为单面电子版；打印装订用：

```tex
\documentclass[AutoFakeBold,print]{LZUThesis-PhD}
```

`print` 模式自动双面排版，每章前补空白页；正文内也可用 `\blankpage` 手动留白。

## 其他

- 在 `template-PhD.tex` 所在路径，先看 [USAGE.md](USAGE.md) 的常见操作速查，再看编译错误提示，一般都能解决。
- 若是模板 bug，请在 issue 里提交，方便别人参考，**勿**直接 QQ 联系。
- 我多次测试通过；如果你什么都没改就直接编译失败，先检查自己的环境（编译器引擎、biber、依赖包）。
