Remove-Item "$PSScriptRoot\tools\*.zip" -Force -ea 0
iwr "https://dl.xpdfreader.com/xpdf-tools-win-4.04.zip" -UseBasicParsing -OutFile "$PSScriptRoot\tools\xpdf-tools-win-4.04.zip"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
