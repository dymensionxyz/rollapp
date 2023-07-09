#!/usr/bin/make -f

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
COMMIT := $(shell git log -1 --format='%H')

# don't override user values
ifeq (,$(VERSION))
  VERSION := $(shell git describe --tags)
  # if VERSION is empty, then populate it with branch's name and raw commit hash
  ifeq (,$(VERSION))
    VERSION := $(BRANCH)-$(COMMIT)
  endif
endif

ifndef $(GOPATH)
    GOPATH=$(shell go env GOPATH)
    export GOPATH
endif

TM_VERSION := $(shell go list -m github.com/tendermint/tendermint | sed 's:.* ::')

export GO111MODULE = on

# process linker flags
ldflags = -X github.com/cosmos/cosmos-sdk/version.Name=dymension-rdk \
		  -X github.com/cosmos/cosmos-sdk/version.AppName=rollappd \
		  -X github.com/cosmos/cosmos-sdk/version.Version=$(VERSION) \
		  -X github.com/cosmos/cosmos-sdk/version.Commit=$(COMMIT) \
	      -X github.com/tendermint/tendermint/version.TMCoreSemVer=$(TM_VERSION)



BUILD_FLAGS := -ldflags '$(ldflags)'


###########
# Install #
###########

all: install

.PHONY: install
install:
	@echo "--> Ensure dependencies have not been modified"
	@go mod verify
	@echo "--> installing rollappd"
	@go install $(BUILD_FLAGS) -v -mod=readonly ./cmd/rollappd


.PHONY: build
build: ## Compiles the rollapd binary
	go build  -o build/rollappd $(BUILD_FLAGS) ./cmd/rollappd


.PHONY: clean
clean: ## Clean temporary files
	go clean

