#!/bin/bash
#########################################################
# Arch Linux Setup Script
# Description: Complete setup script for Arch Linux with themes and essential packages
# Author: Paco
# Date: May 4, 2025
# Usage: ./install.sh
#########################################################

# Error handling
set -e  # Exit on error
trap 'echo "Error occurred at line $LINENO. Command: $BASH_COMMAND"' ERR

# Function to print status messages
print_status() {
    echo -e "\n\033[1;34m==>\033[0m \033[1m$1\033[0m"
}

# Function to check if command succeeded
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32m✓ Success:\033[0m $1"
    else
        echo -e "\033[1;31m✗ Failed:\033[0m $1"
        exit 1
    fi
}

print_status "Updating system packages"
sudo pacman -Syu --noconfirm
check_success "System update"

########################
# Package Installation #
########################

# Define package groups
SYSTEM_UTILS="ntfs-3g dosfstools gufw power-profiles-daemon"
PRINTER_UTILS="system-config-printer cups gutenprint sane-airscan"
FONTS="noto-fonts-cjk adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts"
# THEME_DEPS="gtk-engine-murrine sassc"
BROWSER_UTILS="gnome-browser-connector"
DEV_TOOLS="base-devel git"

print_status "Installing packages by category"

# System utilities
print_status "Installing system utilities"
sudo pacman -S --needed --noconfirm $SYSTEM_UTILS
check_success "System utilities installation"

# Printer utilities
print_status "Installing printer utilities"
sudo pacman -S --needed --noconfirm $PRINTER_UTILS
check_success "Printer utilities installation"

# Fonts
print_status "Installing fonts"
sudo pacman -S --needed --noconfirm $FONTS
check_success "Fonts installation"

# Theme dependencies
# print_status "Installing theme dependencies"
# sudo pacman -S --needed --noconfirm $THEME_DEPS
# check_success "Theme dependencies installation"

# Browser utilities
print_status "Installing browser utilities"
sudo pacman -S --needed --noconfirm $BROWSER_UTILS
check_success "Browser utilities installation"

# Development tools
print_status "Installing development tools"
sudo pacman -S --needed --noconfirm $DEV_TOOLS
check_success "Development tools installation"

########################
# Service Enablement   #
########################

print_status "Enabling essential services"
systemctl enable bluetooth
check_success "Bluetooth service enabled"

systemctl enable cups
check_success "CUPS service enabled"

systemctl enable ufw
check_success "UFW firewall service enabled"

########################
# AUR Helper Setup     #
########################

print_status "Setting up YAY AUR helper"
if command -v yay &>/dev/null; then
    echo "YAY is already installed"
else
    # Create themes directory if it doesn't exist
    mkdir -p ~/Themes
    cd ~/Themes
    
    git clone https://aur.archlinux.org/yay.git
    check_success "YAY repository cloned"
    
    cd yay
    makepkg -si --noconfirm
    check_success "YAY installation"
    
    cd ..
fi

########################
# Completion          #
#######################

print_status "Setup complete!"
echo "Please reboot your system to ensure all changes take effect."
