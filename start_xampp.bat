@echo off
cd /d E:\Programming\xampp

:: Start MySQL server
start /min xampp-control.exe

:: Open a new command prompt window to run npm run start
start /min cmd /k "cd /d E:\Programming\Web\Vue\form_input\backend && php artisan serve --host 0.0.0.0"

:: Add a delay to give the Vue.js app time to start (adjust the delay as needed)
timeout /t 10

:: Open the Vue.js app in the default web browser
start http://localhost:8000
