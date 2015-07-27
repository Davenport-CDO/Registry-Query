@echo off
REM Gets the date and time and aligns it into a specific order for the output file.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
REM Runs code under :query and puts it output in a file. 
call :query >reg_query_%fullstamp%.txt
exit /b
:query
@ echo off
echo %Date% %Time%
REM Looks into the ControlSets section's Notifications Packages entry and displays entries.
echo ------Control Sets------
echo .
echo .
echo [Control Set 001 LSA]
reg query "HKLM\SYSTEM\ControlSet001\Control\LSA" /v "Notification Packages"
echo [Control Set 002 LSA]
reg query "HKLM\SYSTEM\ControlSet002\Control\LSA" /v "Notification Packages"
echo [Current Control Set LSA]
reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "Notification Packages"
echo Notification Packages should consist of a value containing:
echo	* scecli
echo	* RASSFM
echo	* FPNWCLNT
echo	* KDCSVC
echo .
echo .
REM Looks into the Run/RunOnce Section.
echo ------Run Locations------
echo .
echo .
echo [HKLM Run]
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /s
echo [HKLM RunOnce]
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /s
echo [HKCU Run]
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /s
echo [HKCU RunOnce]
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /s
echo .
echo .
REM Looks into the Winlogon Notify Keys
echo ------Winlogon Notify------
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify" /s
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{827D319E-6EAC-11D2-A4EA-00C04F79F83A}" /s