# Hacker Lang++ (`hlpp`) — LegendaryOS

Język niemal identyczny z Hacker Lang (`hl`), z OOP, wieloplatformowy, uruchamiający te same programy co `hl`
poza HackerOS. **Bytecode VM (nie tree-walk)** + **JIT z natywnym tierem 2 (Cranelift)**, napisany w 100% w H# + bit.io
(`colors`, `nidus`, `cranelift`). Tylko interpretowany — **bez AOT**.

* Gen: `using <gen 2026>` lub `using <ROLLING>` (gen 1/2 tylko jako dialekty zgodności z `hl`).
* OOP: `:+ Klasa [< Rodzic] def`, `:. metoda def`, `+> Klasa obj`, `.> obj metoda`, `:- obj`, pola `@self.pole`.
* Biblioteki: `main/*` (wbudowane + systemowe), `bit/*` (lib.hl / `.hlib`), `<<`, `<*`, GitHub.
* `.hlib`: rozpakowanie, SHA-256, AST → źródło. Cranelift jest wiązany przez API hlib: `use "hlib -> cranelift"`.
* Pamięć: bez GC; liczby w slotach, bez alokacji na gorących ścieżkach (500k iteracji pętli: 11 MB).

## Budowanie
```
hlpp build.hl++            # bit install + cranelift.hlib (--ffi) + hsharp compile  -> dist/hlpp
hlpp build.hl++ test       # testy
hlpp build.hl++ jit        # analiza JIT
./dist/hlpp templates/hello.hl++
```
Wymaga `hsharp`, `hackerc`, `bit` i `cargo` (cargo tylko dla biblioteki cranelift). Bez istniejącego `hlpp`:
`packaging/linux/install.sh`. Szczegóły: `docs/JIT.md`.

CLI: `hlpp plik`, `run`, `check`, `dump` (disassembler), `jit` (analiza IR/CLIF), `-e`, `repl`, `version`,
`--stats`, `--trace`, `--no-color`, `--no-jit`, `--no-native`.

## Testy (napisane w Hacker Lang++)
* `tests/run_examples.hlpp [hlpp]` — każdy program z `templates/` w trzech trybach (JIT natywny, `--no-native`, `--no-jit`) vs `tests/expected/`.
* `tests/jit_tiers.hlpp [hlpp]` — spójność warstw na `tests/jit/` + wymóg regionu natywnego.
* `tests/diff_vs_hl.hlpp <hl> <hlpp> [ścieżki]` — porównanie z referencyjnym `hl` (korpus: `tests/corpus`).
* `tests/show.hlpp <plik.hl>` — pokazuje różnice `hl` vs `hlpp`.

## Strona
`website/` — strona projektu napisana w HackerScript (`use <mode:website>`): `cd website && hackerc website cmd/main.hcs -o dist`.

## Struktura
`hlpp/src`: lexer → kompilator jednoprzebiegowy → VM (`hlpp_exec`), `hlpp_cu` (coreutils), `hlpp_oop`,
`hlpp_load` (importy), `hlpp_hlib`, `hlpp_jit` (fasada), `hlpp_diag` (nidus). `tools/gen_ops.py`
generuje tablicę opkodów, `tools/gen_stdlib.py` osadza main-libs.

## Dokumentacja
`docs/LANGUAGE.md` (składnia), `docs/JIT.md` (warstwy, ABI, Cranelift przez hlib), `docs/KNOWN_ISSUES.md`.
