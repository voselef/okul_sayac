:: MANUEL START DOSYASIDIR OTOMATIK ACILMASI ICIN SETAUTO.BAT CALISTIRIN


@echo off
:: Node.js kontrol
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js yüklü degil. Kurulum baslatiliyor...

    :: Chocolatey yoksa yükle
    choco -v >nul 2>&1
    if %errorlevel% neq 0 (
        echo Chocolatey yüklü degil. Yuklemek icin admin olarak calistirin.
        exit /b
    )

    :: Node.js yükle
    choco install nodejs-lts -y
)

:: app.js calistir (arka planda)
start "" node app.js

:: Tarayıcıyı aç
start "" "http://localhost:3000/index.html"
