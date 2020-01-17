$ErrorActionPreference  = 'Stop'
 if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\helper.ps1"

$version = '89.3.272'

if (!(IsVersionAlreadyInstalled $version)) {
    $stop_dropbox = if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {$false} else {$true}


    $packageArgs        = @{
        packageName     = $env:ChocolateyPackageName
        softwareName    = "Dropbox"
        url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2089.3.272%20Offline%20Installer.exe'
        checksum        = 'e13004b7796e150e874918779361f386c7b97886f8a6848e4adf623944671ec7'
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
