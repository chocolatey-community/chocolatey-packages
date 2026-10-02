$ErrorActionPreference = 'Stop'
if (!$PSScriptRoot) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
. "$PSScriptRoot\helper.ps1"

$version = '274.3.4801'

if (!(IsVersionAlreadyInstalled $version)) {
  $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) { $false } else { $true }


  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = "Dropbox"
    url            = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20274.3.4801%20Offline%20Installer.x86.exe'
    url64          = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20274.3.4801%20Offline%20Installer.x64.exe'
    checksum       = '1387178fb4c9b1f5b5ca0e3109afd322f7ce5d4cf87a7b849921b6cae15b6580'
    checksum64     = '6446344d1eb9ba3fc7268004e5b1945d0f17fc50c4b85552c6d01b2bbad602c8'
    fileType       = 'exe'
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
    silentArgs     = '/s'
    validExitCodes = @(0, 1641, 3010)
  }

  Install-ChocolateyPackage @packageArgs

  if ($stop_dropbox -and (Get-Process -Name Dropbox -ErrorAction SilentlyContinue)) {
    Stop-Process -processname Dropbox
  }
}
else {
  Write-Host "Dropbox $version is already installed."
}
