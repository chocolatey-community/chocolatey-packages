rm "$PSScriptRoot\tools\*.exe"
iwr "http://download.tuxfamily.org/xmoto/xmoto/0.5.11/xmoto-0.5.11-win32-setup.exe" -UseBasicParsing -OutFile "$PSScriptRoot\tools\xmoto-0.5.11-win32-setup.exe"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
