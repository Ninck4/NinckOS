@echo off
title NinckOS
start "" /wait "C:\Windows\Install\Scripts\FullscreeenCMD.exe"


taskkill /F /IM "explorer.exe" 1>NUL 2>NUL


REM Deaktiviere die Unterbrechung mit Strg + C
break off


reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /t REG_SZ  /v ExecutionPolicy /d "Unrestricted" /f
bcdedit /set "{current}" bootmenupolicy legacy

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSrc /t REG_DWORD /d 3 /f




setlocal

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pow\UserChoice" /v Progid /d "%SystemRoot%\System32\powercfg.exe" /f

endlocal


cls 

REM Begr  ungsnachricht anzeigen

echo.
echo        ===================================
echo        =                                 =
echo        =       Welcome to NinckOS        =
echo        =                                 =
echo        ===================================
echo.
echo    My OS is tuned to deliver maximum gaming performance,
echo              with a focus on Fortnite!
echo.
echo    Need assistance or have questions? Join my Discord community!
echo.


pause



cls




REM Still Installation der Runtimes
echo Installing Visuals...
start "" /wait "C:\Windows\Install\Runtimes\VisualCppRedist_AIO_x86_x64.exe" /ai /gm2
echo Installing DirectX Runtimes...
start "" /wait "C:\Windows\Install\Runtimes\DirectX\DXSETUP.exe" /silent





cls


REM Installation von Open-Shell
echo Installing Open-Shell...
start "" /wait "C:\Windows\Install\OpenShell\OpenShellSetup_4_4_191.exe" /qn ADDLOCAL=StartMenu

REM Ausf hren der Registrierungsdatei f r OpenShell-Einstellungen
REM echo Applying OpenShell settings...
regedit /s "C:\Windows\Install\OpenShell\OpenShellSettings.reg"


set "ZIEL_DATEI=C:\Program Files\Open-Shell\startmenu.exe"
set "VERKNUEPFUNG_ZIEL=C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startmenu.lnk"

mklink "%VERKNUEPFUNG_ZIEL%" "%ZIEL_DATEI%"



cls

REM Still Installation von 7-Zip
echo Installing 7-Zip...
start "" /wait msiexec /i "C:\Windows\Install\Programs\7zip\7z2401-x64.msi" /quiet

REM Ausf hren der Registrierungsdatei f r 7-Zip-Einstellungen
echo Applying 7-Zip settings...
regedit /s "C:\Windows\Install\Programs\7zip\7ZIP.reg"



cls



REM Installation des VLC Media Players mit bestimmten Optionen
echo Installing VLC Media Player...
start "" /wait msiexec /i "C:\Windows\Install\Programs\VLC\vlc-3.0.20-win64.msi" /quiet DESKTOP_SHORTCUT=0 

cls

call "C:\Windows\Install\GPU Drivers\GPUdrivers.bat"

cls


set "ZIEL_DATEI=C:\Program Files\MSI Afterburner\MSIAfterburner.exe"
set "VERKNUEPFUNG_ZIEL=C:\Users\Public\Desktop\MSIAfterburner.lnk"

mklink "%VERKNUEPFUNG_ZIEL%" "%ZIEL_DATEI%"

cls

call "C:\Windows\Install\Scripts\WiFi Disable-Enable.bat"

REM Anleitung zur Browser-Installation anzeigen
:menu
cls
echo -----------------------------------------------
echo             Browser Installation
echo -----------------------------------------------
echo.
echo Please choose a browser to install:
echo   [1] Google Chrome 
echo   [2] Firefox 
echo   [3] Brave 
echo   [4] Opera 
echo.

choice /c 1234 /n /m "Select the browser you wish to install (1-4): "
set browserChoice=%errorlevel%


