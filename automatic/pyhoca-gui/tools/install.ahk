#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

WinWait, Installer Language ahk_class #32770 ahk_exe PyHoca-GUI_0.5.0.4-20150125_win32-setup_x32.exe, , 60

WinActivate
IfWinActive
  ControlClick, Button1
