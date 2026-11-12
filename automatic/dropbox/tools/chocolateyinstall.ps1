$ErrorActionPreference = 'Stop'
if (!$PSScriptRoot) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
. "$PSScriptRoot\helper.ps1"

$version = '280.3.5012'

if (!(IsVersionAlreadyInstalled $version)) {
  $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) { $false } else { $true }


  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = "Dropbox"
    url            = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20280.3.5012%20Offline%20Installer.x86.exe'
    url64          = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20280.3.5012%20Offline%20Installer.x64.exe'
    checksum       = '74367905bb4ab8191d8d89384a7e3733363d9a50cf3e333a42d2ba8fa79bae8b'
    checksum64     = '3091194f84cee8e2fecf67f3a98e3f9b304dddf7b9ff26baaf8a33d58853bc42'
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
