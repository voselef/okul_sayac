@echo off
:: Başlangıçtan OkulSayac scriptini kaldır
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v OkulSayac /f >nul 2>&1

if %errorlevel%==0 (
    echo [+] Baslangictan kaldirildi.
) else (
    echo [!] Baslangicta OkulSayac bulunamadi.
)

pause
exit /b
