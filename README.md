<h1 align="center">Dymension Rollapp</h1>

# Rollappd - A template RollApp chain

This repository hosts `rollappd`, a template implementation of a dymension rollapp.

`rollappd` is an example of a working RollApp using `dymension-RDK` and `dymint`.

It uses Cosmos-SDK's [simapp](https://github.com/cosmos/cosmos-sdk/tree/main/simapp) as a reference, but with the following changes:
- minimal app setup
- wired IBC for [ICS 20 Fungible Token Transfers](https://github.com/cosmos/ibc/tree/main/spec/app/ics-020-fungible-token-transfer)
- Uses `dymint` for block sequencing and replacing `tendermint`
- Uses modules from `dymension-RDK` to sync with `dymint` and provide RollApp custom logic 


## Overview

**Note**: Requires [Go 1.19](https://go.dev/)

## Quick guide

Get started with [building RollApps](https://docs.dymension.xyz/develop/get-started/setup)

## Installing / Getting started

Build and install the ```rollappd``` binary:

```shell
make install
```

### Initial configuration

This will initialize the rollapp:

```shell
sh scripts/init.sh
```

### Run rollapp

```shell
rollappd start
```

You should have a running local rollapp!

## Run a rollapp with local settlement node

### Run local dymension hub node

Follow the instructions on [Dymension Hub docs](https://docs.dymension.xyz/develop/get-started/run-base-layers) to run local dymension hub node

### Create sequencer keys

create sequencer key using `dymd`

```shell
dymd keys add sequencer --keyring-dir ~/.rollapp/sequencer_keys --keyring-backend test
SEQUENCER_ADDR=`dymd keys show sequencer --address --keyring-backend test --keyring-dir ~/.rollapp/sequencer_keys`
```

fund the sequencer account

```shell
dymd tx bank send local-user $SEQUENCER_ADDR 10000000000udym --keyring-backend test
```

### Register rollapp on settlement

```shell
sh scripts/settlement/register_rollapp_to_hub.sh
```

### Register sequencer for rollapp on settlement

```shell
sh scripts/settlement/register_sequencer_to_hub.sh
```

### Configure the rollapp

Modify `dymint.toml` in the chain directory (`~/.rollapp/config`)
set:

```shell
settlement_layer = "dymension"
```

### Run rollapp

```shell
rollappd start
```

## Developers guide

TODO
