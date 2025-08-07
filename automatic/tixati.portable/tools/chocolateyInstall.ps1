$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.33-1.win32-standalone.zip'
  checksum      = 'cd2bcf49113399a01a8b782d489cbacf2ea1eb437b9f48ed388b592fa3caf8b5'
  url64         = 'https://download.tixati.com/tixati-3.33-1.win64-standalone.zip'
  checksum64    = '8d2ccbd414e283ce867555dcceda0140087b3186b35b75303806189b56257d34'
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
