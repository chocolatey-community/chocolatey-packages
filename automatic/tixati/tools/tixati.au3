#region --- Internal functions Au3Recorder Start ---
Func _Au3RecordSetup()
	Opt('WinWaitDelay',100)
	Opt('WinDetectHiddenText',1)
	Opt('MouseCoordMode',0)
EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc

_AU3RecordSetup()
#endregion --- Internal functions Au3Recorder End ---



#;Path and filename of the installer executable
#$INSTALLER="""" & $CmdLine[1] & """"



Run($CmdLine[1])

_WinWaitActivate("Tixati v","Click the 'Continue'")
Send("{SPACE}")
_WinWaitActivate("Tixati v","YES, continue instal")
Send("{SPACE}")
_WinWaitActivate("Tixati v","Tixati will be insta")
Send("{SPACE}")
_WinWaitActivate("Tixati v","Installation is comp")
Send("{TAB}")
Send("{SPACE}")

Exit
