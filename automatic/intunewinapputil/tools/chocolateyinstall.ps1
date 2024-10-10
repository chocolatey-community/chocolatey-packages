$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Remove any prior installations.
$foldersToRemove = Get-ChildItem -Path $toolsDir\microsoft-Microsoft-Win32-Content-Prep-Tool-* -Directory
foreach ($folder in $foldersToRemove) {
  Remove-Item $folder.FullName -Force -Recurse -ErrorAction Ignore
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/archive/refs/tags/v1.8.6.zip'
  softwareName  = 'intunewinapputil*'
  checksum      = '3bfd2c93a3500bc2b99c007a5d2352af021df9a043851b77f01ea788fd878851'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
