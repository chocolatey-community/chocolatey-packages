$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2059.3.89%20Offline%20Installer.exe'
    checksum        = '73012ba28497e86a0f80d647e6ea4f08e5a7e4b8ecd6032314c2ed2c6a91dcbb'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
    Stop-Process -processname Dropbox
}
