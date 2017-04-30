rm "$PSScriptRoot\tools\*.exe"
iwr "http://www.optimasc.com/products/vp8vfw/vp8vfw-setup-1.2.0.exe" -UseBasicParsing -OutFile "$PSScriptRoot\tools\vp8vfw-setup-1.2.0.exe"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
