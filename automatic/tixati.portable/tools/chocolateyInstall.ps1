$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.36-1.win32-standalone.zip'
  checksum      = '000ed981d7e0396bc39130f7c1a6783851bcad2afc7900c0320b0a95a413c7a3'
  url64         = 'https://download.tixati.com/tixati-3.36-1.win64-standalone.zip'
  checksum64    = 'df14c36c80f731eb10926cf65eaba411c8a3fd8b9712077572cebd09dbe61390'
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
