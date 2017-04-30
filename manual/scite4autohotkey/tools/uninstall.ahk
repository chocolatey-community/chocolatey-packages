#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

loop, 3
{
  WinWait, SciTE4AutoHotkey Setup,, 30
  ControlClick, Button1, SciTE4AutoHotkey Setup
  Sleep, 100
}
