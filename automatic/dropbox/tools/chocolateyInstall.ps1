$ErrorActionPreference = 'Stop'

$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'functions.ps1')
$version = '22.4.24'

$packageArgs = @{
  packageName   = 'dropbox'
  fileType      = 'exe'
  url           = 'https://dl-web.dropbox.com/u/17/Dropbox%2022.4.24.exe'
  silentArgs    = '/S'
  softwareName  = 'Dropbox'
  checksum      = '37d27d3ebd0426be061495e9efd4d67f7e3dd3b582f89fea6a31b45b3fb9beb0'
  checksumType  = 'sha256'  
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
# Variables for the AutoHotkey-script
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile = "$scriptPath\dropbox.ahk"

$installedVersion = (getDropboxRegProps).DisplayVersion

  if ($installedVersion -ge $version) {
    Write-Host "Dropbox $installedVersion is already installed."
  } else {
	Install-ChocolateyPackage @packageArgs
    Start-Process 'AutoHotkey' $ahkFile
  }

