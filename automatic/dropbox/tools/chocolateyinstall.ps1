$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/client/Dropbox%2026.3.21%20Offline%20Installer.exe'
    checksum        = '7de320fb275dab9b5f0ceb1312c538a6b0e10a6b819c27aa82852d95bbad6d5a'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox) {
    Stop-Process -processname Dropbox
}
