DetectHiddenWindows, on
__Welcome:
; Welcome window
WinWait, Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard
WinHide, Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard
; Next button
ControlClick, &Next, Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard

__Components:
; Select Components window
WinWait, Setup - PDFCreator, Select Components, 1
if ErrorLevel {
  if WinExist(Setup - PDFCreator, Welcome to the PDFCreator Setup Wizard) {
    goto, __Welcome
  }
}
; Next button
ControlClick, &Next, Setup - PDFCreator, Select Components

__Ready:
; Ready to Install window
WinWait, Setup - PDFCreator, Ready to Install, 1
if ErrorLevel {
  if WinExist(Setup - PDFCreator, Select Components) {
    goto, __Components
  }
}
; Install button
ControlClick, &Install, Setup - PDFCreator, Ready to Install

__PDFArchitect:
; PDF Architect (Don't want) window
WinWait, Setup - PDFCreator, PDF Architect, 1
if ErrorLevel {
  if WinExist(Setup - PDFCreator, Ready to Install) {
    goto, __Ready
  }
}
; Next button
ControlClick, No thanks, Setup - PDFCreator, PDF Architect

__OptionalOffer:
; Install Complete Optional Offer window (definitely don't want)
WinWait, Setup - PDFCreator, Installation Completed, 30
if ErrorLevel {
  if WinExist(Setup - PDFCreator, PDF Architect) {
    goto, __OptionalOffer
  }
}
; Skip button
ControlClick, Skip, Setup - PDFCreator, Installation Completed

__Completing:
; Completing the PDFCreator Setup Wizard
WinWait, Setup - PDFCreator, Completing the PDFCreator Setup Wizard, 1
if ErrorLevel {
  if WinExist(Setup - PDFCreator, Installation Completed) {
    goto, __OptionalOffer
  }
}
while WinExist(Setup - PDFCreator, Completing the PDFCreator Setup Wizard) {
  sleep, 100
  ; Show Help checkbox
  ControlClick, TNewCheckListBox1, Setup - PDFCreator, Completing the PDFCreator Setup Wizard
  sleep, 1000
  ; Finish button
  ControlClick, &Finish, Setup - PDFCreator, Completing the PDFCreator Setup Wizard
}
