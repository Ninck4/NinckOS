@echo off
cls
echo ------------------------------
echo    GPU DRIVER INSTALLATION 
echo ------------------------------
echo.

:gpu_select
echo Please select your GPU manufacturer or skip:
echo   [1] NVIDIA 
echo   [2] AMD 
echo   [3] Skip - If you do not wish to install a GPU driver.
echo.

choice /c 123 /n /m "Select an option (1-3) and press Enter: "
set gpuChoice=%errorlevel%

echo.

REM Entscheidungsstruktur
if %gpuChoice%==1 (
    cls
    echo You selected NVIDIA.
    goto nvidia_driver_version
) else if %gpuChoice%==2 (
    cls
    echo You selected AMD.
    goto amd_driver_version
) else if %gpuChoice%==3 (
    cls
    echo Skipping driver installation.
    goto skip_driver
) else (
    echo Invalid choice. Please enter a number between 1 and 3.
    goto gpu_select
)



REM NVIDIA GPU ausgewählt
:nvidia_driver_version
echo Please select the NVIDIA driver version you wish to install:
echo   [1] Version 551.61 (recommended)
echo   [2] Version 535.98 
echo   [3] Version 472.12 
echo   [4] Go back - Return to the previous menu.
echo.

choice /c 1234 /n /m "Select an option (1-4) and press Enter: "
set driverChoice=%errorlevel%

echo.
if %driverChoice%==1 (
    cls
    goto :nvidia_driver_551_61
    
) else if %driverChoice%==2 (
    cls
    goto :nvidia_driver_535_98

) else if %driverChoice%==3 (
    cls
    goto :nvidia_driver_472_12

) else if %driverChoice%==4 (
    cls
    goto gpu_select
) else (
    echo Invalid choice. Please select a valid option.
    goto nvidia_driver_version
)


REM AMD GPU ausgewählt
:amd_driver_version
REM Fügen Sie hier den Code für die Installation der AMD-Treiber hinzu
echo Downloading Driver...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/nxi2r108ww3l6b7uf9k1y/amd-software-adrenalin-edition-24.2.1-combined-minimalsetup-240223_web.exe?rlkey=2gnq0gqq6zi9ahmxid0a4up0v&dl=1', 'C:\Windows\Install\AMD\amd-software-adrenalin-edition-24.2.1-combined-minimalsetup-240223_web.exe')"
echo Installing AMD Adrenalin and Graphics Driver DONT RESTART in Setup!!!
start /wait C:\Windows\Install\AMD\amd-software-adrenalin-edition-24.2.1-combined-minimalsetup-240223_web.exe
echo FINISHED
goto after_AMDgpu_selection



REM None ausgewählt
:skip_driver
echo Skipping GPU driver installation.
exit /b





:nvidia_driver_551_61
cls
echo You have selected NVIDIA driver version 551.61.
echo Would you like to include GeForce Experience (GFE) in your installation?
echo   [1] Yes - Install with GeForce Experience.
echo   [2] No - Install driver only.
echo.

choice /c 12 /n /m "Select your option (1/2): "
set installGFE=%errorlevel%

echo.

REM Überprüfe die Benutzereingabe und führe entsprechende Aktionen aus
if  %installGFE%==1 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/r0138cd99o7dgc3c8yle9/NVIDIA_WithGFE_551.61.exe?rlkey=klrtbnj5cic6hrxx8fmomzo15&dl=1', 'C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_551.61.exe')"
    echo Installing NVIDIA driver version 551.61 with GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_551.61.exe" /s /norestart
    echo Installation completed.
) else if  %installGFE%==2 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/288b2t43tbc23ycsgr23b/NVIDIA_NoGFE_551.61.exe?rlkey=s5tu3a6z7noklkixx5red8eno&dl=1', 'C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_551.61.exe')"  
    echo Installing NVIDIA driver version 551.61 without GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_551.61.exe" /s /norestart
    echo Installation completed.
) else (
    echo Invalid input. Please enter '1' for Yes or '2' for No.
    goto nvidia_driver_551_61
)

echo.
goto after_gpu_selection

REM ------------------------------------------------------------------------------------------------------------

:nvidia_driver_535_98
cls
echo You have selected NVIDIA driver version 535.98.
echo Would you like to include GeForce Experience (GFE) in your installation?
echo   [1] Yes - Install with GeForce Experience.
echo   [2] No - Install driver only.
echo.

choice /c 12 /n /m "Please select an option (1/2): "
set installGFE=%errorlevel%

