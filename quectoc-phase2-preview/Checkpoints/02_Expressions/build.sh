#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
# -d produces the token header used by scanner.l.
bison -Wall -Werror=conflicts-sr -Werror=conflicts-rr -d \
  -o build/parser.tab.c parser.y
flex -o build/lex.yy.c scanner.l
gcc -std=c11 -Wall -Wextra -I build \
  build/parser.tab.c build/lex.yy.c main.c -o build/quectoc-parser
