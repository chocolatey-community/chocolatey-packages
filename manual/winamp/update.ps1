. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

rm $PSScriptRoot\tools\*.exe
iwr http://winamp.meggamusic.co.uk/winamp5666_full_en-us_redux.exe -Out tools\winamp5666_full_en-us_redux.exe
iwr http://winamp.meggamusic.co.uk/winamp5666_lite_en-us_redux.exe -Out tools\winamp5666_lite_en-us_redux.exe

Set-DescriptionFromReadme -SkipFirst 2