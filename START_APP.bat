@echo off
title Social Media Agent - Launcher
color 0A

echo.
echo  ============================================================
echo    SOCIAL MEDIA AGENT  ^|  IBM watsonx Powered
echo  ============================================================
echo.
echo  [1/3] Opening firewall ports...
powershell -Command "Start-Process powershell -ArgumentList '-Command netsh advfirewall firewall add rule name=SocialAgent-3000 protocol=TCP dir=in localport=3000 action=allow 2>nul; netsh advfirewall firewall add rule name=SocialAgent-8000 protocol=TCP dir=in localport=8000 action=allow 2>nul' -Verb RunAs -Wait" >nul 2>&1
echo         Done.

echo  [2/3] Starting Backend on port 8000...
powershell -Command "Start-Process powershell -ArgumentList '-NoExit -ExecutionPolicy Bypass -Command Set-Location C:\Users\JAYASHREE\OneDrive\Desktop\Shree\social-media-agent\backend; Write-Host BACKEND STARTING... -ForegroundColor Green; & .venv\Scripts\python.exe -m uvicorn main:app --host 0.0.0.0 --port 8000' -WindowStyle Normal"

echo         Waiting 7 seconds for backend...
timeout /t 7 /nobreak >nul

echo  [3/3] Starting Frontend on port 3000...
powershell -Command "Start-Process powershell -ArgumentList '-NoExit -ExecutionPolicy Bypass -Command Set-Location C:\Users\JAYASHREE\OneDrive\Desktop\Shree\social-media-agent\frontend; Write-Host FRONTEND STARTING... -ForegroundColor Cyan; npm run dev' -WindowStyle Normal"

echo         Waiting 10 seconds for frontend...
timeout /t 10 /nobreak >nul

echo  Opening your browser...
start "" "http://localhost:3000"

echo.
echo  ============================================================
echo.
echo   YOUR PROTOTYPE IS LIVE!
echo.
echo   This Computer  --^>   http://localhost:3000
echo   Other Devices  --^>   http://192.168.0.110:3000
echo   API Explorer   --^>   http://localhost:8000/docs
echo.
echo   IMPORTANT: Keep the two PowerShell windows open!
echo   Closing them will stop the app.
echo.
echo  ============================================================
echo.
pause
