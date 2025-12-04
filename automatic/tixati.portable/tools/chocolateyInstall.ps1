$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.41-1.win32-standalone.zip'
  checksum      = '1515be9d356233be4be8b264b680e26e4b632343569d4fdc63f1469a7d538ee5'
  url64         = 'https://download.tixati.com/tixati-3.41-1.win64-standalone.zip'
  checksum64    = '0d58f50a94a5fca957ab649fb45233b71db687f40d5cb24416651549f16de1f5'
  checksumType  = 'sha256'
  unzipLocation = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$files = get-childitem $toolsPath -include *.exe -recurse
foreach ($file in $files) {
  if ($file.name -ne "tixati.exe") {
    New-Item "$file.ignore" -type file -force | Out-Null
  }
}
