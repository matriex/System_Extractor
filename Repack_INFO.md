# Guide for repack   
 
_Read this only in github for better view,_
_Repack "may or may not" work with all ROM_
_This guide is not for official or Stock ROM_ 
_and I don't think I will be able to provide any repack GUIDE for NOUGHT(or try below method if it works)_

## INFORMATION 

  _If you are using cyanogenmod ROM , you may found something in updateR-script, That is **"if range_sha1(........."** this executs in script after extraction of system.new.dat to **"system partition"** , which verifies **SAH-1** values of system.new.dat, if values are same, the scripts succeeds and the flashing completes , if not then the script returns 
   **"abort("system partition has unexpected non-zero contents after OTA update");"**
  This problem can be solved by changing the old values of system.new.dat with current one and here is how to do it._

**NOTE**
* **"if range_sha1(........."**  _a line found in updateR-script of android 6.x ROM's_
* **SHA-1** (Secure Hash Algorithm **1**)
* **system partition** _partition where your OTA flashes files_
* **If your updateR-script do not contain above lines then don't follow this guide, simply just replace your old files with recently created ones (old-files=system.new.dat, system.transfer.list)** 

## Download these for further need

  * Extractor.bat

  * ROM (with file_contexts, or it will be useless)

  * For nought try to convert file_contexts.bin(binary file) to file_contexts(readable file), for conversion tool search xda

  * ZIP sign - already included in extractor
  
## Instructions

Sample of "updateR-script" of cyanogenmod ROM (**INITIAL**)
(Note: Removed some lines of script)

```
if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "36,0,32770,32849,32851,33331,65535,65536,65538,98304,98306,98385,98387,98867,131071,131072,131074,163840,163842,163921,163923,164403,185342,196608,196610,229376,229378,229457,229459,262144,262146,294912,294914,294993,294995,295475,307199") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then

if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "48,32770,32849,32851,33331,65535,65536,65538,66050,97792,98304,98306,98385,98387,98867,131071,131072,131074,131586,163328,163840,163842,163921,163923,164403,185342,185854,196096,196608,196610,197122,228864,229376,229378,229457,229459,229971,261632,262144,262146,262658,294400,294912,294914,294993,294995,295475,307199,307200") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then

ui_print("Verified the updated system image.");


else
   abort("system partition has unexpected non-zero contents after OTA update");
endif;
```
* As you can see there is "if range_sha1" on the script, see below example-
```
 
if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "36,0,32770,32849,32851,33331,65535,65536,65538,98304,98306,98385,98387,98867,131071,131072,131074,163840,163842,163921,163923,164403,185342,196608,196610,229376,229378,229457,229459,262144,262146,294912,294914,294993,294995,295475,307199") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then

if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "48,32770,32849,32851,33331,65535,65536,65538,66050,97792,98304,98306,98385,98387,98867,131071,131072,131074,131586,163328,163840,163842,163921,163923,164403,185342,185854,196096,196608,196610,197122,228864,229376,229378,229457,229459,229971,261632,262144,262146,262658,294400,294912,294914,294993,294995,295475,307199,307200") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then
```

* After **.../by-name/system"**, This line(from **"36,.....to 307199"**) was also found in system.trasfer.list of the same ROM
```  
  "36,0,32770,32849,32851..........294995,295475,307199") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then
  
  "48,32770,32849,32851,..........,295475,307199,307200") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then
```     
* Also line
  ```
  "0b20303394271424267e36a0ce7573f1b62ddc0d" 
  ``` 
  is equal to **SHA-1 value**  of system.new.dat and 
  ```
  "16902dcea1b74f8c9451cb2245c51465d949ec7e"
  ```
  is also equal to **SAH-1 value** of "same" **system.new.dat**
  
  (**SHA-1 value or Secure Hash Algorithm 1 value**)
  
 * Frome above there are two different values of **SHA-1** of same file and two different **SHA-1** value of a **"single"** file is not possible or I don't know. So either these two values might of different things(files/or maybe numbers).
 

* In system.transfer.list of CM13 ROM, It contains -
```
3
130069
0
0
new 36,0,32770,32849,32851,33331,65535,65536,65538,98304,98306,98385,98387,98867,131071,131072,131074,163840,163842,163921,163923,164403,185544,196608,196610,229376,229378,229457,229459,262144,262146,294912,294914,294993,294995,295475,307199
zero 48,32770,32849,32851,33331,65535,65536,65538,66050,97792,98304,98306,98385,98387,98867,131071,131072,131074,131586,163328,163840,163842,163921,163923,164403,185544,186056,196096,196608,196610,197122,228864,229376,229378,229457,229459,229971,261632,262144,262146,262658,294400,294912,294914,294993,294995,295475,307199,307200
erase 12,66050,97792,131586,163328,186056,196096,197122,228864,229971,261632,262658,294400
```

