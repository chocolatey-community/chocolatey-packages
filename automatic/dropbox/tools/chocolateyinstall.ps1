$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2023.4.18%20Offline%20Installer.exe'
    checksum        = ''
    fileType        = 'exe'
    checksumType    = ''
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox) {
    Stop-Process -processname Dropbox
}
