# Repository Conventions

## Commit Messages

- MUST use conventional commit format: `type(scope): subject`
- types: `feat` | `fix` | `refactor` | `style` | `docs` | `build` | `ci` | `chore`
- scopes: `cls` | `template` | `build` | `ci` | `docs` | `repo` (omit if not applicable)
- subject: imperative mood, English, < 72 chars; keep verification details as bullet body
- Example: `feat(cls): add \lzusetup key-value config interface`

## Build & Verify (mandatory per change)

- Compile: `make build` (= latexmk -xelatex template-PhD, auto biber)
- Regression: `pdftotext template-PhD.pdf` text diff vs baseline must be 0 lines;
  page count must stay 16 (default electronic mode)
- Commit per logical module, each with its own build + diff verification

## Layout Red Lines (do not touch)

- Cover layout (schoolcode/密级/分类号), 诚信声明+授权页, zh/en abstracts,
  chapter "第一章" 黑体三号, body 宋体小四 line-spacing 20pt,
  gb7714-2015 bibliography, LZU commands (\Achievements \Thanks \blank \tabincell)
- Config entry: `\lzusetup{...}` in `data/setup.tex`; cls structure index at file header (18 sections)
