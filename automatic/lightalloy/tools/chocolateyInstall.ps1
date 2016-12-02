$ErrorActionPreference = 'Stop'

$packageName = 'lightalloy'
$url32 = 'https://www.fosshub.com/Light-Alloy.html/LA_Setup_v4.8.8.2.exe'
$checksum32  = 'a8d6dbc9e313df47502df2c009488de2e0069b3dcf34dc2cb6b5af2cd08c75fa'

$pwd			= "$(split-path -parent $MyInvocation.MyCommand.Definition)"
$au3			= Join-Path $pwd 'lightalloy.au3'

$packageArgs = @{
  packageName    = $packageName
  url            = $url32
  checksum       = $checksum32
  checksumType   = 'sha256'
}

$tempFile = Get-FosshubWebFile @packageArgs

Write-Output "Running AutoIt3 using `'$au3`'"
Start-ChocolateyProcessAsAdmin "/c AutoIt3.exe `"$au3`" `"$tempFile`"" 'cmd.exe'
