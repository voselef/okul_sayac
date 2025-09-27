#!/bin/bash
# OkulSayac.sh
# Linux için Node + Kiosk başlatma scripti

APP_NAME="OkulSayac"
APP_URL="http://localhost:3000/index.html"
APP_DIR="$(cd "$(dirname "$0")" && pwd)"

# Node.js kontrolü
if ! command -v node &> /dev/null
then
    echo "[!] Node.js bulunamadi. Yukleniyor..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    if ! command -v node &> /dev/null; then
        echo "[!] Node yuklemesi basarisiz."
        exit 1
    fi
    echo "[+] Node yuklendi."
fi

# Uygulama dizinine geç
cd "$APP_DIR" || exit 1

# Node.js uygulamasını arka planda başlat
echo "[+] Node uygulamasi baslatiliyor..."
nohup node app.js > /dev/null 2>&1 &

# Tarayıcı tespiti
BROWSER=""
if command -v google-chrome &> /dev/null; then
    BROWSER="google-chrome"
elif command -v chromium-browser &> /dev/null; then
    BROWSER="chromium-browser"
elif command -v microsoft-edge &> /dev/null; then
    BROWSER="microsoft-edge"
else
    echo "[!] Chrome veya Edge bulunamadi."
    exit 1
fi

# Tarayıcıyı kiosk modunda aç
echo "[+] Tarayici aciliyor..."
$BROWSER --kiosk "$APP_URL" --no-first-run --disable-infobars &

# Başlangıçta otomatik çalıştırma
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
AUTOSTART_FILE="$AUTOSTART_DIR/$APP_NAME.desktop"

cat > "$AUTOSTART_FILE" <<EOL
[Desktop Entry]
Type=Application
Exec=$APP_DIR/OkulSayac.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=$APP_NAME
Comment=Start Node Kiosk App at login
EOL

echo "[+] Script baslangica eklendi: $AUTOSTART_FILE"
echo "[+] Tamamlandi."
exit 0
