@echo off
setlocal enabledelayedexpansion

:: ==============================================================================
:: Cloudflared Interactive CLI (Auto-Port & Self-Installer)
:: Windows Batch Version
:: ==============================================================================

title CLOUDFLARE AUTO-PORT CLI
set "PORT_START=8000
set "PORT_END=9000"

:: ------------------------------------------------------------------------------
:: Auto-Dependency Check & Installer
:: ------------------------------------------------------------------------------
:check_dependencies
echo [*] Checking system dependencies...

where python >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python is missing. Please install Python from the Microsoft Store or python.org before continuing.
    pause
    exit /b 1
)

where cloudflared >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Missing dependency detected: cloudflared
    set /p "install_choice=[?] Would you like to download and install cloudflared via winget now? (y/N): "
    if /i "!install_choice!"=="y" (
        echo [*] Running system installer...
        winget install Cloudflare.cloudflared
        echo [*] Please restart this command prompt if cloudflared is still not found after installation.
        timeout /t 3 >nul
    ) else (
        echo [!] Cannot proceed without cloudflared. Exiting.
        pause
        exit /b 1
    )
)
goto :menu

:: ------------------------------------------------------------------------------
:: Interactive UI Loop
:: ------------------------------------------------------------------------------
:menu
cls
echo =====================================
echo    CLOUDFLARE AUTO-PORT CLI
echo =====================================
echo Port range: %PORT_START% - %PORT_END%
echo -------------------------------------
echo 1) Start server (auto port)
echo 2) List servers
echo 3) Stop server
echo 4) Stop all
echo 5) Restart server
echo 6) Exit
echo -------------------------------------
set /p "opt=Select option: "

if "%opt%"=="1" call :start_server
if "%opt%"=="2" call :list_servers
if "%opt%"=="3" call :stop_server
if "%opt%"=="4" call :stop_all & echo All stopped & pause
if "%opt%"=="5" call :restart_server
if "%opt%"=="6" call :stop_all & exit /b 0

goto :menu

:: ------------------------------------------------------------------------------
:: Start Server Engine
:: ------------------------------------------------------------------------------
:start_server
set /p "TARGET=Enter file/directory path: "

if "%TARGET%"=="" echo Invalid path.& pause & exit /b
if not exist "%TARGET%" echo Invalid path.& pause & exit /b

:: Resolve to absolute path using PowerShell
for /f "delims=" %%i in ('powershell -NoProfile -Command "[System.IO.Path]::GetFullPath('%TARGET%')"') do set "ABS_TARGET=%%i"

:: Find free port
set "PORT="
for /l %%p in (%PORT_START%,1,%PORT_END%) do (
    netstat -ano | findstr /r /c:":%%p " >nul 2>&1
    if errorlevel 1 (
        set "PORT=%%p"
        goto :port_found
    )
)
:port_found
if "%PORT%"=="" echo No free ports available in range %PORT_START%-%PORT_END% & pause & exit /b

:: Generate unique 6 digit ID
set /a ID=%RANDOM% * 90000 / 32768 + 10000

echo Starting server on auto port %PORT%...

:: Extract Directory and File definitions
set "IS_DIR=0"
for /f "tokens=1,2 delims=" %%a in ("%ABS_TARGET%") do (
    if exist "%%~a\" (
        set "DIR=%%~a"
        set "FILE="
        set "IS_DIR=1"
    ) else (
        set "DIR=%%~dp~a"
        set "FILE=%%~nx~a"
    )
)

:: Spin up Python HTTP Server in background using PowerShell tracking
for /f "delims=" %%p in ('powershell -NoProfile -Command "Start-Process python -ArgumentList '-m http.server %PORT%' -WorkingDirectory '%DIR%' -WindowStyle Hidden -PassThru | Select-Object -ExpandProperty Id"') do set "HTTP_PID=%%p"

timeout /t 2 >nul

:: Setup Cloudflared Tunnel tracking
set "LOG_FILE=%TEMP%\cf_%ID%.log"
if exist "%LOG_FILE%" del "%LOG_FILE%"

