$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName = 'ScreenCloud-1.3.0-x86.msi'

$packageArgs = @{
    packageName    = 'screencloud'
    softwareName   = 'ScreenCloud'

    fileType       = 'msi'
    file           = "$toolsDir\$fileName"

    silentArgs     = '/qn /norestart'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# clean up
rm "$toolsDir\$fileName" -ea 0
