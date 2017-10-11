@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 6d3a8af0e14d4318a02fd7fdbe5bacf2 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Lab_5_Main_behav xil_defaultlib.Lab_5_Main -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
