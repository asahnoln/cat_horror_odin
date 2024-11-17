.DEFAULT_GOAL := build

.PHONY: build
build:
	odin build cmd -collection:src=src

.PHONY: test
test:
	odin test tests/ -all-packages -collection:src=src