* You can see here command 
```      
	new 36,0,32770,32849,32851.........to the end  
	  
	zero 48,32770,32849,32851,.........to the end  
```	  
	matches range_sha1 of updater-script --------->  ```"36,0,32770,32849,32851,........294995,295475,307199") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then
	
    matches range_sha1 of updater-script --------->  "48,32770,32849,32851,..........,295475,307199,307200") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then```

    (Hope you get it)

* So system.transfer.list and updater-script has a link of "**SAH-1**" and "**transfer**" commands
* Now change this into right, after repack you have three files 
```
   system.new.dat
   system.transfer.list
   "sha1_system.txt" which contains sha1 check of system.new.dat
   
```
* **NOTE**:- **transfer** commands means numbers beside "new" & "zero" in system.transfer.list, refer to xpirit guide
 
## Let's repack ROM
 
* First open Extractor.bat

* Choose option "**2 Repack system.new.dat**"
 
* Choose **1 (manual mode)** --> **Repack ( file_contexts is required)**
 
* Copy your sub folders for example:- addon.d, app, bin, fonts, framework, buile.prop, etc., to system folder (this message will also displayed in extractor).
   
* Then place **"file_contexts"** beside system folder
   
### Some info. on ROM zip 
* A "CUSTOM" ROM ZIP CONTAINS
```

*   system                (FOLDER)
   
*   META-INF              (FOLDER)
   
*   install               (FOLDER)
   
*   system.transfer.list  (FILE)
   
*   system.patch.dat      (FILE)
   
*   system.new.dat        (FILE)
   
*   file_contexts         (FILE)
   
*   boot.img              (FILE)
   
```
_(In Stock ROM, may be another files are present)_

   **(FOR MARSHMALLOW AN LOLLIPOP)**  If you unable to find it (file_contexts) in zip file then extract ramdisk from boot.img
   and look for "file_contexts" inside ramdisk folder (search xda  for methods) _or_ try to explore your **ROM/device_source**

   _IMP : Do not use other "file_contexts" or dummy "file_contexts" , it can cause device to loop_ 
 
* Hit enter if you have done above 
 
* The extractor creates three files as output :-
 ```  
   system.new.dat
   system.transfer.list
   sha1_system.txt      -->  A new fresh **SHA-1** value of system.new.dat
 ```
 * Now copy system.new.dat & system.transfer.list to ROM folder
 
 * Open system.transfer.list :-
 
### In my case it (system.transfer.list) looks like this
```

1
124680
erase 2,0,129024
new 76,0,32,33,164,539,692,696,13549,13550,14263,14264,14313,14314,14374,14375,14507,14520,14522,14527,14657,14670,14672,14677,14805,14818,14820,14825,16941,16942,32767,32768,32770,32801,32802,33307,36711,36714,42767,42774,42988,42989,50105,50107,50114,50120,50141,50142,50143,50162,52431,52432,55597,55600,65535,65536,65537,66042,89668,89674,93810,93811,97042,97043,97070,97122,98100,98304,98306,98337,98338,98843,98844,100859,128209,128212,129023
```

* This is totally different from old system.transfer.list (FOUND ON START OF THIS GUIDE)
 
* On comparing there is no "zero" command

* Now copy line new --> **"76,0,32,33,............,128212,129023"** from system.transfer.list to updater-script (see below)
 
 * Part of updater-script where  range_sha1 exists
 ```

if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "76,0,32,33,164,539,692,696,13549,13550,14263,14264,14313,14314,14374,14375,14507,14520,14522,14527,14657,14670,14672,14677,14805,14818,14820,14825,16941,16942,32767,32768,32770,32801,32802,33307,36711,36714,42767,42774,42988,42989,50105,50107,50114,50120,50141,50142,50143,50162,52431,52432,55597,55600,65535,65536,65537,66042,89668,89674,93810,93811,97042,97043,97070,97122,98100,98304,98306,98337,98338,98843,98844,100859,128209,128212,129023") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then

if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "76,0,32,33,164,539,692,696,13549,13550,14263,14264,14313,14314,14374,14375,14507,14520,14522,14527,14657,14670,14672,14677,14805,14818,14820,14825,16941,16942,32767,32768,32770,32801,32802,33307,36711,36714,42767,42774,42988,42989,50105,50107,50114,50120,50141,50142,50143,50162,52431,52432,55597,55600,65535,65536,65537,66042,89668,89674,93810,93811,97042,97043,97070,97122,98100,98304,98306,98337,98338,98843,98844,100859,128209,128212,129023") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then

```


