TOP_DIR=.
README=$(TOP_DIR)/README.md

VERSION=$(strip $(shell cat version))

build:
	@echo "Building the software..."
	@mix compile

init: install dep
	@echo "Initializing the repo..."
	@git submodule update --init --recursive

travis-init:
	@echo "Initialize software required for travis (normally ubuntu software)"

install:
	@echo "Install software required for this repo..."
	@mix local.hex --force
	@mix local.rebar --force

dep:
	@echo "Install dependencies required for this repo..."
	@mix deps.get

pre-build: install dep
	@echo "Running scripts before the build..."

post-build:
	@echo "Running scripts after the build is done..."

all: pre-build build post-build

test:
	@echo "Running test suites..."

lint:
	@echo "Linting the software..."

doc:
	@echo "Building the documenation..."

precommit: dep build
	@mix format
	@mix credo
	@mix docs
	@mix test

travis: precommit

travis-deploy: release
	@echo "Deploy the software by travis"

clean:
	@echo "Cleaning the build..."
	@rm -rf _build

run:
	@echo "Running the software..."
	@iex -S mix

include .makefiles/*.mk

.PHONY: build init travis-init install dep pre-build post-build all test doc precommit travis clean watch run bump-version create-pr
