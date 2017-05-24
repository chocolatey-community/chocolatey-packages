Run, %1%
WinWait, Light Alloy installer
WinActivate

ControlSend,, {Enter}
ControlSend, TCheckBox1, {Space}
ControlSend,, {Enter}

WinWait, Basic options,,10
ifEqual, ErrorLevel, 0 
{ 
    WinActivate
    ControlSend,TButton1, {Space}
}

WinWait, ahk_class LightAlloyFront
WinClose