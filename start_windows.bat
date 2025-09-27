@echo off
setlocal

:: Script dizinine geç
cd /d "%~dp0"

:: Eğer "remove" argümanı verilmişse başlangıçtan kaldir
if /i "%1"=="remove" (
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OkulSayac /f >nul 2>&1
    echo [+] Baslangictan kaldirildi.
    exit /b
)

:: Eğer "install" argümanı varsa kuruluma git
if /i "%1"=="install" goto :install_node

:: Node var mi?
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Node.js bulunamadi. Kurulum icin yetki gerekiyor - yuklencek...
    :: Yalnizca kurulum icin yukseklestirme istiyoruz
    powershell -Command "Start-Process -FilePath '%~f0' -ArgumentList 'install' -Verb runAs"
    echo [*] Kurulum elevasyon penceresi acildi. Lutfen izin verin.
    exit /b
)

:: Node var - uygulamayi baslat
goto :start_app

:install_node
echo [*] Node.js indiriliyor ve kuruluyor...
set "NODE_URL=https://nodejs.org/dist/v20.18.0/node-v20.18.0-x64.msi"
set "NODE_INSTALLER=%temp%\node_installer.msi"

:: Indir
powershell -Command "Try { Invoke-WebRequest '%NODE_URL%' -OutFile '%NODE_INSTALLER%' -UseBasicParsing } Catch { Exit 1 }"
if %errorlevel% neq 0 (
    echo [!] Node indirilemedi.
    exit /b
)

:: Kur
msiexec /i "%NODE_INSTALLER%" /qn
if %errorlevel% neq 0 (
    echo [!] Node yuklemesi basarisiz.
    del "%NODE_INSTALLER%" >nul 2>&1
    exit /b
)

:: Geçici olarak PATH'e node dizinini ekle
if exist "%ProgramFiles%\nodejs\node.exe" (
    set "PATH=%ProgramFiles%\nodejs;%PATH%"
) else if exist "%ProgramFiles(x86)%\nodejs\node.exe" (
    set "PATH=%ProgramFiles(x86)%\nodejs;%PATH%"
) else (
    echo [!] Node kuruldu ama beklenen yerde bulunamadi. Lutfen kontrol et.
)

del "%NODE_INSTALLER%" >nul 2>&1
goto :start_app

:start_app
echo [+] Uygulama dizinine gidiliyor...
cd /d "%~dp0"

echo [+] Node uygulamasi baslatiliyor...
start "" node app.js

:: Tarayici bulma
set "CHROME_PATH="
set "EDGE_PATH="

if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "CHROME_PATH=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "CHROME_PATH=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "CHROME_PATH=%LocalAppData%\Google\Chrome\Application\chrome.exe"

if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "EDGE_PATH=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "EDGE_PATH=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if exist "%LocalAppData%\Microsoft\Edge\Application\msedge.exe" set "EDGE_PATH=%LocalAppData%\Microsoft\Edge\Application\msedge.exe"

echo [+] Kiosk modunda tarayici aciliyor...
if defined CHROME_PATH (
    start "" "%CHROME_PATH%" --kiosk "http://localhost:3000/index.html" --no-first-run --disable-infobars
    powershell -command "Start-Sleep -s 2; (new-object -com shell.application).windows() | ? { $_.FullName -like '*chrome.exe' } | %{ $_.document.Focus() }"
) else if defined EDGE_PATH (
    start "" "%EDGE_PATH%" --kiosk "http://localhost:3000/index.html" --no-first-run --disable-infobars
    powershell -command "Start-Sleep -s 2; (new-object -com shell.application).windows() | ? { $_.FullName -like '*msedge.exe' } | %{ $_.document.Focus() }"
) else (
    echo [!] Ne Chrome ne de Edge bulunamadi. Lutfen yukleyin.
)

:: Baslangica ekle (HKCU Run) - admin gerekmez
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OkulSayac /t REG_SZ /d "\"%~f0\"" /f >nul 2>&1

echo [+] Tamamlandi.
endlocal
exit /b
