$ErrorActionPreference = 'Stop'
if (!$PSScriptRoot) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
. "$PSScriptRoot\helper.ps1"

$version = '197.3.7470'

if (!(IsVersionAlreadyInstalled $version)) {
  $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) { $false } else { $true }


  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = "Dropbox"
    url            = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20197.3.7470%20Offline%20Installer.x86.exe'
    url64          = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20197.3.7470%20Offline%20Installer.x64.exe'
    checksum       = 'b6edb5c57d6798d0a496234450295b002c420fb3198a89cee62eb70dd1d058d6'
    checksum64     = 'f2e6e5200454537e5afcd4fce07fbc2e6961e77ea06c9fcf106e99cbbbb2c1a7'
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
