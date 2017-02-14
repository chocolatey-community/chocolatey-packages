$ErrorActionPreference = 'Stop'

$packageName = 'lightalloy'
$url32 = ''
$checksum32  = ''

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
  checksum       = $checksum32
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
