$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2025.4.28%20Offline%20Installer.exe'
    checksum        = 'd5299d285757b53eef5f548acce6ec1f50ed09dcc481bd74638f810e44c29614'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox) {
    Stop-Process -processname Dropbox
}
