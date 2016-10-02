$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'autohotkey.portable'
  url            = '{{DownloadUrl}}'
  url64Bit       = '{{DownloadUrlx64}}'
  checksum       = '{{Checksum}}'
  checksum64     = '{{Checksumx64}}'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
}

Install-ChocolateyZipPackage @packageArgs