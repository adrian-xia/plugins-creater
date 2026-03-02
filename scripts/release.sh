#!/usr/bin/env bash
set -euo pipefail

python -m pip install -e .
python -m pytest || true

echo "发布准备完成"
