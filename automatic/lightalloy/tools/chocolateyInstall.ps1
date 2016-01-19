$packageName	= '{{PackageName}}'
$installerType	= 'EXE'
$url			= '{{DownloadUrl}}'
$silentArgs		= '/S /I'
$validExitCodes	= @(0)
$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'lightalloy.au3'

# Combatibility - This function has not been merged
if (!(Get-Command Get-UrlFromFosshub -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Get-UrlFromFosshub.ps1"
}
$url = Get-UrlFromFosshub $url

# Installer if the old silent mode would still work was easy
#Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes

# Need some AutoIt3 wizardry because installer is not silent
$chocTempDir	= Join-Path $env:TEMP "chocolatey"
tempDir		= Join-Path $chocTempDir "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$tempFile		= Join-Path $tempDir "$packageName.installer.exe"

Get-ChocolateyWebFile "$packageName" "$tempFile" "$url"
	
Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
