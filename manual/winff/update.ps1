rm "$PSScriptRoot\tools\*.exe"
iwr "https://drive.google.com/uc?export=download&id=0B8HoAIi30ZDkZnZxMko1US1NeTg" -UseBasicParsing -OutFile "$PSScriptRoot\tools\WinFF-1.5.5-Setup.exe"

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
