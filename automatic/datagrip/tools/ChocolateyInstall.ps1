$ErrorActionPreference  = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Workaround for https://youtrack.jetbrains.com/issue/IDEA-202935
$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$pp = Get-PackageParameters

$installDir = "$programFiles\JetBrains\DataGrip $env:ChocolateyPackageVersion"
if ($pp.InstallDir) {
    $installDir = $pp.InstallDir
}

$silentArgs   = "/S /CONFIG=$toolsDir\silent.config "
$silentArgs   += "/D=`"$installDir`""

New-Item -ItemType Directory -Force -Path $installDir

$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2023.2.2.exe'
    checksum            = '1452af7f1cb3d0c9390bc15c801165ea74eca9dfb248e143b12f4a1e9653235a'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
