Import-Module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$url32 = 'https://svgextension.codeplex.com/downloads/get/803085'
$url64 = 'https://svgextension.codeplex.com/downloads/get/803086'
$filename32 = Get-WebFileName $url32 'svg-explorer-extension_x32.exe'
$filename64 = Get-WebFileName $url64 'svg-explorer-extension_x64.exe'
$destination = "$PSScriptRoot\tools"
Remove-Item "$destination\*.exe" -Force
Get-WebFile $url32 "$destination\$filename32"
Get-WebFile $url64 "$destination\$filename64"

Remove-Module chocolateyInstaller

Set-DescriptionFromReadme -SkipFirst 1
