#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force
#Warn
DetectHiddenText "Off"
DetectHiddenWindows "Off"
SetControlDelay 20
SendMode "Input"
SetTitleMatchMode 3 ;Exact
SetWinDelay 100

ShouldRemoveUserData := False
for i, param in A_Args
{
  if (!StrCompare("/RemoveUserData", param))
  {
    ShouldRemoveUserData := True
    break
  }
}

UninstallerProcessName := "installer.exe"
MainWindowClass := "InstallerMainWindow"
MainWindowTitle := "ahk_class " MainWindowClass " ahk_exe " UninstallerProcessName
WinWait MainWindowTitle

if (ShouldRemoveUserData)
{
  RemoveUserDataCheckbox := "Button12"
  ;For some reason, neither ControlClick nor ControlSetChecked will tick the checkbox
  ControlSend "{Space}", RemoveUserDataCheckbox, MainWindowTitle
}

UninstallButton := "Button3"
;This window's buttons may not work reliably with ControlClick if mouse-up events are delayed.
;Send spaces with ControlSend instead for increased reliability.
ControlSend "{Space}", UninstallButton, MainWindowTitle

;If the user has launched Opera at least once, a survey page may show up.
Sleep 200
FirstRadioButton := "Button13" ;The positioning of each option is randomized and may vary
SurveyPageVisible := ControlGetVisible(FirstRadioButton, MainWindowTitle)
if (SurveyPageVisible) {
  ;Skip over the survey
  ControlSend "{Space}", UninstallButton, MainWindowTitle
}

DialogWindowClass := "#32770"
DialogWindowTitle := "ahk_class " DialogWindowClass " ahk_exe " UninstallerProcessName
WinWait DialogWindowTitle

YesButton := "Button1"
ControlClick YesButton, DialogWindowTitle,,,, "NA"

TryAgainButton := "Button6"
while !WinWaitClose(MainWindowTitle,, 1) {
  try {
    TryAgainButtonVisible := ControlGetVisible(TryAgainButton, MainWindowTitle)
    if (TryAgainButtonVisible) {
      ;Allow the user an opportunity to see the uninstaller has failed, then try again
      Sleep 2000
      ControlSend "{Space}", TryAgainButton, MainWindowTitle
    }
  }
}

ExitApp
