Import-Module $env:ChocolateyInstall\helpers\chocolateyInstaller.psm1

$url = 'https://ontopreplica.codeplex.com/downloads/get/780725'
$fileName = Get-WebFileName $url 'ontopreplica.exe'
$destination = "$PSScriptRoot\tools\$fileName"
Remove-Item "$PSScriptRoot\tools\*.exe" -Force -ea 0
Get-WebFile $url $destination

Remove-Module chocolateyInstaller
