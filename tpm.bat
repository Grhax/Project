@echo off
setlocal

:: Yönetici izni kontrolü ve komut dosyasının yönetici olarak çalıştırılması
openfiles >nul 2>&1 || (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

rem CMD ile tpm_cmd.bat dosyasını çalıştır

C:\Windows\System32\cmd.exe /c C:\Windows\Temp\tpm_cmd.bat



rem Servisi başlat
C:\Windows\System32\cmd.exe /c sc start prex >nul 2>&1

exit
