$packageName	= '{{PackageName}}'
$installerType	= 'exe' 
$url			= 'http://download.easeus.com/free/epm.exe'
$silentArgs		= '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'

Write-Host
Write-Host "This package is not fully unattended." -ForegroundColor "White"
Write-Host "A screen will pop up where you have to accept the license agreement manually." -ForegroundColor "White"
Write-Host

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"
