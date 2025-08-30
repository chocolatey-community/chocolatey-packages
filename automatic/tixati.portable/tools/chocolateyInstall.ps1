$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = 'tixati.portable'
  url           = 'https://download.tixati.com/tixati-3.37-1.win32-standalone.zip'
  checksum      = 'b37604017b65e5b6346bcd485bb9c4c2c964afb94e1537339e43346d691983a0'
  url64         = 'https://download.tixati.com/tixati-3.37-1.win64-standalone.zip'
  checksum64    = '32ffdb54192547ace10f481c8e53b32ea412d4130999dc43d87b5ece474e46b5'
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
