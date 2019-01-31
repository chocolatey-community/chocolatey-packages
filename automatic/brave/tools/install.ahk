#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%

Process, Close, brave.exe
Process, Wait, brave.exe, 30
Process, Close, BraveUpdate.exe
Process, Close, brave.exe
