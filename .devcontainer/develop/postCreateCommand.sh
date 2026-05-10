#!/bin/bash
set -e
echo "[postCreateCommand] Start"

echo "[postCreateCommand] Checking ~/.copilot/skills..."
if [ -d ~/.copilot/skills ]; then
	echo "[postCreateCommand] ~/.copilot/skills already exists."
else
	echo "[postCreateCommand] Cloning skills repository..."
	git clone https://github.com/tsubakimoto/skills ~/.copilot/skills
fi

echo "[postCreateCommand] Installing Node.js LTS via nvm..."
. ${NVM_DIR}/nvm.sh
nvm install --lts

echo "[postCreateCommand] Done."
