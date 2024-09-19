$ErrorActionPreference  = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Workaround for https://youtrack.jetbrains.com/issue/IDEA-202935
$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$pp = Get-PackageParameters

$installDir = "$programFiles\JetBrains\WebStorm $env:ChocolateyPackageVersion"
if ($pp.InstallDir) {
    $installDir = $pp.InstallDir
}

$silentArgs   = "/S /CONFIG=$toolsDir\silent.config "
$silentArgs   += "/D=`"$installDir`""

New-Item -ItemType Directory -Force -Path $installDir

$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'WebStorm *'
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2024.2.2.exe'
    checksum            = '383eaf86b4df7d5c00bbe8f1106e2ec6f1768bb40bae10cb303e5bd3b06d53a6'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
