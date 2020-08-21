#!/usr/bin/env sh

mkdir -v -p ~/.local/share/godot/templates
ln -s /usr/local/share/godot/templates/"${GODOT_VERSION}.stable" ~/.local/share/godot/templates/"${GODOT_VERSION}.stable"
godot --export "$INPUT_PLATFORM" "$INPUT_PATH"
