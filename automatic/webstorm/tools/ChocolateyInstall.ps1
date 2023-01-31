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
    softwareName        = 'JetBrains WebStorm*'
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2022.3.2.exe'
    checksum            = 'ba07cb3086993dd7796b7186a57e182006d4214740c494139ba498c956a64d78'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = $silentArgs
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
