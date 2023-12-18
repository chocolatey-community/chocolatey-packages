SetTitleMatchMode "RegEx"
exe_re := "tixati-.+install.exe"

If WinWait("ahk_exe " exe_re, , 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

If WinWait("ahk_exe " exe_re, "YES`, continue installation", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

If WinWait("ahk_exe " exe_re, "Install", 20)
   ControlSend "{ENTER}",, "ahk_exe " exe_re
Else
   exit 1

if WinWait("ahk_exe " exe_re, "Installation is complete!", 20)
{
   WinActivate
   Send "{TAB}{ENTER}"
}
Else
   exit 1
