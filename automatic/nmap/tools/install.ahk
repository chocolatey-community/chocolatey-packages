#Requires AutoHotkey >=2.0
#SingleInstance force
SetTitleMatchMode("RegEx")

WinWait("Nmap Setup")
Sleep(100)
ControlSend("{Enter}")

Loop{
    if WinExist("Npcap [0-9.]+ Setup", "already installed")
    {
        Sleep(100)
        ControlSend("{Enter}")
    }

    if WinExist("Npcap [0-9.]+ Setup", "License Agreement")
    {
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(200)
        ControlSend("{Enter}")
        Sleep(200)
        ControlSend("{Enter}")
    }

    if WinExist("Npcap [0-9.]+ Setup", "Installation Complete")
    {
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(100)
        ControlSend("{Enter}")
    }
    
    if WinExist("Nmap Setup", "License Agreement")
    {
        ControlSend("{Enter}")
    }
    
    if WinExist("Nmap Setup", "Choose Install Location")
    {
        ControlSend("{Enter}")
    }

    if WinExist("Nmap Setup", "Choose Components")
    {
        ControlSend("{Enter}")
    }

    if WinExist("Nmap Setup", "Installation Complete")
    {
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(100)
        if !WinExist("Nmap Setup")
        {
          break
        }
        ControlSend("{Enter}")

        if !WinExist("Nmap Setup")
        {
          break
        }
    }

    if WinExist("Nmap Setup", "Finished")
    {
        Sleep(100)
        ControlSend("{Enter}")
        Sleep(100)

        if !WinExist("Nmap Setup")
        {
          break
        }
    }

    ; IfWinExist, Nmap Setup, Microsoft Visual C++
    ; {
    ;     Sleep, 100
    ;     ControlSend,, {Enter}
    ; }

    Sleep(1000)
}
