$ErrorActionPreference  = 'Stop'
 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$version = '74.4.115'

if (!(IsVersionAlreadyInstalled $version)) {
    $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {$false} else {$true}


    $packageArgs        = @{
        packageName     = $env:ChocolateyPackageName
        softwareName    = "Dropbox"
        url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2074.4.115%20Offline%20Installer.exe'
        checksum        = '30ddf1f8e2f57c09c35977fb8af323d5de4c89391d1e76084e7dd26225e09590'
        fileType        = 'exe'
        checksumType    = 'sha256'
        silentArgs      = '/s'
        validExitCodes  = @(0, 1641, 3010)
    }

    Install-ChocolateyPackage @packageArgs

    if ($stop_dropbox -and (Get-Process -Name Dropbox -ErrorAction SilentlyContinue)) {
        Stop-Process -processname Dropbox
    }
} else {
    Write-Host "Dropbox $version is already installed."
}
