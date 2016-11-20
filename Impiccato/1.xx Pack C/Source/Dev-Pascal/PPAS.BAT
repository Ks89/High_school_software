@echo off
SET THEFILE=u:\kssoftware\setup\impiccato\1.xx pack c\altro\source\dev-pa~1\imp190~1.exe
echo Linking %THEFILE%
s:\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o "f:\kssoftware\setup\impiccato\1.xx pack c\altro\source\dev-pa~1\imp190~1.exe" link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
