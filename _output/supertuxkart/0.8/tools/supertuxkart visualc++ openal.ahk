#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWait, Microsoft Visual C++ 2005 Redistributable Package (x86)
	WinActivate
Send, {AltDown}y{AltUp}

WinWait, OpenAL Installer
	WinActivate
; Auf ClassNN: Button2 klicken lassen, Text: OK
; Alternativ folgende position klicken (relativ zu fenster): 540, 375

WinWait, OpenAL Installer Message
	WinActivate
; Auf ClassNN: Button1 klicken lassen, Text: OK, oder Send, {Enter}

WinWaitClose, OpenAL Installer Message
	ExitApp