.PHONY: bootstrap doctor test generate install-tools list-tools

bootstrap:
	./scripts/bootstrap.sh

doctor:
	./scripts/doctor.sh

test:
	python -m pytest

generate:
	@if [ -z "$(type)" ] || [ -z "$(name)" ]; then \
		echo "用法: make generate type=<shell-script|agent-tool|llm-skill> name=<name>"; \
		exit 1; \
	fi
	./scripts/generate.sh $(type) $(name)

list-tools:
	./scripts/install-tools.sh --list

install-tools:
	@if [ -z "$(tool)" ]; then \
		./scripts/install-tools.sh --install-all; \
	else \
		./scripts/install-tools.sh --install $(tool); \
	fi
