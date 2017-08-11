$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-2.55-1.portable.zip'
  checksum       = '91316e482e4b09e5e0dd08073c47d55305f1840f612b2decd0e39a4ded8ef0c6'
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
