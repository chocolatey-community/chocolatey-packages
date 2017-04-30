Remove-Item "$PSScriptRoot\tools\*.zip" -Force -ea 0
iwr "http://ctan.mirror.garr.it/mirrors/CTAN/support/xpdf/xpdfbin-win-3.04.zip" -UseBasicParsing -OutFile "$PSScriptRoot\tools\xpdfbin-win-3.04.zip"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
