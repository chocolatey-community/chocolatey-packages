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
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2024.2.exe'
    checksum            = '5a37cc8c3fb7f4ac1fdc3d10cbff7524a6f7ce049daee537a260d5f6eaf604ae'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
