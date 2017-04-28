Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
rm -Force "$PSScriptRoot\tools\*.exe"
Get-WebFile 'https://downloads.sourceforge.net/smclone/SMC_1.9_win32.exe?download' "$PSScriptRoot\tools\SMC_1.9_win32.exe"
Get-WebFile 'https://downloads.sourceforge.net/smclone/SMC_Music_5.0_high_win32.exe?download' "$PSScriptRoot\tools\SMC_Music_5.0_high_win32.exe"
Remove-Module chocolateyInstaller

. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"
Set-DescriptionFromReadme -SkipFirst 1
