#!/usr/bin/env bash
sudo dnf install -y git vim
sudo dnf update -y

git config --global user.name "Antoine Barthelemy"
git config --global email.name antoine@linux.com
git config --global credential.helper store

# Firefox Add-ons
wget https://addons.mozilla.org/firefox/downloads/file/3687310/adblocker_ultimate-3.7.10-an+fx.xpi -O /tmp/adblock_ultimate.xpi
firefox /tmp/adblock_ultimate.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3803046/ghostery_privacy_ad_blocker-8.5.7-an+fx.xpi -O /tmp/ghostery.xpi
firefox /tmp/ghostery.xpi

sed -i -e 's|user_pref("network.trr.blocklist_cleanup_done".*|user_pref("network.trr.blocklist_cleanup_done", true);|g' \
	-e 's|user_pref("network.trr.custom_uri".*|user_pref("network.trr.custom_uri", "https://doh.42l.fr/dns-query");|g' \
	-e 's|user_pref("network.trr.mode".*|user_pref("network.trr.mode", 2);|g' \
	-e 's|user_pref("network.trr.uri".*|user_pref("network.trr.uri", "https://doh.42l.fr/dns-query");|g' \
	$(ls  ~/.mozilla/firefox/*.default-release/prefs.js)

# Gnome Theme
wget https://github.com/EliverLara/Sweet/releases/download/2.0/Sweet-Dark.tar.xz
tar xvf Sweet-Dark.tar.xz
sudo mv Sweet-Dark /usr/share/themes/
gsettings set org.gnome.desktop.interface gtk-theme "Sweet-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Sweet-Dark"

git clone https://github.com/EliverLara/candy-icons
rm -rf candy-icons/.git candy-icons/README.md
sudo mv candy-icons /usr/share/icons/
gsettings set org.gnome.desktop.interface icon-theme "Candy-icons"

gsettings set org.gnome.desktop.interface clock-show-weekday 'true'

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | xargs echo)

echo "[legacy]
theme-variant='dark'

[legacy/profiles:/:${PROFILE_ID}]
background-color='rgb(0,0,0)'
foreground-color='rgb(208,207,204)'
use-system-font=false
use-theme-colors=false" | dconf load /org/gnome/terminal/

# Bash
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
sed -i -e "s/OSH_THEME=.*/OSH_THEME=\"purity\"/g" ~/.bashrc

# Vimrc
wget https://raw.githubusercontent.com/Ant0wan/config/master/assets/vimrc -O ~/.vimrc

# Rust
wget https://sh.rustup.rs -O /tmp/rust.sh
bash rust.sh -y
