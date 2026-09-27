@echo off
chcp 65001 >nul
title UniRemington Fest
cd /d "%~dp0"
echo.
echo UniRemington Fest - 30 anos Uniremington
echo ----------------------------------------
echo.

where python >nul 2>nul
if errorlevel 1 goto sin_python

echo Abriendo la pagina en http://127.0.0.1:5520
echo Deja esta ventana abierta mientras uses la pagina. Cierrala para terminar.
echo.
start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; Start-Process 'http://127.0.0.1:5520/'"
python -m http.server 5520 --bind 127.0.0.1
goto fin

:sin_python
echo Python no esta instalado. La pagina funcionara, pero es posible que el Excel requiera Python.
echo.
start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; Start-Process 'http://localhost:5520/'"
python -m http.server 5520
:: Omitimos servidor.ps1 porque no disponemos del archivo en este proyecto.

:fin
pause
