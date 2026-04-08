#!/usr/bin/env bash
set -Eeuo pipefail

echo "🔥 Arch Gaming Setup – April 2026"

# Ikke kjør som root
if [[ $EUID -eq 0 ]]; then
  echo "Kjør scriptet som vanlig bruker, ikke root."
  exit 1
fi

# Sudo session
sudo -v

echo "==> Oppdaterer systemet"
sudo pacman -Syu --noconfirm

echo "==> Installerer basispakker"
sudo pacman -S --noconfirm \
git curl wget nano unzip zip base-devel \
htop fastfetch bash-completion \
networkmanager

sudo systemctl enable NetworkManager

echo "==> Installerer lyd (PipeWire)"
sudo pacman -S --noconfirm \
pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol

echo "==> Installerer KDE Plasma"
sudo pacman -S --noconfirm \
plasma-meta \
sddm \
konsole dolphin ark kate gwenview spectacle \
xorg xorg-xinit wayland

sudo systemctl enable sddm

echo "==> Installerer NVIDIA"
sudo pacman -S --noconfirm \
nvidia nvidia-utils nvidia-settings \
lib32-nvidia-utils \
vulkan-icd-loader lib32-vulkan-icd-loader

echo "==> Installerer fonter"
sudo pacman -S --noconfirm \
noto-fonts noto-fonts-emoji \
ttf-dejavu ttf-liberation

echo "==> Installerer gaming-pakker"
sudo pacman -S --noconfirm \
steam gamemode mangohud

echo "==> Installerer joystick/ratt verktøy"
sudo pacman -S --noconfirm \
evtest jstest-gtk joystick

echo "==> Installerer Flatpak"
sudo pacman -S --noconfirm flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "==> Installerer ProtonUp-Qt"
flatpak install -y flathub net.davidotek.pupgui2

echo "==> Aktiverer SSD trim"
sudo systemctl enable fstrim.timer

echo "==> Setter gaming miljøvariabler"
mkdir -p ~/.config/environment.d

cat > ~/.config/environment.d/90-gaming.conf <<EOF
MANGOHUD=1
EOF

echo ""
echo "✅ INSTALL FERDIG"
echo ""
echo "👉 NESTE STEG:"
echo "1. reboot"
echo "2. logg inn i KDE"
echo "3. start Steam"
echo "4. Settings → Compatibility → Enable Proton"
echo "5. åpne ProtonUp-Qt og installer Proton GE"
echo "6. test joystick med: jstest-gtk"
echo ""
