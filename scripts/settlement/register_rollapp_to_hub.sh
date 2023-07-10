#!/bin/bash

ROLLAPP_CHAIN_ID="demo-dymension-rollapp"
KEYRING_PATH="$HOME/.rollapp/sequencer_keys"
KEY_NAME_SEQUENCER="sequencer"

MAX_SEQUENCERS=5

#Register rollapp 
dymd tx rollapp create-rollapp "$ROLLAPP_CHAIN_ID" stamp1 "genesis-path/1" 3 "$MAX_SEQUENCERS" '{"Addresses":[]}' \
  --from "$KEY_NAME_SEQUENCER" \
  --keyring-backend test \
  --keyring-dir "$KEYRING_PATH" \
  --broadcast-mode block
