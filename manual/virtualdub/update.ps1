Import-Module $ENV:ChocolateyInstall\helpers\chocolateyInstaller.psm1

$url = "https://sourceforge.net/projects/virtualdub/files/virtualdub-win/1.10.4.35491/VirtualDub-1.10.4.zip/download"
$url64 = "https://sourceforge.net/projects/virtualdub/files/virtualdub-win/1.10.4.35491/VirtualDub-1.10.4-AMD64.zip/download"
Remove-Item "$PSScriptRoot\tools\*.zip" -Force -ea 0
Get-WebFile $url   "$PSScriptRoot\tools\VirtualDub-1.10.4.zip"
Get-WebFile $url64 "$PSScriptRoot\tools\VirtualDub-1.10.4-AMD64.zip"

Remove-Module chocolateyInstaller
