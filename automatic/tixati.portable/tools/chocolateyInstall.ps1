$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download2.tixati.com/download/tixati-2.79-1.portable.zip'
  checksum       = 'bc6d786ff25d93d03f797c8ff58a445f3e593bee7e61d7f711f15bbee49e61e6'
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
