iwr -UseBasicParsing 'https://fincs.ahk4.net/scite4ahk/dl/s4ahk-install.exe' -OutFile "$PSScriptRoot\tools\s4ahk-install.exe"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
