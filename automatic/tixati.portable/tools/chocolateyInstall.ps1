$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-2.56-1.portable.zip'
  checksum       = 'ea652e6f56ab8a0d6f336b9b4c8039c7d2264605cdd7764248a44a0824518843'
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
