﻿$ErrorActionPreference  = 'Stop'

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
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2024.2.1.exe'
    checksum            = 'de6369f29021fb761d5bc67907304d1e29ace82b7e6c1d5089354719c4ed107d'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
