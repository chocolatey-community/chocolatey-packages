$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = 'screencloud'
    fileType       = 'msi'
    softwareName   = 'ScreenCloud'

    checksum       = '41b4a0c38dc677820add2a7b2a695e9f9e8e60a14e3e869abe5bfae27e54a2e5'
    checksumType   = 'sha256'
    url            = 'https://screencloud.net/files/windows/ScreenCloud-1.3.0-x86.msi'

    silentArgs     = '/qn /norestart'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
