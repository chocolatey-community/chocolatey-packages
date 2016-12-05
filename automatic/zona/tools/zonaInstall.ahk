#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode, 2

WinWait, Installing Zona, Start Zona when Wind
IfWinNotActive, Installing Zona, Start Zona when Wind, WinActivate, Installing Zona, Start Zona when Wind
WinWaitActive, Installing Zona, Start Zona when Wind
MouseClick, left,  26,  138
Sleep, 100
MouseClick, left,  29,  159
Sleep, 100
MouseClick, left,  23,  206
Sleep, 100
MouseClick, left,  454,  416
Sleep, 100
MouseClick, left,  454,  416
Sleep, 100
