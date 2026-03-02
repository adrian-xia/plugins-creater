from __future__ import annotations

from pathlib import Path

from ..utils.fs import ensure_dir, write_text


def generate_shell_script(root: Path, name: str) -> None:
    base = root / "plugins" / "shell" / name
    ensure_dir(base / "src")
    ensure_dir(base / "tests")

    write_text(
        base / "README.md",
        f"# {name}\n\n自动生成的 Shell 插件。\n",
    )
    write_text(
        base / "src" / "main.sh",
        '#!/usr/bin/env bash\nset -euo pipefail\n\necho "来自 Shell 插件的问候"\n',
    )
    write_text(
        base / "tests" / "smoke.bats",
        '#!/usr/bin/env bats\n\n@test "冒烟测试" {\n  run bash src/main.sh\n  [ "$status" -eq 0 ]\n}\n',
    )
