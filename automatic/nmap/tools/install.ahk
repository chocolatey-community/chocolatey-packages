#SingleInstance, force
SetTitleMatchMode, RegEx

WinWait, Nmap Setup
Sleep, 100
ControlSend,, {Enter}
Sleep, 100
ControlSend,, {Enter}
Sleep, 100
ControlSend,, !i

loop {
    IfWinExist, Npcap [0-9.]+ Setup, already installed
    {
        Sleep, 100
        ControlSend,, {Enter}
    }

    IfWinExist, Npcap [0-9.]+ Setup, License Agreement
    {
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100
        ControlSend,, {Enter}
    }

    IfWinExist, Npcap [0-9.]+ Setup, Installation Complete
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

        IfWinNotExist, Nmap Setup
        {
          break
        }
    }

    IfWinExist, Nmap Setup, Finished
    {
        Sleep, 100
        ControlSend,, {Enter}
        Sleep, 100

        IfWinNotExist, Nmap Setup
        {
          break
        }
    }

    ; IfWinExist, Nmap Setup, Microsoft Visual C++
    ; {
    ;     Sleep, 100
    ;     ControlSend,, {Enter}
    ; }

    Sleep 1000
}
