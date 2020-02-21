$ErrorActionPreference = 'Stop';

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://s3.amazonaws.com/aws-cli/AWSCLI32PY3-1.18.4.msi'
$checksum   = '123a5842ca3b36d73aecf98f0502d5b1c9dab7f51243caefac3261e217c0aa6a'
$url64      = 'https://s3.amazonaws.com/aws-cli/AWSCLI64PY3-1.18.4.msi'
$checksum64 = '25fd8455822d36a4caa081a97a0a3e73d764c6f0cce7e8d72ae3042f4a110afe'
 
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64
  softwareName  = 'AWS Command Line Interface*'
  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
