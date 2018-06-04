#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%

IfWinExist, Options - Lightscreen
{
    WinActivate
    Send, {Enter}
    return
}
Sleep, 150
WinWait, Lightscreen
WinClose
