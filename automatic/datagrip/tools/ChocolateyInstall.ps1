$ErrorActionPreference  = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters

$silentArgs   = "/S /CONFIG=$toolsDir\silent.config "
if ($pp.InstallDir) {
    # note there are no quotes around the installDir
    # (taken from https://www.jetbrains.com/help/datagrip/2023.1/installation-guide.html#silent):
    # /D: Specify the path to the installation directory
    # This parameter must be the last in the command line, and it should not contain any quotes even if the path contains blank spaces.
    $silentArgs   += "/D=$($pp.InstallDir)"
}

$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2024.1.5.exe'
    checksum            = '557bc4a5d7be28141e2ebe6418a662f07a221d66b3a794be48782793d79f1ff8'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
