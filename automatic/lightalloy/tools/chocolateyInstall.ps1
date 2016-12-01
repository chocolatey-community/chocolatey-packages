$ErrorActionPreference = 'Stop'

$packageName = 'lightalloy'
$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/Light-Alloy.html/LA_Setup_v4.8.8.2.exe'
$checksum32  = 'a8d6dbc9e313df47502df2c009488de2e0069b3dcf34dc2cb6b5af2cd08c75fa'

$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'lightalloy.au3'

# Need some AutoIt3 wizardry because installer is not silent
$chocTempDir	= Join-Path $env:TEMP "chocolatey"
$tempDir		= Join-Path $chocTempDir "$packageName"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$tempFile		= Join-Path $tempDir "$packageName.installer.exe"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = $tempFile
  url            = $url32
  options        = @{ Headers = @{ Referer = 'https://www.fosshub.com/' } }
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
