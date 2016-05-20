 {0f}Marshmallow system extractor{#}
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
bin\cecho       4 - {0b}Repack{#} {0f}system to system.img{#}
echo.
echo.
bin\cecho       5 - {0b}Sign{#} {0f}ZIP files{#}
echo.
echo.
bin\cecho       6 - {0b}Exit{#}  
echo.
echo.
set /p web=Type option:
if "%web%"=="1" goto extractor
if "%web%"=="6" goto ex_t
if "%web%"=="4" goto Image_repack
if "%web%"=="2" goto repack
if "%web%"=="3" goto Image_unpack
if "%web%"=="5" goto sign
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
if exist system.new.dat echo found system.new.dat
if exist system.transfer.list echo found system.transfer.list
if exist file_contexts echo found file_contexts
echo.
echo.
pause
echo converting "system.new.dat" to "system.img.ext4"
echo.
::
::(C)Xpirit's sdat2img.exe binary
::
bin\sdat2img.exe system.transfer.list system.new.dat file_contexts
echo.
echo converting "system.img.ext4" to "system"
if not exist system.img.ext4 goto datstop
REN system.img.ext4 *.img 
bin\Imgextractor.exe system.img.img -i
del system.img.img
del system.new.dat
del system.transfer.list
del file_contexts
if exist system RD /S /Q system
MOVE system_ system
echo.
echo.
bin\cecho Done. Go to the folder {0a}"system"{#}
echo.
pause
goto home

::                                                                                   ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                             End of script                                         ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                             Repack Script                                         ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                                   ::
::LOC=LOCATION

:repack
cls
echo.
echo.
echo   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo   ::                                                               ::
bin\cecho   :: {0c}Warning{#} This is only for advance users it may or may not work ::
echo.
echo   :: If you are a newbie then I strongly recommend you to flash    :: 
echo   :: system through updater-script instead of system.new.dat       ::
echo   ::                                                               ::
echo   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
set /p web2= :Are you sure you want to continue (y/n)? (default: y):
if "%web2%"=="y" goto option_repack
if "%web2%"=="n" goto home
if "%web2%"=="Y" goto option_repack
if "%web2%"=="N" goto home  
::Default set
goto option_repack



::LOC=repack\option_repack
:option_repack
cls
echo.
echo.
echo.
bin\cecho     1 - {0b}Normal repack{#} ( {0f}without file_contexts{#} )
echo.
echo.
bin\cecho     2 - {0b}Cyanogenmod Repack{#} ( {0f}file_contexts is required{#} )
echo.
echo.
echo.
set /p web2=Type option: 
if "%web2%"=="1" goto normal_RP
if "%web2%"=="2" goto cyanogenmod
goto option_repack

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::               CYANOGENMOD REPACK SCRIPT (C)MATRIX                                    ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::LOC=repack\option_repack\cyanogenmod
:cyanogenmod
cls 
echo.
echo  //////////////////////////////////////////////////////////////
echo  /                                                            /
echo  /  Repack will be bit more challanging so read carefully or  /
echo  /  YOU WILL ALWAYS GET A BOOTLOOP or "OTA not verified"      /
echo  /                                                            /
echo  /  Understand what updater-script of cyanogenmod contains    /
echo  /                                                            /
echo  /  It contains a sha1_check which is use to verify OTA's     /
echo  /  if sah1_check != sha1 value of system.new.dat             /
echo  /      "OTA has some unexpected contects"                    /
echo  /   READ MORE at repack_INFO.txt file                        /
echo  /             Let's continue                                 /
echo  /                                                            /
echo  //////////////////////////////////////////////////////////////                               
echo.
echo.
set /p web=Type option (y/n):
if "%web%"=="y" goto repack_2
if "%web%"=="Y" goto repack_2
if "%web%"=="n" goto home
if "%web%"=="N" goto home 
goto cyanogenmod

::LOC=repack\option_repack\cyanogenmod\repack_2
:repack_2
cls
if not exist system md system >> bin\log\log_size.txt
if exist system\app (
rd /s /q system
md system
bin\cecho  {0a}Cleaning folder before began....{#}
echo.
sleep 2
)
goto all_done

:all_done
cls
echo.
echo.
echo.
echo _______________________________________________________________________________
echo.
echo      Move all your sub folders/files (like /app,/bin,/lib build.prop etc.) 
echo.
bin\cecho      to {0a}"system"{#} folder found is current directory 
echo.
echo.
bin\cecho      also copy {0a}"file_contexts"{#} to current directory
echo.
echo _______________________________________________________________________________
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
echo  file_contexts not found please copy it too current
echo.
echo  directory, Thanks for your cooperation
echo.
pause
goto all_done

::LOC=repack\option_repack\cyanogenmod\repack_2\cm_calculate
:cm_calculate
echo.
set /A cm_sixe+=1048576
::1048576(bytes)=1Mb(Megabytes)
::
::make_ext4fs is very useful binary I respectfully thanks to that person who made it
::
bin\make_ext4fs -T 0 -S file_contexts -l %cm_sixe% -a system system.img system >> bin\log\log_cm_size.txt
cls
echo.
echo    Calculating Size Please Wait....
echo    size %cm_sixe% (increament By 1048576(bytes)=1Mb(Megabytes))
echo.
if not exist system.img goto cm_calculate
if exist system.img goto cm_next

::LOC=repack\option_repack\cyanogenmod\repack_2\cm_next
:cm_next
echo.
echo  Size required in system Partition is %cm_sixe% bytes
echo.
echo It will take some time aproxx 1-2 minutes
echo.
::
::Converting image to system.new.dat
::
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
bin\cecho DONE {0a}"system.transfer.list"{#} and {0a}"system.new.dat"{#} created in current folder
echo.
bin\cecho just copy it(both) to your ROM also keep {0a}"sha1_system.txt"{#} and follow my guide
echo.
echo.
del file_contexts
pause
goto home

::LOC=repack\option_repack\cyanogenmod\repack_2\stop_cyanogenmod
:stop_cyanogenmod
cls
echo.
