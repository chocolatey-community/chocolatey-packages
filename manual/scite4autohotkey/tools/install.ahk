#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWait, SciTE4AutoHotkey Setup,, 30
ControlClick, x300 y200, SciTE4AutoHotkey Setup,,,NA
Sleep, 1000
ControlClick, x540 y390, SciTE4AutoHotkey Setup,,,NA
WinWait, SciTE4AutoHotkey Setup, Done, 10
IfWinActive, SciTE4AutoHotkey Setup, Done
{
	Sleep, 500
	Send, {Enter}
}
WinWait, SciTE4AutoHotkey, Welcome to SciTE4AutoHotkey, 10
IfWinActive, SciTE4AutoHotkey, Welcome to SciTE4AutoHotkey
{
	Sleep, 500
	Send, {Enter}
}
Sleep, 1000
SetTitleMatchMode, 2
WinClose, SciTE settings
WinClose, - SciTE4AutoHotkey
