$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2068.4.102%20Offline%20Installer.exe'
    checksum        = '10dce9777bdcaaffeeed266a6601a686293e9c5e2e86d261bbe8fc83b0fa6e13'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
    Stop-Process -processname Dropbox
}
