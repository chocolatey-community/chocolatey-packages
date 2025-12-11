$ErrorActionPreference = 'Stop'
if (!$PSScriptRoot) {
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}
. "$PSScriptRoot\helper.ps1"

$version = '239.3.7987'

if (!(IsVersionAlreadyInstalled $version)) {
  $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) { $false } else { $true }


  $packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = "Dropbox"
    url            = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20239.3.7987%20Offline%20Installer.x86.exe'
    url64          = 'https://edge.dropboxstatic.com/dbx-releng/client/Dropbox%20239.3.7987%20Offline%20Installer.x64.exe'
    checksum       = '8b4d433a9e2fc42eb402e9f9fafb26769defbacc0d946484cc6c180c9552ae8b'
    checksum64     = 'a627ff527bb7d1fe95be211f755dd1e0f78e9a3db44b5ad97e3f48aa5936208e'
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
