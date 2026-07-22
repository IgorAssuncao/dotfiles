#!/usr/bin/env bash

curl https://sh.rustup.rs -sSf | sh -s -- -y


# Install tools
# TODO: Create script for reloading bash session and install tools.
# tools=(bat eza ripgrep)
cargo search ripgrep
cargo search eza
cargo search bat
