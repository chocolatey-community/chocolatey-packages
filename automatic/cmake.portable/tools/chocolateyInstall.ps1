$packageName = 'cmake.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://cmake.org//files/v3.9/cmake-3.9.4-win32-x86.zip'
$checksum = '8214df1ff51f9a6a1f0e27f9bd18f402b1749c5b645fbf6e401bcb00047171cd'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"