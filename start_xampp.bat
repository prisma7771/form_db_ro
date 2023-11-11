@echo off

:: Read configuration from file
set "CONFIG_FILE=config.txt"
for /f "tokens=1,* delims==" %%A in (%CONFIG_FILE%) do set "%%A=%%B"

:: Change to XAMPP Folder
cd /d %XAMPP_PATH%

:: Start MySQL server
start /min xampp-control.exe

:: Open a new command prompt window to run Laravel backend
start /min cmd /k "cd /d %BACKEND_PATH% && php artisan serve --host 0.0.0.0"

:: Open a new command prompt window to run Vue.js frontend
:: start /min cmd /k "cd /d %FRONTEND_PATH% && npm run dev -- --host 0.0.0.0"

:: Add a delay to give the Vue.js app time to start (adjust the delay as needed)
timeout /t 10

:: Open the Vue.js app in the default web browser
start http://localhost:8000
