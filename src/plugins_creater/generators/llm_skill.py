from __future__ import annotations

from pathlib import Path

from ..utils.fs import ensure_dir, write_text


def generate_llm_skill(root: Path, name: str) -> None:
    base = root / "plugins" / "skills" / name
    ensure_dir(base / "prompts")
    ensure_dir(base / "examples")

    write_text(
        base / "README.md",
        f"# {name}\n\n自动生成的 LLM Skill 插件。\n",
    )
    write_text(
        base / "prompts" / "skill.md",
        "# Skill 提示词\n\n在这里描述 Skill 行为。\n",
    )
    write_text(
        base / "examples" / "quickstart.md",
        "# 快速开始\n\n在这里补充使用示例。\n",
    )