* **As you can see above what I have done. I've replaced transfer commands in** 
 
``` if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", ```"**REPLACED COMMANDS/paste above coiped lines**"```) == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then```

_Please just replace your system.new.transfer list "new" values with updateR-script "if range_sha1" values_
 
* **Now just look at this**
```
........,129023") == "0b20303394271424267e36a0ce7573f1b62ddc0d" then

........,129023") == "16902dcea1b74f8c9451cb2245c51465d949ec7e" then 

```

* There are **two different SHA-1 values**  (ofc sha1_sums == 0b20303394271424267e36a0ce7573f1b62ddc0d and 16902dcea1b74f8c9451cb2245c51465d949ec7e) **"Here we are talking about unmodified updateR-script"**
   
 **1st-->  0b20303394271424267e36a0ce7573f1b62ddc0d**
   
 **2nd-->  16902dcea1b74f8c9451cb2245c51465d949ec7e**
 
* Now just open **"sha1_system.txt"** that was generated recently by extractor, inside it you will find something like this
``` 

//
// File Checksum Integrity Verifier version 2.05.
//
bdd6a7e1352232b97db4286cc21fdc8ea91d40f7 system.new.dat

```
* Replace this value **bdd6a7e1352232b97db4286cc21fdc8ea91d40f7** with old **"SHA-1"** values, 

* example/like this :
```
........,129023") == "bdd6a7e1352232b97db4286cc21fdc8ea91d40f7" then

........,129023") == "bdd6a7e1352232b97db4286cc21fdc8ea91d40f7" then 

```

_Both of line must be assigned same SHA-1 value_

* **After above, updater-script script will somewhat looks like this** :-
 (**FINAL**)
 
```
if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "76,0,32,33,164,539,692,696,13549,13550,14263,14264,14313,14314,14374,14375,14507,14520,14522,14527,14657,14670,14672,14677,14805,14818,14820,14825,16941,16942,32767,32768,32770,32801,32802,33307,36711,36714,42767,42774,42988,42989,50105,50107,50114,50120,50141,50142,50143,50162,52431,52432,55597,55600,65535,65536,65537,66042,89668,89674,93810,93811,97042,97043,97070,97122,98100,98304,98306,98337,98338,98843,98844,100859,128209,128212,129023") == "bdd6a7e1352232b97db4286cc21fdc8ea91d40f7" then

if range_sha1("/dev/block/platform/msm_sdcc.1/by-name/system", "76,0,32,33,164,539,692,696,13549,13550,14263,14264,14313,14314,14374,14375,14507,14520,14522,14527,14657,14670,14672,14677,14805,14818,14820,14825,16941,16942,32767,32768,32770,32801,32802,33307,36711,36714,42767,42774,42988,42989,50105,50107,50114,50120,50141,50142,50143,50162,52431,52432,55597,55600,65535,65536,65537,66042,89668,89674,93810,93811,97042,97043,97070,97122,98100,98304,98306,98337,98338,98843,98844,100859,128209,128212,129023") == "bdd6a7e1352232b97db4286cc21fdc8ea91d40f7" then

ui_print("Verified the updated system image.");


else
  abort("system partition has unexpected non-zero contents after OTA update");
endif;


else
  abort("system partition has unexpected contents after OTA update");
endif;
```

* **You can clearley point out difference between _INITIAL_ updater-script(see start of guide) and _FINAL_ upater-script (above)**

* The both "range_sha1" line in **INITIAL updateR-script** and **FINAL updateR-script** differs

* Also in final script both the "**SHA-1**" value become equals to each other and their transfer commands values too
 (refer to xpirit guide for transfer commands)

* That's all save updateR-script, repack ROM to ZIP (Use Winrar) and sign xyz_ROM.zip (optional) for official Recovery , for TWRP do not sign the file, disable zip signing from settings of TWRP

* Then flash it, and try to wait for 5 minutes to boot (be patience), if works then good to go else retry or :(

**I hope though you got it , comment if you need help, or confused in this**

## NOTE  
_Please Ignore the grammer or Typos as English is not my native Language!_

**_And yes if you think this method is useless then please don't use it , don't comment , I have tried my best to write this guide for 
noobs to understand how to edit updater-script._**  -PEACE, matrixex 
