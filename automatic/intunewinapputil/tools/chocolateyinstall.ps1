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
  url           = 'https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/archive/refs/tags/v1.8.4.zip'
  softwareName  = 'intunewinapputil*'
  checksum      = '13BD857841E026E3E6911DC9B84DAAE9F5637144B8DEEA7909E1BE690C9D2E9A'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
