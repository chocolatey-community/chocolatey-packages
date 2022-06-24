$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = '[[URL]]'
# Remove any prior installations.
$foldersToRemove = Get-ChildItem -Path $toolsDir\microsoft-Microsoft-Win32-Content-Prep-Tool-* -Directory
foreach ($folder in $foldersToRemove) {
  Remove-Item $folder.FullName -Force -Recurse -ErrorAction Ignore
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'intunewinapputil*'
  checksum      = '[[CHECKSUM]]'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