REM Funktion zur Installation eines Browsers
if %browserChoice%==1 (
    REM Installieren von Google Chrome
    echo Downloading Browser...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/edbgwsdbr8jsap512uggy/googlechromestandaloneenterprise64.msi?rlkey=nm7h9nfsgunp53phit4b0hp8k&dl=1', 'C:\Windows\Install\Browsers\googlechromestandaloneenterprise64.msi')"
    echo Installing Google Chrome...
    start "" /wait msiexec /i "C:\Windows\Install\Browsers\googlechromestandaloneenterprise64.msi" /quiet 
    REM Optimierungsskript f r Chrome ausf hren
    REM Setzen von Google Chrome als Standardbrowser
    reg add "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v ProgId /d ChromeHTML /f
    reg add "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v ProgId /d ChromeHTML /f
    
    echo Applying browser tweaks...
    call "C:\Windows\Install\Browsers\Tweaks\chrome-optimization-run-after-installation.bat"
) else if %browserChoice%==2 (
    REM Installieren von Firefox
    echo Downloading Browser...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/za4kliwagv4etrqmxd9mx/Firefox-Setup-124.0.1.msi?rlkey=s6wfdt83zc76uqad98mih5tbt&dl=1', 'C:\Windows\Install\Browsers\Firefox-Setup-124.0.1.msi')" 
    echo Installing Firefox...
    start "" /wait msiexec /i "C:\Windows\Install\Browsers\Firefox-Setup-124.0.1.msi" /quiet 
    REM Optimierungsskript f r Firefox ausf hren
    REG ADD HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice /v ProgId /d FirefoxURL /f
    REG ADD HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice /v ProgId /d FirefoxURL /f

    echo Applying browser tweaks...
    call "C:\Windows\Install\Browsers\Tweaks\mozilla-optimization-run-after-installation.bat"
) else if %browserChoice%==3 (
    REM Installieren von Brave
    echo Downloading Browser...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/i5ah4nj987uu5j5hs0z1w/BraveBrowserStandaloneSilentSetup.exe?rlkey=sywsnarwrw7a9ti7scjww01uz&dl=1', 'C:\Windows\Install\Browsers\BraveBrowserStandaloneSilentSetup.exe')"
    echo Installing Brave...
    start "" /wait "C:\Windows\Install\Browsers\BraveBrowserStandaloneSilentSetup.exe" 
    REM Optimierungsskript f r Brave ausf hren
    REM Festlegen von Brave als Standardbrowser
    reg add "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v Progid /d BraveHTML /f
    reg add "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v Progid /d BraveHTML /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.url\UserChoice" /v Progid /d BraveHTML /f
    echo Applying browser tweaks...
    call "C:\Windows\Install\Browsers\Tweaks\brave-optimization-run-after-installation.bat"
) else if %browserChoice%==4 (
    REM Installieren von Opera
    echo Downloading Browser...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/ybldatrgvya7zcgf7v0xs/Opera_91.0.4516.16_Setup_x64.exe?rlkey=7340bv9y7gfv91gmyxfd4jdxu&dl=1', 'C:\Windows\Install\Browsers\Opera_91.0.4516.16_Setup_x64.exe')"
    echo Installing Opera...
    start "" /wait "C:\Windows\Install\Browsers\Opera_91.0.4516.16_Setup_x64.exe" /silent /norestart /launchopera=0
) else (
    REM Ung ltige Eingabe
    echo Invalid choice. Please enter a number between 1 and 4.
    goto menu
)

call "C:\Windows\Install\Browsers\Tweaks\remove-browsers-autoruns-entries.bat"
REM Installation des Browsers abgeschlossen
echo Browser installation completed.



cls
:install_spotify_input

echo ------------------------------
echo     Spotify Installation 
echo ------------------------------
echo.
echo Would you like to install Spotify on your system?
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Please make your choice: "
set installSpotify=%errorlevel%


REM Überprüfen, ob die Benutzereingabe gültig ist
if /i "%installSpotify%"=="1" (
    
    goto install_spotify
) else (
    if /i "%installSpotify%"=="2" (
        echo Skipping Spotify installation.
        goto install_spotify_skip
    ) else (
        echo Invalid input. Please enter '1' for yes or '2' for no.
        goto install_spotify_input
    )
)

:install_spotify
echo Downloading Spotify...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/d6divijwr6edaq671suyp/SpotifyFullSetup.exe?rlkey=tlshwlkbjd0k51entn9fj7jvi&dl=1', 'C:\Windows\Install\Programs\Spotify\SpotifyFullSetup.exe')"
echo Installing Spotify...
start "" /wait "C:\Windows\Install\Programs\Spotify\SpotifyFullSetup.exe" /silent
echo Spotify installation completed.

echo Waiting for 2 seconds...
timeout /t 2 /nobreak >nul
REM Spotify wird geschlossen
echo Closing Spotify...
taskkill /im spotify.exe /f

