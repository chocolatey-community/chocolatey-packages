#SingleInstance, force
Run, %1%
WinWait, Nmap Setup
Sleep, 100
ControlSend,, {Enter}
Sleep, 100
ControlSend,, {Enter}
Sleep, 100
ControlSend,, !i

loop {
    IfWinExist, Npcap 1.00 Setup, already installed
    {
        Sleep, 100
        ControlSend,, {Enter}
    }
    IfWinExist, Npcap 1.00 Setup, License Agreement
    {
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
    }
     IfWinExist, Npcap 1.00 Setup, Installation Complete
    {
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
    }

    IfWinExist, Nmap Setup, Installation Complete
    {
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
        break
    }
    IfWinExist, Nmap Setup, Microsoft Visual C++
    {
        Sleep, 100
        ControlSend,, {Enter}
    }
    Sleep 1000
}