for /f "delims=" %%c in ('powershell -NoProfile -Command "Start-Process cloudflared -ArgumentList 'tunnel --url http://localhost:%PORT% --no-autoupdate' -RedirectStandardError '%LOG_FILE%' -WindowStyle Hidden -PassThru | Select-Object -ExpandProperty Id"') do set "CF_PID=%%c"

:: Wait for cloudflare parsing URL
echo Waiting for tunnel URL generation...
set "URL="
for /l %%i in (1,1,30) do (
    if exist "%LOG_FILE%" (
        for /f "tokens=*" %%u in ('powershell -NoProfile -Command "Select-String -Path '%LOG_FILE%' -Pattern 'https://[-a-zA-Z0-9]+\.trycloudflare\.com' | ForEach-Object { $_.Matches.Value } | Select-Object -First 1"') do set "URL=%%u"
    )
    if not "!URL!"=="" goto :url_ready
    timeout /t 1 >nul
)

:url_ready
if "%URL%"=="" (
    echo Failed to create tunnel.
    taskkill /PID %HTTP_PID% /F >nul 2>&1
    taskkill /PID %CF_PID% /F >nul 2>&1
    pause
    exit /b
)

:: Save to Pseudo-Environment Arrays
set "PORT_MAP_%ID%=%PORT%"
set "DIR_MAP_%ID%=%DIR%"
set "FILE_MAP_%ID%=%FILE%"
set "HTTP_PID_MAP_%ID%=%HTTP_PID%"
set "CF_PID_MAP_%ID%=%CF_PID%"
set "URL_MAP_%ID%=%URL%"

echo.
echo [✔] Server Started
echo ID:   %ID%
echo PORT: %PORT%
echo URL:  %URL%
if not "%FILE%"=="" echo FILE: %URL%/%FILE%
echo.
pause
exit /b

:: ------------------------------------------------------------------------------
:: Manage Running Servers
:: ------------------------------------------------------------------------------
:list_servers
echo.
echo ========== ACTIVE SERVERS ==========

set "FOUND=0"
for /f "tokens=3 delims=_=" %%a in ('set PORT_MAP_ 2^>nul') do (
    set "cid=%%a"
    set "FOUND=1"
    
    :: Verify PIDs are still alive
    set "h_pid=!HTTP_PID_MAP_%%a!"
    set "c_pid=!CF_PID_MAP_%%a!"
    
    tasklist /FI "PID eq !h_pid!" 2>nul | findstr /I "python" >nul
    set "h_alive=!errorlevel!"
    tasklist /FI "PID eq !c_pid!" 2>nul | findstr /I "cloudflared" >nul
    set "c_alive=!errorlevel!"
    
    if not "!h_alive!"=="0" (
        call :cleanup_server !cid!
    ) else if not "!c_alive!"=="0" (
        call :cleanup_server !cid!
    ) else (
        echo.
        echo ID:   !cid!
        echo PORT: !PORT_MAP_%%a!
        echo DIR:  !DIR_MAP_%%a!
        if not "!FILE_MAP_%%a!"=="" echo FILE: !FILE_MAP_%%a!
        echo URL:  !URL_MAP_%%a!
        echo -----------------------------------
    )
)

if "%FOUND%"=="0" echo No active servers.
pause
exit /b

:stop_server
set /p "STOP_ID=Enter server ID: "
if "!PORT_MAP_%STOP_ID%!"=="" (
    echo Server not found.
    pause
    exit /b
)
call :cleanup_server %STOP_ID%
echo [✔] Server stopped
pause
exit /b

:restart_server
set /p "R_ID=Enter server ID: "
set /p "NEW_PATH=Enter new path: "

if "!PORT_MAP_%R_ID%!"=="" echo Invalid input.& pause & exit /b
if not exist "%NEW_PATH%" echo Invalid input.& pause & exit /b

call :cleanup_server %R_ID%
echo Restarting...
timeout /t 1 >nul

:: Forward variables seamlessly into the generic setup sequence logic
set "TARGET=%NEW_PATH%"
call :start_server
exit /b

:cleanup_server
set "target_id=%1"
set "h_pid=!HTTP_PID_MAP_%target_id%!"
set "c_pid=!CF_PID_MAP_%target_id%!"

taskkill /PID %h_pid% /F >nul 2>&1
taskkill /PID %c_pid% /F >nul 2>&1

set "PORT_MAP_%target_id%="
set "DIR_MAP_%target_id%="
set "FILE_MAP_%target_id%="
set "HTTP_PID_MAP_%target_id%="
set "CF_PID_MAP_%target_id%="
set "URL_MAP_%target_id%="
if exist "%TEMP%\cf_%target_id%.log" del "%TEMP%\cf_%target_id%.log"
exit /b

:stop_all
for /f "tokens=3 delims=_=" %%a in ('set PORT_MAP_ 2^>nul') do (
    call :cleanup_server %%a
)
exit /b
