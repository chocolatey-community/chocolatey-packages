$ErrorActionPreference  = 'Stop'
 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$version = '73.3.94'

if (!(IsVersionAlreadyInstalled $version)) {
    $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {$false} else {$true}


    $packageArgs        = @{
        packageName     = $env:ChocolateyPackageName
        softwareName    = "Dropbox"
        url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2073.3.94%20Offline%20Installer.exe'
        checksum        = '3ab6a7d53029429d1eea7039fe3865efa0debfdd4f1af1be375ce659123ee651'
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