echo.
REM Installation des Treibers basierend auf der Auswahl von GeForce Experience
if  %installGFE%==1 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/1oip1a5z0m31g60mqt69f/NVIDIA_WithGFE_535.98.exe?rlkey=wa3r5sgnkta3xf1jgmb82hf2d&dl=1', 'C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_535.98.exe')" 
    echo Installing NVIDIA driver version 535.98 with GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_535.98.exe" /s /norestart
    echo Installation completed.
) else if  %installGFE%==2 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/21jshdcn25x7idod965oh/NVIDIA_NoGFE_535.98.exe?rlkey=h43ipg29c1ggl8x29ghzwl34n&dl=1', 'C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_535.98.exe')"
    echo Installing NVIDIA driver version 535.98 without GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_535.98.exe" /s /norestart
    echo Installation completed.
) else (
    echo Invalid input. Please enter '1' for yes or '2' for no.
    goto nvidia_driver_535_98
)

echo.
goto after_gpu_selection



REM ------------------------------------------------------------------------------------------------------------

:nvidia_driver_472_12
cls
echo You have selected NVIDIA driver version 472.12.
echo Would you like to include GeForce Experience (GFE) in your installation?
echo   [1] Yes - Install with GeForce Experience.
echo   [2] No - Install driver only.
echo.

choice /c 12 /n /m "Select your option (1/2): "
set installGFE=%errorlevel%

echo.

REM Installation des Treibers basierend auf der Benutzerauswahl
if  %installGFE%==1 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/2l3gfnd67rywp2xihne2i/NVIDIA_WithGFE_472.12.exe?rlkey=75ys2665kuf4ekx2xbt24ctge&dl=1', 'C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_472.12.exe')"
    echo Installing NVIDIA driver version 472.12 with GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\GFE\NVIDIA_WithGFE_472.12.exe" /s /norestart
    echo Installation completed.
) else if  %installGFE%==2 (
    echo.
    echo Downloading Driver... This may take some time
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/gbv2rmbqrayozbl1nauwf/NVIDIA_NoGFE_472.12.exe?rlkey=ohv0i4q2b3gcq0e1dgzewplvo&dl=1', 'C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_472.12.exe')"
    echo Installing NVIDIA driver version 472.12 without GeForce Experience...
    start "" /wait "C:\Windows\Install\Nvidia\Drivers\NO GFE\NVIDIA_NoGFE_472.12.exe" /s /norestart
    echo Installation completed.
) else (
    echo Invalid selection. Please enter '1' for yes or '2' for no.
    goto nvidia_driver_472_12
)

echo.
goto after_gpu_selection

REM -------------------------------------------------------------------------------------------------------

:after_gpu_selection
cls

echo ------------------------------
echo     GPU Post-Configuration 
echo ------------------------------
echo.

echo The system can force the GPU to use  P0 state for potentially better performance.
echo This is recommended for gaming.
echo.

REM Abfrage für Force P0 States
echo Do you want to force the GPU to use P0 state?  
echo   [1] Yes (recommended)
echo   [2] No 
echo.
choice /c 12 /n /m "Select your option (1/2): "
set enableForceP0=%errorlevel%

echo.
REM Installation von Force P0 States
if  %enableForceP0%==1 (
    echo Enabling Force P0 States for better performance...
    call "C:\Windows\Install\Nvidia\Force P0-State (Eagle).bat"
    echo Force P0 States have been enabled.
) else if  %enableForceP0%==2 (
    echo Skipping the enforcement of P0 States. Your system will operate in its default state.
) else (
    echo Invalid input detected. Please enter '1' for yes or '2' for no.
    goto after_gpu_selection
)

echo.

REM Immer ausgeführte Befehle
echo Running additional Tweaks...

"C:\Windows\Install\Nvidia\Nvidia Profile Inspector\nvidiaProfileInspector.exe" -silentImport "C:\Windows\Install\Nvidia\Nvidia Profile Inspector\NinckOS.nip"



regedit /s "C:\Windows\Install\Regs\AddNvidiaControlPanel.reg"
regedit /s "C:\Windows\Install\Regs\Remove_NVIDIA_Control_Panel_from_desktop_context_menu_for_current_user.reg"

call "C:\Windows\Install\Nvidia\Disable Scaling (Eagle).bat"
call "C:\Windows\Install\Nvidia\No ECC.bat"
call "C:\Windows\Install\Nvidia\Unrestricted Clock Policy by Cancerogeno.bat"
echo GPU driver installation completed.
cls

:after_AMDgpu_selection

