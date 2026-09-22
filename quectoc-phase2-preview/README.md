# QuectoC Phase 2 - standalone preview project

Companion to MountainC_Phase_2_QuectoC_Standalone_Project_Setup_Guide.pdf.
Aligned with MountainC_Phase_2_QuectoC_Introductory_Preview.pdf.

The top-level project starts at checkpoint 1. No Phase 1 repository is needed.
The unchanged reference implementations and 26 input files per checkpoint are
retained in Checkpoints/. Work on the top-level files.

## Linux / GitHub Codespaces setup

```bash
sudo apt update
sudo apt install -y flex bison build-essential python3 git unzip tree
bison --version
flex --version
```

Bison 3.6 or newer is required. From this folder:

```bash
bash build.sh
./build/quectoc-parser tests/one_declaration.qc
python3 tests/check.py build/quectoc-parser
```

Expected: Syntax accepted. and 28/28 checks passed.

## Progress through the checkpoints

At checkpoint 2, edit the grammar in parser.y following the guide, then:

```bash
cp Checkpoints/02_Expressions/tests/cases.json tests/cases.json
bash build.sh
python3 tests/check.py build/quectoc-parser
```

At checkpoint 3, extend program / statements / statement as the guide shows:

```bash
cp Checkpoints/03_Statements/tests/cases.json tests/cases.json
bash build.sh
python3 tests/check.py build/quectoc-parser
```

The scanner, driver and build commands are identical at every checkpoint.
The reference files in Checkpoints/ can be compared with your working files.

## Optional command-line CMake build

CMake 3.16 or newer is required. No IDE is required.

```bash
sudo apt install -y cmake
cmake --version
cmake -S . -B build-cmake
cmake --build build-cmake
./build-cmake/quectoc-parser tests/one_declaration.qc
python3 tests/check.py build-cmake/quectoc-parser
```

Use cmake --build build-cmake again after changing scanner.l, parser.y or main.c.
The build/ folder belongs to build.sh; build-cmake/ belongs to CMake.
COMPILE_FLAGS keeps the CMake configuration compatible with CMake 3.x;
CMake 4.x accepts this older spelling too.

## Boundaries

The executable validates syntax. It does not build an AST, evaluate expressions,
execute print, or check declarations or types. KW_INT is recognized by the
scanner but unused by the grammar. Unary minus is outside the preview.

Exit 0: accepted. Exit 1: parser/scanner failure. Exit 2: usage or open-file error.
Generated files stay in ignored build folders. Record learning in Reporting/notes.md.
