$ErrorActionPreference = 'Stop'

$packageName = 'lightalloy'
$url32 = 'http://light-alloy.verona.im/LA_Setup_v4.10.1.exe'
$checksum32  = '0d4241f36a1d74f1cc6318ff5919c8fdd79af59a63e32854a72ceb7eeb40c82d'

$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'lightalloy.au3'

# Need some AutoIt3 wizardry because installer is not silent
$chocTempDir	= Join-Path $env:TEMP "chocolatey"
$tempDir		= Join-Path $chocTempDir "$packageName"
$tempFile		= Join-Path $tempDir "$packageName.installer.exe"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = $tempFile
  url            = $url32
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "`"$au3`" `"$tempFile`"" 'AutoIt3.exe'
