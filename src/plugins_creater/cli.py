from __future__ import annotations

import argparse
from pathlib import Path

from .generators.agent_tool import generate_agent_tool
from .generators.llm_skill import generate_llm_skill
from .generators.shell_script import generate_shell_script


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="pc", description="plugins-creater 命令行工具"
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    subparsers.add_parser("list-types", help="列出支持的插件类型")

    generate_parser = subparsers.add_parser("generate", help="生成插件脚手架")
    generate_parser.add_argument(
        "--type", required=True, choices=["shell-script", "agent-tool", "llm-skill"]
    )
    generate_parser.add_argument("--name", required=True)
    generate_parser.add_argument("--root", default=".", help="项目根目录路径")

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    if args.command == "list-types":
        print("shell-script")
        print("agent-tool")
        print("llm-skill")
        return 0

    root = Path(args.root).resolve()
    plugin_name = args.name.strip()

    if args.type == "shell-script":
        generate_shell_script(root, plugin_name)
    elif args.type == "agent-tool":
        generate_agent_tool(root, plugin_name)
    else:
        generate_llm_skill(root, plugin_name)

    print(f"已生成 {args.type} 类型插件: {plugin_name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
