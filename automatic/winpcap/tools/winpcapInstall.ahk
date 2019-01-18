#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, RegEx

if (%0% < 2) {
	FileAppend, "Too few arguments given", *
	exit
}

operation = %1%
file = %2%

Run, %file%
if (operation = "uninstall")
{
	WinWait, WinPcap [\d\.]+ Uninstall,, 30
	IfWinExist
	{
		BlockInput, On
		Sleep, 250
		WinActivate
		Send, {Enter}
		BlockInput, Off
	}

	WinWait, WinPcap [\d\.]+ Uninstall, has been uninstalled, 30
		IfWinExist
		{
			BlockInput, On
			Sleep, 250
			WinActivate
			Send, {Enter}
			BlockInput, Off
		}
    exit
} else if (operation = "install") {
	WinWait, WinPcap [\d\.]+ Setup,, 30

	Loop, 3
	{
		gosub, setupForward
	}

	WinWait, WinPcap [\d\.]+ Setup, has been installed, 30
		IfWinExist
		{
			BlockInput, On
			Sleep, 250
			WinActivate
			Send, {Enter}
			BlockInput, Off
		}

	ExitApp

	setupForward:
		IfWinExist
		{
			BlockInput, On
			Sleep, 250
			WinActivate
			Send, {Enter}
			BlockInput, Off
		}
	return
} else {
	FileAppend, "Unsupported operation", *
	exit
}