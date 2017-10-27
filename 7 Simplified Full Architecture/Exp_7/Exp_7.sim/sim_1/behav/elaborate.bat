@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 10d62736f9fc446cb036b7821d40cd07 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_RAT_wrapper_behav xil_defaultlib.tb_RAT_wrapper -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
