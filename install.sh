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
THEME_DEPS="gtk-engine-murrine sassc"
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
print_status "Installing theme dependencies"
sudo pacman -S --needed --noconfirm $THEME_DEPS
check_success "Theme dependencies installation"

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
check_success "CUPS service enabled# update
sudo pacman -Syu

# enable yay
mkdir ~/Themes
cd ~/Themes
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# main settings
sudo pacman -S system-config-printer sane-airscan gutenprint cups \
gnome-browser-connector gufw power-profiles-daemon ntfs-3g \
noto-fonts-cjk adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts

systemctl enable bluetooth
systemctl enable cups
systemctl enable ufw

# themes
cd ~/Themes
sudo pacman -S --needed gtk-engine-murrine sassc

## colloid theme
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
./install.sh -l --tweaks rimless
sudo ./install --tweaks rimless
cd ..

## colloid icons
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
./install 
cd ..

## cursor
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd WhiteSur-cursors
./install 
cd ..

## set themes
gsettings set org.gnome.desktop.interface gtk-theme "Colloid-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Colloid-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "WhiteSur-cursors"
gsettings set org.gnome.shell.extensions.user-theme name "Colloid-Dark"

## flatpak themes
git clone https://github.com/refi64/stylepak.git
cd stylepak
sudo pacman -S --needed ostree appstream-glib
./stylepak install-system
./stylepak install-user"

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
# Theme Installation   #
########################

print_status "Installing themes"
# Create themes directory if it doesn't exist
mkdir -p ~/Themes
cd ~/Themes

# Install Colloid GTK theme
print_status "Installing Colloid GTK theme"
if [ -d "Colloid-gtk-theme" ]; then
    cd Colloid-gtk-theme
    git pull
    check_success "Colloid GTK theme updated"
else
    git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
    check_success "Colloid GTK theme repository cloned"
    cd Colloid-gtk-theme
fi

./install.sh -l --tweaks rimless
check_success "Colloid GTK theme installed for user"

sudo ./install.sh --tweaks rimless
check_success "Colloid GTK theme installed system-wide"

cd ..

# Install Colloid icon theme
print_status "Installing Colloid icon theme"
if [ -d "Colloid-icon-theme" ]; then
    cd Colloid-icon-theme
    git pull
    check_success "Colloid icon theme updated"
else
    git clone https://github.com/vinceliuice/Colloid-icon-theme.git
    check_success "Colloid icon theme repository cloned"
    cd Colloid-icon-theme
fi

./install.sh
check_success "Colloid icon theme installed"

cd ..

# Install WhiteSur cursors
print_status "Installing WhiteSur cursors"
if [ -d "WhiteSur-cursors" ]; then
    cd WhiteSur-cursors
    git pull
    check_success "WhiteSur cursors updated"
else
    git clone https://github.com/vinceliuice/WhiteSur-cursors.git
    check_success "WhiteSur cursors repository cloned"
    cd WhiteSur-cursors
fi

./install.sh
check_success "WhiteSur cursors installed"

cd ..

########################
# Apply Themes         #
########################

print_status "Applying themes"
gsettings set org.gnome.desktop.interface gtk-theme "Colloid-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Colloid"
gsettings set org.gnome.desktop.interface cursor-theme "WhiteSur-cursors"
gsettings set org.gnome.shell.extensions.user-theme name "Colloid-Dark"
check_success "Themes applied to GNOME"

########################
# Flatpak Theme Support #
########################

print_status "Setting up Flatpak theme integration"
if [ -d "stylepak" ]; then
    cd stylepak
    git pull
    check_success "Stylepak updated"
else
    git clone https://github.com/refi64/stylepak.git
    check_success "Stylepak repository cloned"
    cd stylepak
fi

sudo pacman -S --needed --noconfirm ostree appstream-glib
check_success "Stylepak dependencies installed"

./stylepak install-system
check_success "Stylepak system integration"

./stylepak install-user
check_success "Stylepak user integration"

cd ..

########################
# Additional Software  #
########################

print_status "Installing additional recommended software"

# Common applications - uncomment what you need
BROWSERS="firefox"  # Add chromium, vivaldi-stable if needed
TERMINALS="alacritty kitty"  # Choose your preferred terminal
FILE_MANAGERS="thunar"  # Or nautilus, nemo, etc.
EDITORS="code vim"  # Visual Studio Code and vim
UTILITIES="flameshot timeshift btop"  # Screenshot, backup, system monitor

# Uncomment to install additional software
# sudo pacman -S --needed --noconfirm $BROWSERS $TERMINALS $FILE_MANAGERS $EDITORS $UTILITIES
# check_success "Additional software installation"

# You can add more categories or specific software as needed
# MEDIA="vlc mpv"
# OFFICE="libreoffice-fresh"
# GAMING="steam lutris"

print_status "Setup complete!"
echo "Please reboot your system to ensure all changes take effect."