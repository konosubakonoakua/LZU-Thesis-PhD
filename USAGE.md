# 使用手册（LZUThesis-PhD）

> 兰州大学研究生学位论文 LaTeX 模板（2023 新标准）使用指南。
> 面向用模板写论文的同学；模板开发者看 [AGENTS.md](AGENTS.md)。

## 1. 快速开始

前置环境：TeX Live 2023+（或 MiKTeX），确保 `xelatex`、`biber`、`latexmk` 可用。

```bash
make build        # 一键编译（latexmk 自动调度 biber）
```

产物在 `build/template-PhD.pdf`。根目录始终只保留源码，所有编译中间文件都在 `build/`。

写论文只需改 4 个地方：

| 你要写什么 | 改哪个文件 |
|---|---|
| 封皮（题目/作者/导师…） | `data/setup.tex` |
| 中英文摘要 | `data/abstract.tex` |
| 正文各章 | `data/chap01.tex`（新增章节复制为 `chapNN.tex`） |
| 致谢 | `data/acknowledgements.tex` |

## 2. 目录结构

```
LZU-Thesis-PhD/
├── LZUThesis-PhD.cls        # 全部格式逻辑（一般不用动）
├── template-PhD.tex         # 主文件，只负责组装
├── data/                    # 你的论文内容
│   ├── setup.tex            #   封皮信息（\lzusetup{...}）
│   ├── statement.tex        #   诚信说明 / 授权说明书（签名）
│   ├── abstract.tex         #   中英文摘要
│   ├── chap01.tex           #   第一章示例，新增章复制为 chapNN.tex
│   ├── achievements.tex     #   在学期间的研究成果
│   └── acknowledgements.tex #   致谢
├── ref/refs.bib             # 参考文献数据库
├── figures/                 # 图片
├── build/                   # 编译产物（git 忽略，make clean 清空）
├── latexmkrc + Makefile     # 编译/打包工具链
└── .github/workflows/       # CI 自动编译
```

## 3. 封皮信息：`\lzusetup{key = value, ...}`

所有封皮/声明/成绩字段统一在 `data/setup.tex` 里用键值方式填写（兼容旧命令，二者可混用，后者覆盖前者）。

**封面字段：**

| 键 | 说明 | 示例 |
|---|---|---|
| `school-code` | 学校代码 | `10730` |
| `secret` | 密级 | `公开` |
| `cid` | 分类号 | `533`（自行查本专业） |
| `degree-type` | 博士 / 硕士 | `博士` |
| `degree` | 学术学位 / 专业学位 | `\quad 学\quad 术\quad 学\quad 位\quad` |
| `title` | 中文题目，**必须双层花括号** | `{{第一行}{第二行}}` |
| `title-en` | 英文题目，双层花括号，多行开头加空格防粘连 | `{{ English}{ Title}}` |
| `author` | 作者姓名 | `张三` |
| `major` | 学科专业 | `一级学科·专业` |
| `research` | 研究方向 | `研究方向` |
| `education` | 学历教育/同等学力 | `学历教育/同等学力人员申请博士学位` |
| `supervisor` | 指导教师 | `xxx 教授/研究员` |
| `co-supervisor` | 合作导师（可空，但不可没有该键） | `xxx 教授/研究员` |
| `work-period` | 论文工作时间段 | `2020 年 7 月\quad 至 \quad 2021 年 3 月` |
| `defense-date` | 答辩日期 | `2021 年 5 月` |

**声明页签名（图片，写在 `data/statement.tex`）：**

| 键 | 说明 |
|---|---|
| `signature` | 本人签名（\includegraphics） |
| `signature-date` | 本人签名日期 |
| `supervisor-signature` | 导师签名 |
| `supervisor-date` | 导师签名日期 |
| `recommended-grade` | 建议成绩 |

**成绩页：**

| 键 | 说明 |
|---|---|
| `supervisor-comment` | 导师评语 |
| `committee-comment` | 答辩小组意见 |
| `final-grade` | 最终成绩 |

> 提示：标题必须双层花括号——外层是 `\lzusetup` 的值，内层是封面上标题的换行分组；单层会导致封面解析失败。

## 4. 正文结构

- **新增章节**：复制 `data/chap01.tex` 为 `data/chap02.tex`，在 `template-PhD.tex` 的 `\mainmatter` 里加一行 `\input{data/chap02}`。
- **章节层级**：`\chapter`（第一章）/ `\section`（1.1）/ `\subsection`（1.1.1），编号自动。
- **符号/缩略词对照表**：在 `\frontmatter` 内、目录之后使用：

  ```tex
  \begin{lzudenotation}
    SS & Spread Spectrum & 扩展频谱 \\
    PAPR & Peak to Average Power Ratio & 峰均比 \\
  \end{lzudenotation}
  ```

- **输出模式**：`\documentclass[AutoFakeBold]{LZUThesis-PhD}`（默认电子版单面）；打印装订版用 `\documentclass[AutoFakeBold,print]{LZUThesis-PhD}`（双面，每章自动补空白页）。
- **兰大专用命令**：`\blank`（空行，罗列成果用）、`\blankpage`（空白页，双面打印留白）、`\tabincell{c}{换行\\内容}`（表格单元格内换行）、`\Achievements`（在学期间成果）、`\Thanks`（致谢）。

## 5. 参考文献

- 文献库在 `ref/refs.bib`，正文用 `\cite{key}` 引用，样式为 GB/T 7714-2015。
- **推荐从 Web of Science / 期刊官网导出 bib**，不要用百度学术、谷歌学术的 bib（错误多）。
- 默认引用为行内编号（非右上角标）；如需右上角标，删除 `LZUThesis-PhD.cls` 第 16 节里 `citestyle=numeric` 部分。
- 改了 bib 文件名？同步改 `LZUThesis-PhD.cls` 里的 `\addbibresource{ref/refs.bib}` 那一行。

## 6. 编译与打包

```bash
make build    # 编译，产物 build/template-PhD.pdf
make clean    # 清空 build/ 与打包产物
make dist     # 编译并打包发布 zip（给他人/上传用）
```

等价的手动四步：

```bash
xelatex template-PhD
biber template-PhD
xelatex template-PhD
xelatex template-PhD
```

> 注：`make build` 已把全部产物直接写入 `build/`（`latexmk -outdir=build`），根目录不会出现任何临时文件；`\input{data/...}` 与 `figures/` 的相对路径不受影响。

## 7. 常见操作速查

- **图片**：`\begin{figure}[htbp] \centering \includegraphics[width=0.8\textwidth]{figures/xx.png} \caption{...}\label{fig:xx} \end{figure}`；子图用 `\subfloat`。
- **表格**：三线表 `\toprule / \midrule / \bottomrule`（booktabs）。
- **公式**：`\begin{equation}\label{eq:xx} ... \end{equation}`；多行 `gather`；多情况 `cases`。
- **算法伪代码**：`algorithm + algorithmic` 环境。
- **交叉引用**：`\ref` / `\hyperref[tbl:xx]{表 1-1}`；智能引用 `\cref`（会输出"图/表/式/第X章"中文格式）。
- **脚注**：自动每页重新编号。

遇到问题先看 [常见问题 QA.md](QA.md)。
