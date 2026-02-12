#!/bin/bash

# BlackEye Setup Script for Linux
# This script installs dependencies and sets up the environment

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
echo "         Setup Script - Version 2.5"
echo ""
echo -e "\e[0m"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;91m[!] This script must be run as root (use sudo)\e[0m" 
   exit 1
fi

echo -e "\e[1;92m[*] Installing dependencies...\e[0m"
sleep 1

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    UPDATE_CMD="apt-get update"
    INSTALL_CMD="apt-get install -y"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    UPDATE_CMD="yum check-update"
    INSTALL_CMD="yum install -y"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    UPDATE_CMD="dnf check-update"
    INSTALL_CMD="dnf install -y"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    UPDATE_CMD="pacman -Sy"
    INSTALL_CMD="pacman -S --noconfirm"
else
    echo -e "\e[1;91m[!] Unsupported package manager. Please install dependencies manually.\e[0m"
    exit 1
fi

# Update package list
echo -e "\e[1;77m[*] Updating package list...\e[0m"
$UPDATE_CMD

# Install PHP
if ! command -v php &> /dev/null; then
    echo -e "\e[1;77m[*] Installing PHP...\e[0m"
    $INSTALL_CMD php
else
    echo -e "\e[1;92m[✓] PHP is already installed\e[0m"
fi

# Install curl
if ! command -v curl &> /dev/null; then
    echo -e "\e[1;77m[*] Installing curl...\e[0m"
    $INSTALL_CMD curl
else
    echo -e "\e[1;92m[✓] curl is already installed\e[0m"
fi

# Install wget
if ! command -v wget &> /dev/null; then
    echo -e "\e[1;77m[*] Installing wget...\e[0m"
    $INSTALL_CMD wget
else
    echo -e "\e[1;92m[✓] wget is already installed\e[0m"
fi

# Install unzip
if ! command -v unzip &> /dev/null; then
    echo -e "\e[1;77m[*] Installing unzip...\e[0m"
    $INSTALL_CMD unzip
else
    echo -e "\e[1;92m[✓] unzip is already installed\e[0m"
fi

# Install ngrok
if ! command -v ngrok &> /dev/null; then
    echo -e "\e[1;77m[*] Installing ngrok...\e[0m"
    
    # Detect architecture
    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        NGROK_ARCH="amd64"
    elif [[ "$ARCH" == "i686" ]] || [[ "$ARCH" == "i386" ]]; then
        NGROK_ARCH="386"
    elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        NGROK_ARCH="arm64"
    elif [[ "$ARCH" == "armv7l" ]]; then
        NGROK_ARCH="arm"
    else
        echo -e "\e[1;91m[!] Unsupported architecture: $ARCH\e[0m"
        exit 1
    fi
    
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-${NGROK_ARCH}.tgz -O /tmp/ngrok.tgz
    tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin
    chmod +x /usr/local/bin/ngrok
    rm /tmp/ngrok.tgz
    echo -e "\e[1;92m[✓] ngrok installed successfully\e[0m"
else
    echo -e "\e[1;92m[✓] ngrok is already installed\e[0m"
fi

# Install npm (for localtunnel)
if ! command -v npm &> /dev/null; then
    echo -e "\e[1;77m[*] Installing npm...\e[0m"
    if [[ "$PKG_MANAGER" == "pacman" ]]; then
        $INSTALL_CMD npm
    else
        $INSTALL_CMD npm nodejs
    fi
else
    echo -e "\e[1;92m[✓] npm is already installed\e[0m"
fi

# Install localtunnel
if ! command -v lt &> /dev/null; then
    echo -e "\e[1;77m[*] Installing localtunnel...\e[0m"
    npm install -g localtunnel
else
    echo -e "\e[1;92m[✓] localtunnel is already installed\e[0m"
fi

# Set permissions
echo -e "\e[1;77m[*] Setting permissions...\e[0m"
chmod +x blackeye.sh

echo ""
echo -e "\e[1;92m[✓] Setup completed successfully!\e[0m"
echo ""
echo -e "\e[1;77m[*] Usage: ./blackeye.sh\e[0m"
echo ""
echo -e "\e[1;93m[!] Note: You may need to configure your ngrok authtoken:\e[0m"
echo -e "\e[1;93m    ngrok config add-authtoken YOUR_TOKEN\e[0m"
echo -e "\e[1;93m    Get your token from: https://dashboard.ngrok.com/get-started/your-authtoken\e[0m"
echo ""
