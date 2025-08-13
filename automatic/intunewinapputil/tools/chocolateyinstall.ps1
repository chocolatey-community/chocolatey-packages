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
  url           = 'https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/archive/refs/tags/v1.8.7.zip'
  softwareName  = 'intunewinapputil*'
  checksum      = 'f6b811fb02efd98287f090caabc32d32b2400ece2a5aa2238cb616e86edd2ff8'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
