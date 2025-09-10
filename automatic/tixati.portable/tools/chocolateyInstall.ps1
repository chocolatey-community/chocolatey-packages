$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.38-1.win32-standalone.zip'
  checksum      = '9d8f699a467455776eab1fecf156c3bacff0d52afb618c9d6a87c0d09ec0e55c'
  url64         = 'https://download.tixati.com/tixati-3.38-1.win64-standalone.zip'
  checksum64    = '14235eda443cffcc622fc9242a48a21f898c3d5cde40bcc66d75804326316eec'
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
