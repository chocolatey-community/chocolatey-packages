#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%

WinActivate, Options - Lightscreen
ControlSend, WinTitle, {Enter}
Sleep, 150
WinWait, Lightscreen
WinClose
