@echo off
title Extract and Repack system.new.dat [4.0]
setlocal EnableDelayedExpansion
::mode con:cols=82 lines=27
::NORMAL COLS=82 LINES=25
cd /d "%~dp0"
goto admin_
::
:: I really over did the warning works ,like,if
::a file not found in directory, i use
::breakers like stop (for terminating the
::current process) its all for better
::understanding for users , but its also
::foolishnes,  it consumed a lots of time ,
::and i also bored because of typing and
::modifying script a lot , so i decided to
::remove warning and introducing the
::direct way , that include no warning.
::serioisly this script is getting bigger in
::size and lines


:errorNoPython
echo.
echo Error^: Python not installed
pause


:home
cls
echo.
echo #                   Extractor and Repacker    
bin\cecho #               {0f}Marshmallow system extractor{#}
echo.
bin\cecho #                      {0a}(by matrix){#}                                                                                     
echo.
bin\cecho                                                        {0b}%activity%{#} {0f}%recent%{#}
echo.
echo.
echo.
bin\cecho        {0f}Select a task :{#}
echo.
echo      =-=-=-=-=-=-=-=-=-=
echo.
bin\cecho       1 - {0b}Unpack{#} {0f}system.new.dat{#}
echo.
echo.
bin\cecho       2 - {0b}Repack{#} {0f}system.new.dat{#}
echo.
echo.
bin\cecho       3 - {0b}Unpack{#} {0f}system.img{#}
echo.
echo.
bin\cecho       4 - {0b}Sign{#} {0f}ZIP files{#}
echo.
echo.
bin\cecho       5 - {0b}Exit{#}  
echo.
echo.
set /p web=Type option:
if "%web%"=="1" goto extractor
if "%web%"=="5" goto ex_t
if "%web%"=="2" goto repack
if "%web%"=="3" goto Image_unpack
if "%web%"=="4" goto sign
echo.
echo Select a valid option.....
echo ping -n 200 -w 200 127.0.0.1 > nul
goto home

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                             Extract Script                                        ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                                   ::

:extractor
cls
echo.
echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::
echo   ::                                                ::
bin\cecho   :: Copy {0a}"system.new.dat"{#} , {0a}"system.transfer.list"{#} ::
echo.
bin\cecho   :: and {0a}"file_contexts"{#} to current folder.         :: 
echo.
echo   ::                                                ::
echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::
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
if exist system.new.dat bin\cecho   {0c}found system.new.dat{#}
echo.
if exist system.transfer.list bin\cecho   {0c}found system.transfer.list{#}
echo.
if exist file_contexts bin\cecho   {0c}found file_contexts{#}
echo.
echo.
echo.
pause
echo converting "system.new.dat" to "system.img.ext4"
echo.
goto find_python

:find_python
python --version 2>NUL
 if %ERRORLEVEL% ==0 (goto :python) else (goto :standlone) 
 
::
::(C)Xpirit's sdat2img.py binary
::
:python
  echo.
  echo.
  echo    Python is installed 
  echo.
  bin\python\sdat2img.py system.transfer.list system.new.dat system.img.ext4
  IF EXIST system.img.ext4 goto conv_rt

:standlone 
  echo.
  echo.
  echo  Python is not installed 
  echo.
  bin\sdat2img.exe system.transfer.list system.new.dat file_contexts
  IF EXIST system.img.ext4 goto conv_rt
  
:conv_rt
echo converting "system.img.ext4" to "system"
if not exist system.img.ext4 goto datstop
REN system.img.ext4 *.img 
bin\Imgextractor.exe system.img.img -i
del system.img.img
del system.new.dat
del system.transfer.list
::MOVE system_ system
echo.
echo.
bin\cecho Files are found in {0a}"system_"{#}
echo.
pause
goto home
                                                              
:://///////                           End of extraction          /////////

:://///////////                    Repack Script          ////////////
:repack
cls
  echo.
  echo.
  echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  echo   ::                                                                  ::
  bin\cecho   :: {0c}Warning{#} This is only for advance users it may or may not work    ::
  echo.
  echo   ::                                                                  ::
  echo   :: If you are a newbie then I strongly recommend you to flash       :: 
  echo   ::                                                                  ::
  echo   :: system folder through updater-script instead of system.new.dat   ::
  echo   ::                                                                  ::
  echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  echo.
  echo.
  echo.
::bin\cecho     1 - {0b}Manually{#} (Enter size in bytes)
  echo.
  echo.
  bin\cecho     2 - {0b}Automatically{#} (Takes lots of time)
  echo.
  echo.
  set /p web2=Type option: 
  ::if "%web2%"=="1" goto man_
if "%web2%"=="2" goto auto_
goto repack


:man
Echo under construction

:auto_
cls
  echo.
  echo.
if not exist system md system
   echo.
   cls
   echo.
   echo  ///////////////////////////////////////////////////////////////////////////
   echo  /                                                                        /
   bin\cecho  /{0c}* (Warning READ CAREFULLY){#}                                              /
   echo.
   echo  /                                                                        /
   echo  /  Copy all your sub folders/files (like /app,/bin,/lib build.prop etc.) / 
   echo  /                                                                        /
   bin\cecho  /  to {0a}"system"{#} folder and delete all previously extracted files from     / 
   echo.
   echo  /                                                                        /
   echo  /  current folder and press enter                                        /
   echo  /                                                                        /
   echo  //////////////////////////////////////////////////////////////////////////
   echo.
   echo.
   echo. 
   pause
   cls
   if not exist system\app goto stop_cyanogenmod
   if not exist file_contexts goto file_c
   echo.
   echo.
   echo.
if exist system\app echo        Found System FOLDER
   echo.
if exist file_contexts echo        Found file_contexts
   echo.
   echo Looping Starts
::524288000(bytes)=500MB
   set /A cm_sixe=524288000
   goto cm_calculate

:file_c
cls
  echo.
  echo.
  echo.
  echo.
  echo.
  bin\cecho   {0c}"file_contexts" not found please copy it too current{#}
  echo.
  echo.
  bin\cecho   {0c}directory{#}, Thanks for your cooperation
  echo.
  echo.
  echo.
  pause
  goto done_1


:cm_calculate
echo.
  set /A cm_sixe+=1048576
  bin\make_ext4fs -T 0 -S file_contexts -l %cm_sixe% -a system system.img system >> bin\log_size.txt
cls
  echo.
  echo    Calculating Size Please Wait....
  echo    size %cm_sixe% (increament By 1048576(bytes)=1Mb(Megabytes))
  echo. 
  bin\cecho    {0f}If this goes on forever than QUIT this and{#}
  echo.
  echo.  
  bin\cecho    {0f}PLEASE only copy file_contexts of your ROM{#}
  echo.
  echo.
  if not exist system.img goto cm_calculate
  if exist system.img goto cm_next


:cm_next
echo.
  echo  Size required in system Partition is %cm_sixe% bytes
  echo.
  echo It will take some time aproxx 1-2 minutes
  echo.
  bin\rimg2sdat system.img system.new.dat system.transfer.list
  del system.img
  if not exist system.new.dat goto stop8
  if not exist system.transfer.list goto stop8
  echo.
  cls
  echo.
  echo.
  bin\cecho    {0a}Sha1_check{#} valus of system.new.dat
  echo.
  echo.
  bin\fciv -sha1 system.new.dat
  echo.
  echo.
  bin\cecho  Also saved in current folder by name {0a}"sha1_system.txt"{#}
  echo.
  bin\fciv -sha1 system.new.dat >> sha1_system.txt
  echo.
  echo.
  echo  system.new.dat and system.transfer.list is created 
Echo.
  Echo   from here head on to the guide
  echo.
  echo.
  del file_contexts
  pause
goto home


:stop_cyanogenmod
cls
echo.
echo.
echo //////////////////////////////////////////////////////////////////
echo.
echo   You have to copy your folders that is /app ,/bin ,/lib 
echo.
echo   build.prop to system folder not to copy system folder
echo.
echo   to system folder of current directory ,hope you got it
echo.
echo   confusing ohh c'mon just copy sub folders of your rom 
echo.
echo   to system folder also copy file_contexts to current directory   
echo. 
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
set /p opt= Continue (y/n) : 
IF "%opt%"=="y" goto cm_pack
IF "%opt%"=="n" goto home
pause
goto cm_pack
:::::::::::END////////////

::///////        IMAGE UNPACK.  ////////
:Image_unpack
cls
echo.
echo.
echo.
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                                        ::
bin\cecho ::  Copy {0a}system.img{#} to current folder and make sure it is :: 
echo.
bin\cecho ::  named as {0a}system.img{#} no other name is allowed          ::
echo.
echo ::                                                        ::
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
pause
echo.
if exist system.img echo     Found system.img
if not exist system.img goto stop2
echo.
echo  wait aproxx 2-3 minutes
echo.
bin\Imgextractor.exe system.img -i
::del system.img
echo.
Echo.
Echo.
Echo      Files are found in system_ folder
Echo.
pause
goto home
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                               END OF SCRIPT - IMAGE                                       ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::










:sign

Cls
if not exist sign_files mkdir sign_files
echo.
echo.
bin\cecho   {0f}////////////  Sign ZIP files  \\\\\\\\\\\\{#}
echo.
echo.
echo.
echo.
echo //////////////////////////////////////////////////////////
echo /                                                        /
bin\cecho / Place your zip file in the {0a}"sign_files"{#} folder         /
echo.
echo / and make sure your zip file does not contain any space /
echo /                                                        /
echo //////////////////////////////////////////////////////////
echo.
echo.
set /p tper=  Continue (y/n)? (default: y):
if "%tper%"=="Y" goto _HSX
if "%tper%"=="y" goto _HSX
if "%tper%"=="n" goto home
if "%tper%"=="N" goto home
goto _HSX

:_HSX
cls
echo.
echo.
if exist sign_files\*.zip bin\cecho          {0f}Found ZIP file{#}
if not exist sign_files\*.zip goto no_ZIP
::
::Script to determine zip file
::
setlocal EnableDelayedExpansion
FOR %%F IN (*.zip) DO (
 set filename=%%F
 goto tests
)


:tests
echo %date% >> bin\log_size.txt
echo "%filename%" >> bin\log_size.txt
echo.
echo.
echo    Name of zip file is %filename%
echo.
echo.
echo.
set /p oop= Type option (y/n)? (default: y): 
if "%oop%"=="y" goto nextsign
if "%oop%"=="Y" goto nextsign
if "%oop%"=="N" goto newname
if "%oop%"=="n" goto newname
goto nextsign

:nextsign
cls
  echo.
  echo.
  echo     Signing %filename%.......

  copy bin\signapk.jar sign_files
  copy bin\testkey.x509.pem sign_files 
  copy bin\testkey.pk8 sign_files

  cd sign_files

java -jar signapk.jar testkey.x509.pem testkey.pk8 %filename% signed_%filename%.zip 
  del signapk.jar
  del testkey.x509.pem
  del testkey.pk8
pause
cd ..
if not exist sign_files\*.zip goto stop01
if exist sign_files\signed_%filename%.zip mkdir Signed
move sign_files\signed_%filename%.zip Signed\
if exist sign_files RD /S /Q sign_files
cls
echo.
echo.
if not exist Signed\*.zip goto stop01
if exist Signed\signed_%filename%.zip bin\cecho            {0f}DONE{#}
echo.
echo.
bin\cecho    Current Name is {0a}signed_%filename%{#}
echo.
echo. 
echo    and found under Signed Folder
echo.
echo.
pause
goto home

:newname
cls
echo.
echo.
echo.
set /p filename=Type name without spaces (also include .zip) : 
goto nextsign

:no_ZIP
cls
echo.
echo.
bin\cecho       {0c}NO ZIP FILE FOUND{#}
echo.
echo.
set /p tper=Do you want to continue (y/n)? (default: y): 
if "%tper%"=="n" goto home
if "%tper%"=="n" goto home
cls
echo.
echo.
bin\cecho  {0a}cleaning old files....{#}
if not exist sign_files\*.zip RD /S /Q sign_files >> bin\log_size.txt
if not exist Signed\*.zip RD /S /Q Signed >> bin\log_size.txt
ping -n 2 -w 200 127.0.0.1 > nul
goto sign

:remove4
cls
echo.
echo.
bin\cecho  {0a}cleaning old files....{#}
echo.
RD /S /Q sign_files
ping -n 2 -w 200 127.0.0.1 > nul
goto sign

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                         END OF SIGN SCRIPT                                         ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:admin_
>>nul 2>>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM -->> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator privileges...
    goto PERM
) else ( goto start )
:PERM
    echo Set UAC = CreateObject^("Shell.Application"^) >> "%temp%\admin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\admin.vbs"

    "%temp%\admin.vbs"
    del "%temp%\admin.vbs"
    exit /B

:start
SET count=1 
 FOR %%G IN (.,..,...) DO (
 ping -n 2 -w 200 127.0.0.1 > nul
 echo %count%
 cls
 echo.
 echo.
 echo.
 bin\cecho     {0f}Welcome To{#} {0a}matrix's{#} {0f}System Extract and Repack{#}
 echo.
 echo.
 bin\cecho     {0f}loading{#} {0a}%%G{#}
 echo.
 set /a count+=1 )
 goto check
 
:check
::Section for checking recent activity
if not exist %temp% goto home
if exist %temp%\date_log.txt goto _recent
set activity="First time use"
echo %date% >> %temp%\date_log.txt
set recent=
goto home

:_recent
if exist %temp%\date_log.txt (
set /p recent=<%temp%\date_log.txt
)
del %temp%\date_log.txt
set activity=Last-opened:
echo %date% >> %temp%\date_log.txt
goto home

::
::System FOLDER stop
::
:stop1
cls
echo.
echo.
echo.
echo     ///////////////////////////////////////////////////////
echo.
echo      It seems that the you have not copied sub folder 
bin\cecho      like /app,/bin,/lib build.prop etc. to {0c}"system"{#}
echo. 
echo      folder present in current directry please follow 
echo      Instructions carefully and also read help section
echo.
echo     \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
cls
echo.
echo.
bin\cecho  {0a}Cleaning old files....{#}
ping -n 2 -w 200 127.0.0.1 > nul
RD /S /Q system
goto home

:stop2
cls
echo.
echo     ////////////////////////////////////////////////////////////
echo.
bin\cecho       {0f}"system.img"{#} is not found in current folder Please copy
echo. 
bin\cecho       {0f}system.img{#} to current folder or rename your system image 
echo.
bin\cecho       file to {0f}system.img{#}
echo.
echo.
echo     \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
goto home

:stop3
cls
echo.
echo      ////////////////////////////////////////////////////////////////
echo.
echo        Something is missing from current folder please copy
bin\cecho        {0c}"system.new.dat"{#} , {0c}"system.transfer.list"{#} and {0c}"file_contexts"{#}
echo.
echo        to CURRENT FOLDER  see help
echo.
echo      \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
goto home

:stop5
cls
echo.
bin\cecho    {0a}"system.new.dat"{#} is not found
echo.
echo    Please copy system.new.dat to current folder
echo.
pause
goto home

:stop6
cls
echo.
bin\cecho    {0a}"system.transfer.list"{#} is not found
echo.
echo     Please copy system.transfer.list to current folder
echo.
pause
goto home

:stop7
cls
echo.
bin\cecho    {0a}"file_contexts"{#} is not found
echo.
echo     Please copy file_contexts to current folder
echo.
echo     Trouble in getting file_contexts
echo.
echo     Extract boot.img/Ramdisk/file_contexts
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

:sizr
cls
echo.
echo.
echo ///////////////////////////////////////////////////////////
echo /                                                         /
echo /   Please enter size correctly or add more size that is  /
echo /   more MB in current size                               /
echo /                                                         /
echo ///////////////////////////////////////////////////////////
echo.
echo.
pause
goto cmatrix

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
echo  There is no system folder found!
echo  this implies that this extractor 
echo  not worked with your .DAT files
echo.
pause
goto home

:datstop
echo.
echo.
echo  There is no system.img.ext4  found!
echo  this implies that this extractor 
echo  not worked with your .DAT files
echo  Please contact me , matrix
echo  and if possible please proide a
echo  file that contains following info.
echo  1. dat file size
echo  2. screenshot(use wordpad, can store images)
echo  3. mark and copy info on cmd extractor.
echo.
echo  Thanks 
echo  Regards -matrix
echo.
pause
goto home

::
::ZIP FILE STOP
::
:stop01
cls
echo.
echo.
echo  ////////////////////////////////////////////
echo  /                                          /
echo  /    Not worked with your zip file please  /
echo  /    use a simple name like                /
echo  /    Eg. something_maker.zip               /
echo  /                                          /
echo  ////////////////////////////////////////////
echo.
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
bin\cecho              {80}THANKS{#} {20}FOR{#} {40}USING{#}
ping -n 2 -w 200 127.0.0.1 > nul
if not exist sign_files\*.zip RD /S /Q sign_files
if not exist Signed\*.zip RD /S /Q Signed
del bin\log\log_size.txt
IF EXIST system__statfile.txt del system__statfile.txt
IF NOT EXIST Repack_INFO.txt (
                              copy bin\Repack_INFO.txt  dirr
                              ren dirr Repack_INFO.txt
							  )
cls
exit
