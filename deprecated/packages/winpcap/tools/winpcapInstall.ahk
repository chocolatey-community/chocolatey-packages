#Requires AutoHotkey v2.0
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir(A_ScriptDir)	; Ensures a consistent starting directory.
SetTitleMatchMode("RegEx")

if (A_Args.Length < 2) {
	MsgBox("Too few arguments given: " . A_Args[1])
	exit
}

hitEnter() {
	BlockInput "On"
	Sleep 250
	WinActivate
	Send "{Enter}"
	BlockInput "Off"
	return
}

run_cmd_enter(title_string, loops, check_string := "") {
	WinWait(title_string, check_string, 30)
	Loop loops {
		hitEnter
	}
	return
}

operation := A_Args[1]
runfile := A_Args[2]

Run runfile
switch operation {
	case "uninstall":
		uninstallTitle := "WinPcap [\d\.]+ Uninstall"
		run_cmd_enter(uninstallTitle, 1)
		run_cmd_enter(uninstallTitle, 1, "has been uninstalled")
	case "install":
		installTitle := "WinPcap [\d\.]+ Setup"
		run_cmd_enter(installTitle, 3)
		run_cmd_enter(installTitle, 1, "has been installed")
	default:
		MsgBox("Unsupported operation: " . operation)
		exit
}
ExitApp
