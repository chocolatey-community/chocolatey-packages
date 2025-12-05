$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.42-1.win32-standalone.zip'
  checksum      = '163b53e54a4cccd95ee3803b05563e34bcaaec8c19a0f2c4def8c343be6cb9a6'
  url64         = 'https://download.tixati.com/tixati-3.42-1.win64-standalone.zip'
  checksum64    = '449c3371470c7a863ef7e9000163510e8879b455842ee06a259495a8c08029eb'
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
