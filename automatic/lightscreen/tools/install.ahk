#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%

WinActivate, Options - Lightscreen
Send, {Enter}
Sleep, 150
WinWait, Lightscreen
WinClose
