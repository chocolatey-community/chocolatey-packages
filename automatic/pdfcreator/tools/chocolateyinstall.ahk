; This script will exit after 2 minutes (a slow download could cause failure)
SetTimer, TimeOut, 120000

DetectHiddenWindows, on
__Welcome:
; Welcome window
WinWait, Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard
WinGet, appid, ID, Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard
WinHide, ahk_id %appid%
; Expert settings checkbox
sleep, 100
ControlClick, TNewCheckBox1, ahk_id %appid%, Welcome to the PDFCreator Setup Wizard
sleep, 100
; Next button
ControlClick, &Next, ahk_id %appid%, Welcome to the PDFCreator Setup Wizard

__PrinterName:
; Printer Name window
WinWait, ahk_id %appid%, Printer name, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Welcome to the PDFCreator Setup Wizard) {
    goto, __Welcome
  }
}
; Next button
ControlClick, &Next, ahk_id %appid%, Printer name

__Destination:
; Select destination window
WinWait, ahk_id %appid%, Select Destination Location, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Printer name) {
    goto, __PrinterName
  }
}
; Next button
ControlClick, &Next, ahk_id %appid%, Select Destination Location

__Components:
; Select Components window
WinWait, ahk_id %appid%, Select Components, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Select Destination Location) {
    goto, __Destination
  }
}
; Next button
ControlClick, &Next, ahk_id %appid%, Select Components

__StartMenu:
; Select Start Menu Folder window
WinWait, ahk_id %appid%, Select Start Menu Folder, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Select Components) {
    goto, __Components
  }
}
; Next button
ControlClick, &Next, ahk_id %appid%, Select Start Menu Folder

__AdditionalTasks:
; Select Additional Tasks window
WinWait, ahk_id %appid%, Select Additional Tasks, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Select Start Menu Folder) {
    goto, __StartMenu
  }
}
; Next button
ControlClick, &Next, ahk_id %appid%, Select Additional Tasks

__Ready:
; Ready to Install window
WinWait, ahk_id %appid%, Ready to Install, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Select Additional Tasks) {
    goto, __AdditionalTasks
  }
}
; Install button
ControlClick, &Install, ahk_id %appid%, Ready to Install

__PDFArchitect:
; PDF Architect (Don't want) window
WinWait, ahk_id %appid%, PDF Architect, 1
if ErrorLevel {
  if WinExist(ahk_id %appid%, Ready to Install) {
    goto, __Ready
  }
}
; Next button
ControlClick, No thanks, ahk_id %appid%, PDF Architect

__OptionalOffer:
; Install Complete Optional Offer window (definitely don't want)
WinWait, Setup - PDFCreator, Installation Completed, 30
if ErrorLevel {
  if WinExist(ahk_id %appid%, PDF Architect) {
    goto, __OptionalOffer
  }
}
; Skip button
ControlClick, Skip, Setup - PDFCreator, Installation Completed

__Completing:
; Completing the PDFCreator Setup Wizard
WinWait, ahk_id %appid%, Completing the PDFCreator Setup Wizard, 1
if ErrorLevel {
  if WinExist(Setup - PDFCreator, Installation Completed) {
    goto, __OptionalOffer
  }
}
while WinExist(ahk_id %appid%, Completing the PDFCreator Setup Wizard) {
  sleep, 200
  ; Show Help checkbox
  ControlClick, TNewCheckListBox1, ahk_id %appid%, Completing the PDFCreator Setup Wizard
  sleep, 500
  ; Finish button
  ControlClick, &Finish, ahk_id %appid%, Completing the PDFCreator Setup Wizard
}

ExitApp

TimeOut:
ExitApp 120
