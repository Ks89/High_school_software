@echo off
SET THEFILE=f:\kssoft~1\source\7emezzo\7mezzo.exe
echo Linking %THEFILE%
d:\progra~1\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o f:\kssoft~1\source\7emezzo\7mezzo.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
