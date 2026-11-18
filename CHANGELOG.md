# Changelog

All notable changes to `sidecomments` are listed here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the package uses
[Semantic Versioning](https://semver.org/).

## 1.1.1 - 2026-11-18

### Fixed

- **Phrases containing inline math are highlighted on every line again when
  they cross a column or page break.** In 1.1 a phrase with `$...$` or
  `\(...\)` (for example `\(95\%\ \mathrm{CI}=[0.00246,0.01809]\)`) got no
  position marks, so only its first and last lines were highlighted. Marks
  that land inside math now simply do nothing, so the rest of the phrase is
  marked as usual.

### Changed

- Only a `[` **outside** math still turns off the marks for a phrase, since a
  mark inside an optional argument such as `[width=3cm, height=2cm]` would
  break it.

## 1.1 - 2026-11-17

### Fixed

- **Comments inside scaled tables now point at the right place.** A comment on
  a cell of a table shrunk with `\resizebox` or `\scalebox` used to draw its
  highlight below and to the right of the cell, because TeX reports positions
  inside a scaled box as if the box were full size. The package now records
  where each scaled box starts and by how much it is scaled, and corrects the
  highlight, frame and arrow. Scaled boxes inside scaled boxes are handled too.
- **Phrases that cross a column break are highlighted on every line.**
  Previously only the first and the last line were highlighted, and the lines
  in between were left plain.
- **Phrases that cross a page break are highlighted on the next page too.**
  Previously the highlight stopped at the bottom of the first page.

### Changed

- A highlighted phrase now places an invisible position mark after each space,
  so the package knows every line the phrase occupies. The first line is
  highlighted from the start of the phrase, the last line up to its end, and
  the lines in between across the full column width. Indented text (lists,
  quotes, abstracts) keeps its indentation as before.
- Highlights continuing below a full-width float (`figure*`, `table*`) start
  under the float instead of covering it.
- Comments whose positions are missing from the `.aux` file (for example after
  adding or removing comments) are skipped for that run instead of raising an
  error; they appear after the next compile.

### Added

- `examples/spanning/`: a two-column demo with a comment on a cell of a
  resized table, a phrase crossing a column break, and a phrase crossing a
  page break below a full-width figure. Build it with `make spanning`.
- `docs/spanning.png`: a screenshot of that demo, shown in the README.

### Known limitations

- A phrase containing `$`, `\(` or `[` gets no position marks, so that none
  ends up inside math or an optional argument. Within one column all of its
  lines are still highlighted; across a column or page break, only its first
  and last lines are. (Math no longer counts as of 1.1.1.)
- Positions inside `\rotatebox`, `\reflectbox` and `adjustbox` scaling are not
  corrected. Use `\XYbox` around such a box, or comment next to it.

### Upgrading

Replace `sidecomments.sty` with the new version and compile twice. No changes
to your document are needed. Output with `[final]` is unchanged.

## 1.0 - 2026-10-14

### Added

- First release: review comments in boxes in widened side margins, with arrows
  to the commented phrase (`\XY`), position (`\XYnote`) or box (`\XYbox`).
- `\screviewer` to define per-reviewer commands with a name and colour.
- Automatic left/right placement, stacking without overlap, and
  `final` option to hide everything and restore the original page size.
- Demos for ACL/ARR, ICLR, CVPR and AAAI.
