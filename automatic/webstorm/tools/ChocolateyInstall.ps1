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
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2024.3.3.exe'
    checksum            = '8bc0dbf1ef05c200eb8d9f9e114c43a9056bc82869cb665e9eb8aac0107a8477'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
