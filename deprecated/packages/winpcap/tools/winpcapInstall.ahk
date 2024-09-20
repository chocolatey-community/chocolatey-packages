SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.

WinWait("WinPcap",, 30)

BlockInput "On"
Sleep 250
WinActivate
Send "{Enter}"
BlockInput "Off"

BlockInput "On"
Sleep 250
WinActivate
Send "{Enter}"
BlockInput "Off"

BlockInput "On"
Sleep 250
WinActivate
Send "{Enter}"
BlockInput "Off"

WinWait("WinPcap", "has been installed", 30)
BlockInput "On"
Sleep 250
WinActivate
Send "{Enter}"
BlockInput "Off"