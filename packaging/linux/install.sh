#!/usr/bin/env bash
# Build and install hlpp (needs the H# compiler `hsharp` in PATH).  usage: packaging/install.sh [PREFIX]
set -e
P=${1:-/usr/local}
cd "$(dirname "$0")/../hlpp"
hsharp compile src/main.h# -o hlpp --release
install -Dm755 hlpp "$P/bin/hlpp"
install -Dm644 ../packaging/hlpp.desktop "$P/share/applications/hlpp.desktop"
echo "installed: $P/bin/hlpp"
