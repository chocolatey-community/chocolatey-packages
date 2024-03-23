$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-3.24-1.portable.zip'
  checksum       = '5c5f81e4a4e144a2b8f63c01e2969234ffaf6503f889b101e49825d09bbe0e8e'
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
