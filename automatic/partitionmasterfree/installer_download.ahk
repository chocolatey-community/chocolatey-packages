#SingleInstance, force
log = %TEMP%\chocolatey\au\partitionmagicfree_updater.log
FileCreateDir, %TEMP%\chocolatey\au

FileAppend, started script`n, %log%
Run %1%
FileAppend, started %1%`n, %log%
WinWait, EPM_Installer
FileAppend, detected installer`n, %log%
Sleep 3000
WinActivate,
MouseClick,,400,360
Sleep 1000
MouseClick,,650,450
FileAppend, finished script`n, %log%