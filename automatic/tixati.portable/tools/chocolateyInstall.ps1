$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.39-1.win32-standalone.zip'
  checksum      = '996e85f28edb2dc020fd912110565da4b4b973375c5e6aeb24ecac1c7eae9a0d'
  url64         = 'https://download.tixati.com/tixati-3.39-1.win64-standalone.zip'
  checksum64    = 'ffcce23953d3406fbad7b1e9b0857d0cf08ccb011b43757e2cb698b838bc2296'
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
