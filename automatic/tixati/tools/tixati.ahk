SetTitleMatchMode, RegEx
exe_re = tixati-.+install.exe

Run %1%
WinWait, ahk_exe %exe_re%,,20
IfNotEqual, ErrorLevel, 0, exit 1
ControlSend,, {ENTER}, ahk_exe %exe_re%

WinWait, ahk_exe %exe_re%, YES`, continue installation, 20
IfNotEqual, ErrorLevel, 0, exit 1
ControlSend,, {ENTER}, ahk_exe %exe_re%

WinWait, ahk_exe %exe_re%, Install, 20
IfNotEqual, ErrorLevel, 0, exit 1
ControlSend,, {ENTER}, ahk_exe %exe_re%

WinWait, ahk_exe %exe_re%, Installation is complete!, 20
IfNotEqual, ErrorLevel, 0, exit 1
WinActivate
Send, {TAB}{ENTER}
