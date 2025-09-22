#MANUEL START DOSYASIDIR OTOMATIK ACILMASI ICIN SETAUTO.BASH CALISTIRIN

#!/bin/bash

# Node.js kontrol
if ! command -v node &> /dev/null
then
    echo "Node.js yüklü değil. Kurulum başlatılıyor..."
    
    # Paket yöneticisine göre kurulum
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y nodejs npm
    elif command -v yum &> /dev/null; then
        sudo yum install -y nodejs npm
    else
        echo "Lütfen manuel Node.js yükleyin: https://nodejs.org"
        exit 1
    fi
fi

# app.js çalıştır (arka planda)
node app.js &

# PID kaydet
echo $! > .node_pid

# Tarayıcıyı aç
if command -v xdg-open &> /dev/null; then
    xdg-open "http://localhost:3000/index.html"
elif command -v gnome-open &> /dev/null; then
    gnome-open "http://localhost:3000/index.html"
else
    echo "Tarayıcı açılamadı. Manuel açın: http://localhost:3000/index.html"
fi
