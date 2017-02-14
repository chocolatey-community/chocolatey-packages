$ErrorActionPreference = 'Stop'

$packageName = 'lightalloy'
$url32 = 'http://light-alloy.ru/LA_Setup_v4.9.2.exe'
$checksum32  = 'bdfd3e9bc9f22a55377970769e29dd8535ca3003aff0d69e2d39cfec3000a43d'

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
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
