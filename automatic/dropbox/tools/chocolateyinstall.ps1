$ErrorActionPreference  = 'Stop'

. (Join-Path (Split-Path $MyInvocation.MyCommand.Definition -Parent) 'helpers.ps1')

$PackageProps = getDropboxRegProps

if ( ${env:ChocolateyPackageVersion} -ne $PackageProps.DisplayVersion ) {

$packageArgs        = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = "Dropbox*"
    url             = 'https://clientupdates.dropboxstatic.com/dbx-releng/client/Dropbox%2069.3.96%20Offline%20Installer.exe'
    checksum        = 'd84080ce2c1ea39783b17cc511d590cf93d1d6968f0337bb4532f9eceea9fe92'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/s'
    validExitCodes = @(0, 1641, 3010)
}

Install-ChocolateyPackage @packageArgs

} else {

  Write-Output "${env:ChocolateyPackageName} ${PackageProps.DisplayVersion} is already installed."
  
}