cls

REM Benutzer nach dem Debloaten von Spotify fragen
:debloat_spotify_input
echo Do you want to use Spotify Debloat by CatGamerOP ?
echo This will remove unnecessary features 
echo and components from Spotify to improve performance.
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Please make your choice (1/2): "
set debloatSpotify=%errorlevel%



if "%debloatSpotify%"=="1" (
    echo Debloating Spotify, please wait...
    call "C:\Windows\Install\Programs\Spotify\Spotify Debloat by CatGamerOP.bat"
    echo Spotify has been successfully debloated.
) else if "%debloatSpotify%"=="2" (
    echo You have chosen not to debloat Spotify.
) else (
    echo Invalid selection. Please choose either 1 or 2.
    goto debloat_spotify_input
)

echo.
:install_spotify_skip

cls

:askDiscord

echo ----------------------------------------
echo           Discord Installation 
echo ----------------------------------------
echo. 
echo Would you like to Install Discord?
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Please select an option (1/2): "
set installDiscord=%errorlevel%



if "%installDiscord%"=="1" (
    echo Downloading Discord...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/xe4dea8rgxh5uli0lg8tm/DiscordSetup.exe?rlkey=hjou86g0hq5cc1nizxfvksmvc&dl=1', 'C:\Windows\Install\Programs\Discord\DiscordSetup.exe')"
    echo Installing Discord, please wait...
    start "" /wait "C:\Windows\Install\Programs\Discord\DiscordSetup.exe"
    echo Discord has been successfully installed.
    echo Waiting for 2 seconds before proceeding...
    timeout /t 2 /nobreak >nul
    
    taskkill /im discord.exe /f
    
    echo.
) else if "%installDiscord%"=="2" (
    echo You have chosen not to install Discord at this time.
    echo.
) else (
    echo Invalid selection detected. Please choose either 1 or 2.
    goto askDiscord
)



cls




:ask_epic_installation

echo -----------------------------------------------
echo       Epic Games Launcher Installation
echo -----------------------------------------------
echo.
echo Would you like to install the Epic Games Launcher?
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Select your option (1/2): "
set installEpic=%errorlevel%



if "%installEpic%"=="1" (
    echo Downloading EpicGames...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/6rio8agtutoi8e8gq6luw/EpicInstaller-15.17.1-e9c20de025b74f49935e673191c57729.msi?rlkey=mpzdcwz9h5lqh9sw1l5e5jdz1&dl=1', 'C:\Windows\Install\GameLaunchers\EpicInstaller-15.17.1-e9c20de025b74f49935e673191c57729.msi')"
    echo Installing Epic Games Launcher, please wait...
    start "" /wait msiexec /i "C:\Windows\Install\GameLaunchers\EpicInstaller-15.17.1-e9c20de025b74f49935e673191c57729.msi" /quiet /qn
    echo Epic Games Launcher has been successfully installed.
) else if "%installEpic%"=="2" (
    echo You have chosen not to install Epic Games Launcher at this time.
) else (
    echo Invalid selection detected. Please choose either 1 or 2.
    goto ask_epic_installation
)

echo.

cls

:askSteam

echo -------------------------------------
echo            Steam Installation 
echo -------------------------------------
echo.
echo Would you like to install Steam on your system?
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Select your option (1/2): "
set installSteam=%errorlevel%



if "%installSteam%"=="1" (
    echo Downloading Steam...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/lpm2bd5w1bswz4ooevi40/SteamSetup.exe?rlkey=eacs9too6b9d46gyxz9wph511&dl=1', 'C:\Windows\Install\GameLaunchers\SteamSetup.exe')"
    echo Installing Steam, please wait...
    start "" /wait "C:\Windows\Install\GameLaunchers\SteamSetup.exe" /S
    echo Steam has been successfully installed.
) else if "%installSteam%"=="2" (
    echo Steam installation has been skipped.
) else (
    echo Invalid selection detected. Please choose either 1 or 2.
    goto askSteam
)

echo.

cls




:install_OBS_ask
cls
echo -----------------------------------------------
echo          OBS Studio Installation Wizard
echo -----------------------------------------------
echo.
echo Would you like to install OBS Studio on your system?
echo   [1] Yes 
echo   [2] No 
echo.

choice /c 12 /n /m "Please select an option (1/2): "
set installOBS=%errorlevel%


