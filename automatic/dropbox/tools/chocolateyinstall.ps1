$ErrorActionPreference  = 'Stop'

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2058.3.88%20Offline%20Installer.exe'
    checksum        = '697c4d11c49a7980a26508e7c862a593c6e0749c7e481935ee2e001431b66559'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

if (Get-Process -Name Dropbox -ErrorAction SilentlyContinue) {
    Stop-Process -processname Dropbox
}
