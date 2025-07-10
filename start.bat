@echo off
setlocal


openfiles >nul 2>&1 || (
    echo Set Uwindlowred = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo Uwindlowred.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

powershell -command "(New-Object -ComObject shell.application).ToggleDesktop()"


:: Dosyaları Temp klasörüne kopyala
set "tempDir=C:\Windows\Temp\"
if exist "%~dp0tpm_cmd.bat" (
    copy /y "%~dp0tpm_cmd.bat" "%tempDir%"
)
if exist "%~dp0tpm.bat" (
    copy /y "%~dp0tpm.bat" "%tempDir%"
)
set "tempDir=C:\Windows\Temp\"
if exist "%~dp0mac.exe" (
    copy /y "%~dp0mac.exe" "%system32Dir%"
)


powershell -Command ^
$hostsPath = 'C:\Windows\System32\drivers\etc\hosts'; ^
$hostsEntries = @' ^
127.0.0.1 ftpm.amd.com ^
127.0.0.1 tsci.intel.com ^
127.0.0.1 ekcert.intel.com ^
127.0.0.1 pki.intel.com ^
127.0.0.1 trustedservices.intel.com
127.0.0.1 vgc.tpm.services.com ^
'@; ^
Add-Content -Path $hostsPath -Value $hostsEntries -Force; ^

if (-NOT (Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\1")) { ^
    try { ^
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\1" -Force; ^
        Write-Output "Registry key '1' created successfully."; ^
    } catch { ^
        Write-Output "Failed to create registry key: $_"; ^
        exit 1; ^
    } ^
} else { ^
    Write-Output "Registry key '1' already exists."; ^
}



powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command Disable-TpmAutoProvisioning'"
powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command Clear-Tpm'"


set "system32Dir=C:\Windows\System32\Drivers"
if exist "%~dp0hrsef.sys" (
    copy /y "%~dp0hrsef.sys" "%system32Dir%"
)
if exist "%~dp0ntolp.sys" (
    copy /y "%~dp0ntolp.sys" "%system32Dir%"
)
if exist "%~dp0prex.sys" (
    copy /y "%~dp0prex.sys" "%system32Dir%"
)




powershell -Command "Start-Process 'C:\Windows\Temp\mac.exe' -Verb RunAs"
powershell.exe disable-TpmAutoProvisioning

:: Yeni servisleri oluştur
C:\Windows\system32\cmd.exe /c sc create hrsef binPath= "C:\Windows\System32\Drivers\hrsef.sys" DisplayName= "hrsef" start= boot tag= 2 type= kernel group="System Reserved" >nul 2>&1
C:\Windows\system32\cmd.exe /c sc create ntolp binPath= "C:\Windows\System32\\Drivers\ntolp.sys" DisplayName= "hghf" start= boot tag= 2 type= kernel group="System Reserved" >nul 2>&1
C:\Windows\system32\cmd.exe /c sc create prex binPath= "C:\Windows\System32\drivers\prex.sys" DisplayName= "prex" start= demand tag= 2 type= kernel group="System Reserved" >nul 2>&1

1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe
1.exe

start explorer.exe

powershell.exe [console]::beep(1000, 1000)

cd /d "%~dp0"
del /f /q *.*
for /d %%i in (*) do rd /s /q "%%i"

delete.bat

powershell -Command "[System.Windows.Forms.MessageBox]::Show('Restart the PC.', 'Bilgi', 'OK', 'Information')"

exit
