#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1   ;begins
DetectHiddenText, off
DetectHiddenWindows, off

winTitle = CDex Setup ahk_class #32770
winTitleDonate = Donations | CDex

WinWait, %winTitle%, Thank You for using CDex, 120
ControlClick, Button1, %winTitle%

WinWait, %winTitleDonate%, , 10
WinActivate
Send ^w

ExitApp