$ErrorActionPreference = 'Stop';

$packageName= 'gnupg-modern'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.2.17_20190709.exe'
$checksum32 = 'e5c99867591c1f72190f5540040ba027233f8cf5acc9ed627dba89a2461b57e0'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'GNU Privacy Guard*'

  checksum      = $checksum32
  checksumType  = 'sha256'

  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
