#!/bin/bash

# Install recfiles package locally
case "$(uname -s)" in
    Darwin*) DIR="$HOME/Library/Application Support/typst/packages/local" ;;
    Linux*) DIR="$HOME/.local/share/typst/packages/local" ;;
    *) DIR="$APPDATA/typst/packages/local" ;;
esac

mkdir -p "$DIR/recfiles/0.1.0"
cp lib.typ typst.toml "$DIR/recfiles/0.1.0/"

echo "Installed! Import with: #import \"@local/recfiles:0.1.0\": recfile"