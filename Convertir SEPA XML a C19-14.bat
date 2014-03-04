@echo off
for %%f in (C:\Remesas\disco\*.xml) do (
	echo Convirtiendo fichero SEPA XML %%f a C19-14 %%~dpf%%~nf.dat
	XSLTransform "%%f" "%~dp0SEPA-C19-14.xsl" "%%~dpf%%~nf.dat"
)
echo Proceso finalizado!
pause
