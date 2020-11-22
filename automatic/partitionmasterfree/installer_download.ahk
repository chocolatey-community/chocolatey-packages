#SingleInstance, force
Run %1%
WinWait, EPM_Installer
Sleep 5
WinActivate,
MouseClick,,400,360
Sleep 2
MouseClick,,650,450
