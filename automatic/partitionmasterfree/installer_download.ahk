#SingleInstance, force
Run %1%
WinWait, EPM_Installer
Sleep 5000
WinActivate,
MouseClick,,400,360
Sleep 2000
MouseClick,,650,450
