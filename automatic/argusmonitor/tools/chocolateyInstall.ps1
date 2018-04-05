$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileName = 'downloads.exe'

$packageArgs = @{
    packageName    = 'argusmonitor'
    softwareName   = 'ArgusMonitor'

    fileType       = 'exe'
    file           = "$toolsDir\$fileName"

    silentArgs     = '/S /SD'
    validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# clean up
Remove-Item "$toolsDir\$fileName" -ea 0
