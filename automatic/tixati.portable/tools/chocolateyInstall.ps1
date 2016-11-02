$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tixati.portable'
  url            = 'https://download3.tixati.com/download/tixati-2.48-1.portable.zip'
  checksum       = '835502edb04f26e81bb31bee68c3fe0e22cf0ce82ff72a5d1f877e97356167f9'
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
