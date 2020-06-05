$ErrorActionPreference  = 'Stop'
 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$version = '99.3.496'

if (!(IsVersionAlreadyInstalled $version)) {
    $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {$false} else {$true}


    $packageArgs        = @{
        packageName     = $env:ChocolateyPackageName
        softwareName    = "Dropbox"
        url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2099.3.496%20Offline%20Installer.exe'
        checksum        = '1c2fcc756be81e243954574e7522fd1e51d432a403c27c36b95eaf962880a6fa'
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
