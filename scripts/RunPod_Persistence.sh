#!/bin/bash
# RunPod Persistence Bootstrapper
# Executed to link ephemeral /root paths to persistent /runpod-volume storage

BASE_VOL="/runpod-volume/persistence"
EPHEMERAL_HOME="/root"

echo "[*] Starting Persistence Linking..."

# 1. Create Base Hierarchy if missing
mkdir -p "$BASE_VOL/ssh"
mkdir -p "$BASE_VOL/workspace"
mkdir -p "$BASE_VOL/vscode-server"
mkdir -p "$BASE_VOL/windsurf-server"
mkdir -p "$BASE_VOL/config"
mkdir -p "$BASE_VOL/local_share"

# 2. Persist SSH Keys (Critical for Access)
# If the volume has no keys, back up the current ones (injected by RunPod) to the volume
if; then
    echo "[-] No persistent keys found. Backing up initial keys..."
    cp -r $EPHEMERAL_HOME/.ssh/* "$BASE_VOL/ssh/"
    chmod 600 "$BASE_VOL/ssh/id_ed25519" 2>/dev/null
fi
# Remove ephemeral.ssh and link persistent one
rm -rf $EPHEMERAL_HOME/.ssh
ln -s "$BASE_VOL/ssh" "$EPHEMERAL_HOME/.ssh"
chmod 700 "$EPHEMERAL_HOME/.ssh"
echo "[+] SSH configuration linked."

# 3. Persist VS Code / WindSurf Servers
# This saves minutes of download time on every reconnect
rm -rf $EPHEMERAL_HOME/.vscode-server
ln -s "$BASE_VOL/vscode-server" "$EPHEMERAL_HOME/.vscode-server"
rm -rf $EPHEMERAL_HOME/.windsurf-server
ln -s "$BASE_VOL/windsurf-server" "$EPHEMERAL_HOME/.windsurf-server"
echo "[+] IDE Servers linked."

# 4. Persist Shell History (Bash/Zsh)
# Ensures command history survives reboots
touch "$BASE_VOL/bash_history"
rm -f $EPHEMERAL_HOME/.bash_history
ln -s "$BASE_VOL/bash_history" "$EPHEMERAL_HOME/.bash_history"
echo "[+] Shell history linked."

# 5. Persist Workspace
# Maps /workspace to the volume for code storage
if [! -L "/workspace" ]; then
    # If /workspace is a directory, move contents to volume then link
    if [ -d "/workspace" ]; then
        cp -r /workspace/* "$BASE_VOL/workspace/" 2>/dev/null
        rm -rf /workspace
    fi
    ln -s "$BASE_VOL/workspace" "/workspace"
fi
echo "[+] Workspace linked."

echo "[*] Persistence Setup Complete. Environment Ready."
