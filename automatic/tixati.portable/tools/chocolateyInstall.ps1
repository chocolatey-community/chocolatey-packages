$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-3.29-1.portable.zip'
  checksum       = '656991111b61fe1f5a024b202e6bf3b02987419a8d7d47ae5cf5b88e78c7af09'
  checksumType   = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$is32bit = (Get-OSArchitectureWidth 32) -or ($Env:chocolateyForceX86 -eq 'true')
$tixati_path = "$toolsPath\Tixati_portable"
Remove-Item $tixati_path\tixati_Linux*
if ($is32bit) {
    Remove-Item $tixati_path\tixati_Windows64bit.exe
    Move-Item $tixati_path\tixati_Windows32bit.exe $tixati_path\tixati.exe
} else {
    Remove-Item $tixati_path\tixati_Windows32bit.exe
    Move-Item $tixati_path\tixati_Windows64bit.exe $tixati_path\tixati.exe
}
