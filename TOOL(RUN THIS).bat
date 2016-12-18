@echo off
title SYSTEM.NEW.DAT Extractor v1.2
cd /d "%~dp0"

:home
cls
echo.
echo #                     BRO USE IT      
echo #           Marshmallow system extractor
echo #                                                                                                                  
echo.
echo -----------------Read Before doing anything--------------------
echo  Before working, copy "system.transfer.list" and "system.new.dat"         
echo  and "file_context" to the current folder                                                    
echo.
echo Select a task:
echo ==============
echo.
echo 1) Unpacking "system.new.dat".
echo 2) Exit.
echo.
set /p web=Type option:
if "%web%"=="1" goto extractor
if "%web%"=="2" goto ex_t
goto home

:extractor
echo.
echo converting "system.new.dat" to "system.img.ext4"
echo.
sprs2ext.exe system.transfer.list system.new.dat file_contexts
echo.
echo converting "system.img.ext4" to "system"
REN system.img.ext4 *.img 
Imgextractor.exe system.img.img -i
del system.img.img
echo Done. Go to the folder "system_"
pause
goto home

:ex_t
exit