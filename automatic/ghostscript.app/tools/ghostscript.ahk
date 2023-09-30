#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force
#Warn
SetTitleMatchMode "RegEx"
exe_re := "gs.+.exe"

If WinWait("ahk_exe " exe_re, "Next >", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

If WinWait("ahk_exe " exe_re, "I Agree", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

If WinWait("ahk_exe " exe_re, "Install", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

If WinWait("ahk_exe " exe_re, "Finish", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

if WinWait("ahk_exe " exe_re, "OK", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

ExitApp