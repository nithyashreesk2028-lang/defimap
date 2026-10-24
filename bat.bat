@echo off
title DefiMap Launcher

echo ============================================
echo     Starting Apache and MySQL...
echo ============================================

:: Start Apache
start "" "C:\xampp\apache_start.bat"

:: Wait a moment
timeout /t 2 /nobreak >nul

:: Start MySQL
start "" "C:\xampp\mysql_start.bat"

:: Wait for services to start
timeout /t 5 /nobreak >nul

:: Open browser
start "" "http://localhost/DefiMap/index.php"

echo.
echo DefiMap is ready!
pause