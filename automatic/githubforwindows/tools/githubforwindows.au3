Opt('WinDetectHiddenText', 1)
;Path and filename of the installer executable
$APPTOINSTALL="""" & $CmdLine[1] & """"
Run($APPTOINSTALL)
If @error <> 0  Then 
	MsgBox(0, "Run failed", "The ""Run"" command failed for " & $APPTOINSTALL & " /S - exiting", 5)
	Exit
EndIf

;Wait for the installation to complete and the dialog to appear, close the window
$DEFAULTWAITTIME=180
; This will shut all of your default browser windows. 
; $WINDOWNAME="Application Install - Security Warning"
; WinWaitActive($WINDOWNAME)
; WinClose($WINDOWNAME)

$WINDOWNAME="Application Install - Security Warning"
WinWaitActive($WINDOWNAME)
ControlClick($WINDOWNAME,"","[TEXT:&Install]")
WinSetState($WINDOWNAME,"",@SW_HIDE)

$WINDOWNAME="(0%) Installing GitHub"
WinExists($WINDOWNAME)
WinSetState($WINDOWNAME,"",@SW_HIDE)

$LONGWAITTIME=300
$WINDOWNAME="GitHub"
WinWait($WINDOWNAME,"",$LONGWAITTIME)
;Installation complete
Exit