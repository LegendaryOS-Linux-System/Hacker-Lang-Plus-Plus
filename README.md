# Hacker Lang++ (`hlpp`) — LegendaryOS

Język niemal identyczny z Hacker Lang (`hl`), z OOP, wieloplatformowy, uruchamiający te same programy co `hl`
poza HackerOS. **Bytecode VM (nie tree-walk)**, napisany w 100% w H# + bit.io (`colors`, `nidus`).

* Gen: `using <gen 2026>` lub `using <ROLLING>` (gen 1/2 tylko jako dialekty zgodności z `hl`).
* OOP: `:+ Klasa [< Rodzic] def`, `:. metoda def`, `+> Klasa obj`, `.> obj metoda`, `:- obj`, pola `@self.pole`.
* Biblioteki: `main/*` (wbudowane + systemowe), `bit/*` (lib.hl / `.hlib`), `<<`, `<*`, GitHub.
* `.hlib`: rozpakowanie, SHA-256, AST → źródło (docs/HLIB_FINDINGS.md).
* Pamięć: bez GC; liczby w slotach, bez alokacji na gorących ścieżkach (500k iteracji pętli: 11 MB).

## Budowanie
```
cd hlpp && hsharp compile src/main.h# -o hlpp --release   # lub packaging/install.sh
./hlpp ../examples/oop_basic.hlpp
```
CLI: `hlpp plik`, `run`, `check`, `dump` (disassembler), `-e`, `repl`, `version`, `--stats`, `--trace`, `--no-color`.

## Testy
* `tests/diff_vs_hl.sh <hl> <hlpp> <katalogi>` — porównanie z referencyjnym `hl` (28/32 programów z repo;
  4 różnice to znane błędy `hl`, zob. docs/HL_DIVERGENCES.md).
* `tests/run_examples.sh <hlpp>` — funkcje tylko Hacker Lang++.

## Struktura
`hlpp/src`: lexer → kompilator jednoprzebiegowy → VM (`hlpp_exec`), `hlpp_cu` (coreutils), `hlpp_oop`,
`hlpp_load` (importy), `hlpp_hlib`, `hlpp_jit` (fasada), `hlpp_diag` (nidus). `tools/gen_ops.py`
generuje tablicę opkodów, `tools/gen_stdlib.py` osadza main-libs.

## Dokumentacja
`docs/HSHARP_CODEGEN_BUGS.md` (błędy H#, B01–B18, z repro i poprawkami), `docs/HLIB_FINDINGS.md`,
`docs/JIT.md`, `docs/HL_DIVERGENCES.md`, `docs/LANGUAGE.md`.
