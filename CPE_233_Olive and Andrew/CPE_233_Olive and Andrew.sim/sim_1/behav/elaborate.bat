@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.1\\bin
call %xv_path%/xelab  -wto c138533ffcaa46b0a7ea7a066f3a3f3c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Counter_4Bit_behav xil_defaultlib.Counter_4Bit -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
