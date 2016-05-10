@echo off
title System.new.dat Extractor and Repacker ver3.0
setlocal EnableDelayedExpansion
cd /d "%~dp0"
goto admin_

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                        ::
:: Copyright (c) 2016 - matrixex   (@xda devs)                            ::
::                                                                        ::
:: This script is free you can edit modify and make it better as you wish ::
:: This script file is intended for personal and/or educational use only. :: 
:: It may not be duplicated for monetary benefit or any other purpose     ::  
:: without the permission of the developer.                               ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:home
cls
echo.
echo #               Extractor and Repacker    
bin\cecho #           {0f}Marshmallow system extractor{#}
echo.
bin\cecho #                  {0a}(by matrix){#}                                                                                     
echo.
echo.
echo.
echo.
bin\cecho        {0f}Select a task :{#}
echo.
echo      ===================
echo.
bin\cecho   1 - {0b}Unpacking "system.new.dat".{#}
echo.
bin\cecho   2 - {0b}Repack "system.new.dat".{#}
echo. 
bin\cecho   3 - {0b}Unpack "system.img".{#}
echo.
bin\cecho   4 - {0b}Exit.{#}  
echo.

echo.
set /p web=Type option:
if "%web%"=="1" goto extractor
if "%web%"=="4" goto ex_t
if "%web%"=="2" goto repack
if "%web%"=="3" goto Image
goto home

:extractor
cls
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::
bin\cecho :: Copy {0a}"system.new.dat"{#} , {0a}"system.transfer.list"{#} ::
echo.
bin\cecho :: and {0a}"file_contexts"{#} to current folder.         :: 
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
pause
cls
if not exist system.new.dat goto stop5
echo.
if not exist system.transfer.list goto stop6
echo.
if not exist file_contexts goto stop7
echo.
echo.
if exist system.new.dat echo found system.new.dat
if exist system.transfer.list echo found system.transfer.list
if exist file_contexts echo found file_contexts
echo.
echo.
pause
echo converting "system.new.dat" to "system.img.ext4"
echo.
bin\sprs2ext.exe system.transfer.list system.new.dat file_contexts
echo.
echo converting "system.img.ext4" to "system"
REN system.img.ext4 *.img 
bin\Imgextractor.exe system.img.img -i
del system.img.img
del system.new.dat
del system.transfer.list
del file_contexts
MOVE system_ system
echo.
echo.
bin\cecho Done. Go to the folder {0a}"system"{#}
echo.
pause
goto home

:repack
cls
echo.
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
bin\cecho :: {0c}Warning{#} This is only for advance users it may or may not work ::
echo.
echo :: If you are a newbie then I strongly recommend you to flash    :: 
echo :: system through updater-script instead of system.new.dat       ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo Are you sure you want to continue (y or n)
echo.
set /p web2=Type option: 
if "%web2%"=="y" goto extract
if "%web2%"=="n" goto home
if "%web2%"=="Y" goto extract
if "%web2%"=="N" goto home  

:extract
cls
echo.
if not exist system md system
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
bin\cecho ::{0c}* (Warning READ CAREFULLY){#}                                             ::
echo.
echo ::  Copy all your sub folders/files (like /app,/bin,/lib build.prop etc.):: 
bin\cecho ::  to {0a}"system"{#} folder and delete all previously extracted files from    :: 
echo.
echo ::  current folder and press enter                                       ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
pause
cls
echo.
if not exist system\app goto stop1
echo.
echo.
if exist system\app echo        Found System FOLDER
echo.
bin\make_ext4fs.exe -s -l 2048M system.img system
echo.
echo It will take some time aproxx 4-5 minutes
echo.
bin\simg2img.exe system.img system.raw.img
del system.img
REN system.raw.img *em.img 
echo.
bin\rimg2sdat.exe
del system.img
if not exist system.new.dat goto stop8
echo.
cls
echo.
echo.
bin\cecho DONE {0a}"system.transfer.list"{#} and {0a}"system.new.dat"{#} created in current folder
echo.
echo just copy it(both) to your ROM
echo.
pause
goto home

:Image
echo.
cls
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
bin\cecho ::  Copy {0a}system.img{#} to current folder and make sure it is :: 
echo.
bin\cecho ::  named as {0a}system.img{#} no other name is allowed          ::
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
pause
echo.
if not exist system.img goto stop2
echo.
echo wait aproxx 2-3 minutes
echo.
bin\simg2img.exe system.img system.raw.img
echo.
del system.img
REN system.raw.img *em.img
bin\Imgextractor.exe system.img -i
MOVE system_ system
del system.img
echo.
echo Done go to "system" folder
echo.
pause
goto home



:admin_
>>nul 2>>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM -->> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto PERM
) else ( goto start )
:PERM
    echo Set UAC = CreateObject^("Shell.Application"^) >> "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:start 
SET count=1 
 FOR %%G IN (.,..,...,....,.....) DO (
 ping -n 2 -w 200 127.0.0.1 > nul
 echo %count%
 cls
 echo.
 echo.
 echo.
 echo     Welcome To matrix's System Extract and Repack
 echo.
 echo     loading %%G
 set /a count+=1 )
 goto home


:stop1
echo.
echo ----------------------------------------------------
echo  It seems that the you have not copied sub folder 
bin\cecho  like /app,/bin,/lib build.prop etc. to {0c}"system"{#}
echo. 
echo  folder present in current directry please follow 
echo  Instructions carefully and also read help section
echo ----------------------------------------------------
echo.
pause
goto home

:stop2
cls
echo.
echo ------------------------------------------------------------
bin\cecho   {0f}"system.img"{#} is not found in current folder Please copy
echo. 
bin\cecho   {0f}system.img{#} to current folder or rename your system image 
echo.
bin\cecho   file to {0f}system.img{#}
echo.
echo ------------------------------------------------------------
echo.
pause
goto home

:stop3
cls
echo.
echo  ----------------------------------------------------------------
echo    Something is missing from current folder please copy
bin\cecho    {0c}"system.new.dat"{#} , {0c}"system.transfer.list"{#} and {0c}"file_contexts"{#}
echo.
echo    to CURRENT FOLDER  see help
echo  ----------------------------------------------------------------
echo.
pause
goto home

:stop5
cls
echo.
bin\cecho {0a}"system.new.dat"{#} is not found
echo.
echo Please copy system.new.dat to current folder
echo.
pause
goto home

:stop6
cls
echo.
bin\cecho {0a}"system.transfer.list"{#} is not found
echo.
echo Please copy system.transfer.list to current folder
echo.
pause
goto home

:stop7
cls
echo.
bin\cecho {0a}"file_contexts"{#} is not found
echo.
echo  Please copy file_contexts to current folder
echo.
pause
goto home

:stop8
cls
echo.
echo  It seems like the extractor not worked with your 
echo  provided system folder please contact me for help
echo.
pause
goto home

:opensystem
cls
::Under Construction
if not exist system goto stop10
%SystemRoot%\explorer.exe "system"
echo.
echo        Opened
echo.
pause
goto home

:stop10
echo.
echo.
echo There is no system folder found!
echo this implies that this extractor 
echo not worked with your .DAT files
echo.
pause
goto home

:ex_t
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo              Thanks for using
ping -n 2 -w 200 127.0.0.1 > nul

exit
