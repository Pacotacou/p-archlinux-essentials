# update
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
./stylepak install-user