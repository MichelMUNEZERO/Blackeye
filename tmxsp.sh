#!/bin/bash

# BlackEye Setup Script for Termux/Android
# This script installs dependencies in Termux environment

clear
echo ""
echo -e "\e[1;92m"
echo "  ____  _            _     _____           "
echo " | __ )| | __ _  ___| | __|  ___|   _  ___ "
echo " |  _ \| |/ _\` |/ __| |/ /| |_ | | | |/ _ \\"
echo " | |_) | | (_| | (__|   < |  _|| |_| |  __/"
echo " |____/|_|\__,_|\___|_|\_\|_|   \__, |\___|"
echo "                                |___/      "
echo -e "\e[1;77m"
echo "    Termux Setup Script - Version 2.5"
echo ""
echo -e "\e[0m"

echo -e "\e[1;92m[*] Setting up BlackEye for Termux...\e[0m"
sleep 1

# Update package list
echo -e "\e[1;77m[*] Updating package list...\e[0m"
pkg update -y

# Upgrade packages
echo -e "\e[1;77m[*] Upgrading packages...\e[0m"
pkg upgrade -y

# Install PHP
if ! command -v php &> /dev/null; then
    echo -e "\e[1;77m[*] Installing PHP...\e[0m"
    pkg install php -y
else
    echo -e "\e[1;92m[✓] PHP is already installed\e[0m"
fi

# Install curl
if ! command -v curl &> /dev/null; then
    echo -e "\e[1;77m[*] Installing curl...\e[0m"
    pkg install curl -y
else
    echo -e "\e[1;92m[✓] curl is already installed\e[0m"
fi

# Install wget
if ! command -v wget &> /dev/null; then
    echo -e "\e[1;77m[*] Installing wget...\e[0m"
    pkg install wget -y
else
    echo -e "\e[1;92m[✓] wget is already installed\e[0m"
fi

# Install unzip
if ! command -v unzip &> /dev/null; then
    echo -e "\e[1;77m[*] Installing unzip...\e[0m"
    pkg install unzip -y
else
    echo -e "\e[1;92m[✓] unzip is already installed\e[0m"
fi

# Install proot (for some operations that need root-like permissions)
if ! command -v proot &> /dev/null; then
    echo -e "\e[1;77m[*] Installing proot...\e[0m"
    pkg install proot -y
else
    echo -e "\e[1;92m[✓] proot is already installed\e[0m"
fi

# Install nodejs and npm
if ! command -v node &> /dev/null; then
    echo -e "\e[1;77m[*] Installing nodejs...\e[0m"
    pkg install nodejs -y
else
    echo -e "\e[1;92m[✓] nodejs is already installed\e[0m"
fi

# Install localtunnel
if ! command -v lt &> /dev/null; then
    echo -e "\e[1;77m[*] Installing localtunnel...\e[0m"
    npm install -g localtunnel
else
    echo -e "\e[1;92m[✓] localtunnel is already installed\e[0m"
fi

# Install cloudflared (alternative to ngrok)
if ! command -v cloudflared &> /dev/null; then
    echo -e "\e[1;77m[*] Installing cloudflared...\e[0m"
    
    # Detect architecture
    ARCH=$(uname -m)
    if [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        CF_ARCH="arm64"
    elif [[ "$ARCH" == "armv7l" ]] || [[ "$ARCH" == "armv8l" ]]; then
        CF_ARCH="arm"
    else
        echo -e "\e[1;93m[!] Unsupported architecture for cloudflared: $ARCH\e[0m"
        echo -e "\e[1;93m[!] You'll need to use localtunnel instead\e[0m"
        CF_ARCH=""
    fi
    
    if [[ ! -z "$CF_ARCH" ]]; then
        wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CF_ARCH} -O $PREFIX/bin/cloudflared
        chmod +x $PREFIX/bin/cloudflared
        echo -e "\e[1;92m[✓] cloudflared installed successfully\e[0m"
    fi
else
    echo -e "\e[1;92m[✓] cloudflared is already installed\e[0m"
fi

# Install openssh (for SSH tunneling option)
if ! command -v ssh &> /dev/null; then
    echo -e "\e[1;77m[*] Installing openssh...\e[0m"
    pkg install openssh -y
else
    echo -e "\e[1;92m[✓] openssh is already installed\e[0m"
fi

# Set storage permissions
echo -e "\e[1;77m[*] Setting up storage permissions...\e[0m"
termux-setup-storage

# Set permissions
echo -e "\e[1;77m[*] Setting script permissions...\e[0m"
chmod +x blackeye.sh
chmod +x tmxsp.sh

echo ""
echo -e "\e[1;92m[✓] Setup completed successfully!\e[0m"
echo ""
echo -e "\e[1;77m[*] Usage: ./blackeye.sh\e[0m"
echo ""
echo -e "\e[1;93m[!] Note: Termux uses cloudflared or localtunnel for port forwarding\e[0m"
echo -e "\e[1;93m    as ngrok requires special setup on Android.\e[0m"
echo ""
echo -e "\e[1;93m[!] Make sure to allow storage permissions when prompted!\e[0m"
echo ""
