$ErrorActionPreference = 'Stop'
if (!$PSScriptRoot) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
. "$PSScriptRoot\helper.ps1"

$version = '185.3.5963'

if (!(IsVersionAlreadyInstalled $version)) {
  $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) { $false } else { $true }


  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = "Dropbox"
    url            = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20185.3.5963%20Offline%20Installer.x86.exe'
    url64          = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20185.3.5963%20Offline%20Installer.x64.exe'
    checksum       = '83a951fce58e387a8ea1da939201abf9b724b27fdc548d3f55cdcc9388fa84c1'
    checksum64     = 'd539ec6c41de3ed2e8ff86ee072283acf771de32e3ae7d71c2d7af1a6ac82d55'
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
