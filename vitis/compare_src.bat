@echo off
set PATH=C:\Program Files\Beyond Compare 4;%PATH%

start bcompare src\vitis_proj\src sdk_workspace\vitis_proj\src
start bcompare elf-bootloader-master\lib\sw_apps\elf-bootloader\src sdk_workspace\fsbl\src
