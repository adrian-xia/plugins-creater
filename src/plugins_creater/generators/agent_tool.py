from __future__ import annotations

from pathlib import Path

from ..utils.fs import ensure_dir, write_text


def generate_agent_tool(root: Path, name: str) -> None:
    base = root / "plugins" / "agents" / name
    ensure_dir(base / "src")
    ensure_dir(base / "prompts")
    ensure_dir(base / "tests")

    write_text(
        base / "README.md",
        f"# {name}\n\n自动生成的 Agent 工具插件。\n",
    )
    write_text(
        base / "prompts" / "system.md",
        "你是一个实用且可靠的 Agent 工具。\n",
    )
    write_text(
        base / "src" / "tool.py",
        "def run(input_text: str) -> str:\n  return input_text\n",
    )
    write_text(
        base / "tests" / "test_tool.py",
        "from pathlib import Path\n\n\ndef test_placeholder() -> None:\n  assert Path('.').exists()\n",
    )
