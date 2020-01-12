$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName = 'ScreenCloud-1.5.1-x86.msi'

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
Remove-Item "$toolsDir\$fileName" -ea 0
