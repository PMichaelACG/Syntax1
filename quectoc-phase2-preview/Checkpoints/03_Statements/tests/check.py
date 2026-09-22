#!/usr/bin/env python3
"""Run from a checkpoint: python3 tests/check.py build/quectoc-parser"""
from pathlib import Path
import json, subprocess, sys
binary = Path(sys.argv[1]).resolve()
base = Path(__file__).resolve().parent
cases = json.loads((base / 'cases.json').read_text())
failures = []
for case in cases:
    run = subprocess.run([str(binary), str(base / (case['name'] + '.qc'))],
                         text=True, capture_output=True)
    ok = run.returncode == case['exit']
    ok = ok and (('Syntax accepted.' in run.stdout) == (case['exit'] == 0))
    if 'diagnostic' in case:
        ok = ok and case['diagnostic'] in run.stderr
    if not ok:
        failures.append((case['name'], run.returncode, run.stdout, run.stderr))
# Also exercise stdin, EOF completion and missing-file handling.
run = subprocess.run([str(binary)], input='let x=1;', text=True, capture_output=True)
if run.returncode != 0 or run.stdout != 'Syntax accepted.\n':
    failures.append(('stdin', run.returncode, run.stdout, run.stderr))
run = subprocess.run([str(binary), str(base / 'not_present.qc')], text=True, capture_output=True)
if run.returncode != 2 or 'Syntax accepted.' in run.stdout:
    failures.append(('missing_file', run.returncode, run.stdout, run.stderr))
for failure in failures:
    print('FAIL', failure)
print(f'{len(cases) + 2 - len(failures)}/{len(cases) + 2} checks passed')
raise SystemExit(bool(failures))
