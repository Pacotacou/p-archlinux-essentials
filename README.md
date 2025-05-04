# Arch Linux Setup Script

A comprehensive setup script for customizing and enhancing a fresh Arch Linux installation with essential packages, services, themes, and configurations.

## Overview

This project provides an automated setup script for Arch Linux that handles the following:

- System updates and package installation
- AUR helper setup (yay)
- Essential service enablement
- Beautiful theming with Colloid GTK theme, icons, and WhiteSur cursors
- Flatpak theme integration
- Japanese font support
- Printer and scanner configuration
- Bluetooth and firewall setup

## Requirements

- A working Arch Linux installation with sudo access
- GNOME desktop environment (for theme settings)
- Internet connection

## Installation

1. Clone this repository:
```bash
git clone https://github.com/Pacotacou/p-archlinux-essentials.git
cd p-archlinux-essentials
```

2. Make the script executable:
```bash
chmod +x setup.sh
```

3. Run the script:
```bash
./setup.sh
```

## Features

### Package Categories

The script installs packages organized by category:

- **System Utilities**: ntfs-3g, gufw, power-profiles-daemon
- **Printer Utilities**: system-config-printer, cups, gutenprint, sane-airscan
- **Fonts**: noto-fonts-cjk, adobe-source-han-sans-jp-fonts, adobe-source-han-serif-jp-fonts
- **Theme Dependencies**: gtk-engine-murrine, sassc
- **Browser Utilities**: gnome-browser-connector
- **Development Tools**: base-devel, git

### Theming

The script sets up a cohesive dark theme using:

- **Colloid Dark GTK Theme**: A modern, flat GTK theme with a dark color scheme
- **Colloid Icon Theme**: Matching icons for the Colloid theme
- **WhiteSur Cursors**: macOS-inspired cursor theme for a clean look

The themes are automatically applied to GNOME using gsettings and also configured for Flatpak applications using Stylepak.

### Service Configuration

The following services are enabled:

- **Bluetooth**: For wireless device connectivity
- **CUPS**: For printer management
- **UFW**: Uncomplicated Firewall for security

### Additional Software

The script includes a section for installing additional common software (commented by default):

- Web browsers
- Terminal emulators
- File managers
- Text editors and IDEs
- Utility applications

## Customization

### Adding More Packages

You can easily customize the script by modifying the package variables at the top:

```bash
BROWSERS="firefox chromium"
TERMINALS="alacritty kitty"
FILE_MANAGERS="thunar dolphin"
```

Uncomment the installation line to install these packages:

```bash
sudo pacman -S --needed --noconfirm $BROWSERS $TERMINALS $FILE_MANAGERS
```

### Changing Themes

If you prefer different themes, you can modify the repository URLs and installation commands in the theme installation section.

## Troubleshooting

### Common Issues

- **Package Installation Failures**: Check your internet connection and ensure Arch repositories are accessible
- **Theme Installation Issues**: Make sure you have all the theme dependencies installed
- **Permission Errors**: Ensure you have proper sudo permissions

If you encounter any issues, check the error messages printed by the script for guidance.

## Credits and Acknowledgments

This project uses several amazing open-source tools and themes. Full credit goes to their original creators:

### Theme Projects
- **Colloid GTK Theme**: [github.com/vinceliuice/Colloid-gtk-theme](https://github.com/vinceliuice/Colloid-gtk-theme)
  - A modern, flat GTK theme with multiple color variants
  - Created by: [Vinceliuice](https://github.com/vinceliuice)
  - License: GPL-3.0

- **Colloid Icon Theme**: [github.com/vinceliuice/Colloid-icon-theme](https://github.com/vinceliuice/Colloid-icon-theme)
  - A colorful icon theme designed to match the Colloid GTK theme
  - Created by: [Vinceliuice](https://github.com/vinceliuice)
  - License: GPL-3.0

- **WhiteSur Cursors**: [github.com/vinceliuice/WhiteSur-cursors](https://github.com/vinceliuice/WhiteSur-cursors)
  - A macOS-inspired cursor theme for Linux desktops
  - Created by: [Vinceliuice](https://github.com/vinceliuice)
  - License: GPL-3.0

### Utilities
- **Stylepak**: [github.com/refi64/stylepak](https://github.com/refi64/stylepak)
  - A utility for applying GTK themes to Flatpak applications
  - Created by: [Refi64](https://github.com/refi64)
  - License: MIT

- **Yay AUR Helper**: [github.com/Jguer/yay](https://github.com/Jguer/yay)
  - A pacman wrapper and AUR helper written in Go
  - Created by: [Jguer](https://github.com/Jguer) and contributors
  - License: GPL-3.0

A special thanks to all the developers and contributors who maintain these projects and make the Linux desktop experience better for everyone.