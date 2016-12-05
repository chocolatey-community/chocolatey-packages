$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download3.tixati.com/download/tixati-2.49-1.portable.zip'
  checksum       = 'bdf09d8dfe2c99b7d5ddd2eac3d21c814d474b23072caafe36ebb0072f71f54d'
  checksumType   = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$is32bit = (Get-ProcessorBits 32) -or ($Env:chocolateyForceX86 -eq 'true')
$tixati_path = "$toolsPath\Tixati_portable"
rm $tixati_path\tixati_Linux*
if ($is32bit) {
    rm $tixati_path\tixati_Windows64bit.exe
    mv $tixati_path\tixati_Windows32bit.exe $tixati_path\tixati.exe
} else {
    rm $tixati_path\tixati_Windows32bit.exe
    mv $tixati_path\tixati_Windows64bit.exe $tixati_path\tixati.exe
}