REM Installiere OBS, wenn der Benutzer "1" eingibt
if /i "%installOBS%"=="1" (
	goto install_OBS
) 
REM Wenn der Benutzer "2" eingibt, keine Installation von OBS durchf hren
else if /i "%installOBS%"=="2" (
    echo OBS installation skipped.
	goto install_OBS_skip
) 
REM Bei ung ltiger Eingabe den Benutzer erneut nach der Installationsbereitschaft von OBS fragen
else (
    echo Invalid input. Please enter '1' for yes or '2' for no.
	goto install_OBS_ask
)


:install_OBS
cls
echo -----------------------------------------------
echo        OBS Studio Version Selection
echo -----------------------------------------------
echo.
echo Please choose the version of OBS Studio you wish to install:
echo   [1] New version - OBS Studio 30.0.2
echo   [2] Old version - OBS Studio 27.1.3
echo.

choice /c 12 /n /m "Select your option (1/2): "
set obsVersion=%errorlevel%



if "%obsVersion%"=="1" (
    echo Downloading OBS...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/alv9jrgf3cwl99wnb0yhu/OBS-Studio-30.0.2-Full-Installer-x64.exe?rlkey=dgerdlg7hykneor3z2eoiboke&dl=1', 'C:\Windows\Install\Programs\OBS\OBS-Studio-30.0.2-Full-Installer-x64.exe')"

    echo Installing the newest version of OBS Studio...
    start "" /wait "C:\Windows\Install\Programs\OBS\OBS-Studio-30.0.2-Full-Installer-x64.exe" /S
    echo OBS Studio 30.0.2 installation completed.
) else if "%obsVersion%"=="2" (
    echo Downloading OBS...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/cycwrhcy8xtvxt2a6cu6q/OBS-Studio-27.1.3-Full-Installer-x64.exe?rlkey=ogv6yhepg6e4eenb94hrsceqx&dl=1', 'C:\Windows\Install\Programs\OBS\OBS-Studio-27.1.3-Full-Installer-x64.exe')"
    echo Installing an older version of OBS Studio...
    start "" /wait "C:\Windows\Install\Programs\OBS\OBS-Studio-27.1.3-Full-Installer-x64.exe" /S
    echo OBS Studio 27.1.3 installation completed.
) else (
    echo An unexpected error occurred. Please try again.
    goto install_OBS
)

echo.

:install_OBS_skip



cls

echo Applying tweaks...
call "C:\Windows\Install\Scripts\disable-process-mitigations.bat"

call "C:\Windows\Install\Scripts\powerplans.bat"

call "C:\Windows\Install\Network\run-this-after-network-driver-installation.bat"

call "C:\Windows\Install\configure-services-and-features\write-cache-buffer-flushing\write-cache-buffer-flushing.bat"

call "C:\Windows\Install\configure-services-and-features\superfetch\disable-superfetch.bat"

call "C:\Windows\Install\configure-services-and-features\xbox-games-and-full-screen-exclusive\enable-fse-and-disable-gamebar.bat"

call "C:\Windows\Install\configure-services-and-features\printing-scanning\disable-printing.bat"

call "C:\Windows\Install\configure-services-and-features\Disable USB Devices Idle.bat"

call "C:\Windows\Install\Scripts\Devices.bat"

call "C:\Windows\Install\Scripts\Visual_Effects.bat"

call "C:\Windows\Install\Scripts\miscellaneous.bat"



echo Disable Services...
call "C:\Windows\Install\Services\Disable\Service Disabler.bat"


call "C:\Windows\Install\Autorun\AutoRuns.bat"



set newName=NinckOS
wmic computersystem where caption='%COMPUTERNAME%' rename "%newName%"

set "outputFile=C:\Windows\Install\Scripts\finished.txt"
echo Finished > "%outputFile%"


set "startup_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
set "script_to_delete=start.bat"

if exist "%startup_folder%\%script_to_delete%" (
    del /q "%startup_folder%\%script_to_delete%"
    echo Script "%script_to_delete%" deleted from startup folder.
) else (
    echo Script "%script_to_delete%" not found in startup folder.
)

cls

REM Warten auf Benutzerbest tigung
echo Press any key to Reboot...
pause >nul

REM Neustart des PCs
echo Restarting the computer...
shutdown /r /t 0

