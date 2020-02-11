$ErrorActionPreference  = 'Stop'
 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$version = '91.3.536'

if (!(IsVersionAlreadyInstalled $version)) {
    $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {$false} else {$true}


    $packageArgs        = @{
        packageName     = $env:ChocolateyPackageName
        softwareName    = "Dropbox"
        url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2091.3.536%20Offline%20Installer.exe'
        checksum        = '18f011898832eb760d01598d4697a8e174925c145738c2f34dcbefbe1bff62d5'
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
