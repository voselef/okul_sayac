#!/bin/bash
# OkulSayac_remove.sh
# OkulSayac uygulamasını başlangıçtan kaldırır

APP_NAME="OkulSayac"
AUTOSTART_FILE="$HOME/.config/autostart/$APP_NAME.desktop"

if [ -f "$AUTOSTART_FILE" ]; then
    rm "$AUTOSTART_FILE"
    echo "[+] $APP_NAME autostart kaydi silindi."
else
    echo "[!] $APP_NAME autostart kaydi bulunamadi."
fi

exit 0
