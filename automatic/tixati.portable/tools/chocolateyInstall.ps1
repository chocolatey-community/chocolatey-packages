$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.43-1.win32-standalone.zip'
  checksum      = 'd14fca772689b9fc95dfe10c239d06b0440ac9b2ccd035eee29482bb84fc7a57'
  url64         = 'https://download.tixati.com/tixati-3.43-1.win64-standalone.zip'
  checksum64    = '69bd2e40f72553a19b06dc2e2213865bc6c29ce5291c9351d4b268e5c1fb286e'
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
