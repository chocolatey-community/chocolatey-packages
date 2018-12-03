$ErrorActionPreference  = 'Stop'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Workaround for https://youtrack.jetbrains.com/issue/IDEA-202935
$programfiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
New-Item -ItemType Directory -Force -Path $programfiles\JetBrains
 
$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2018.3.exe'
    checksum            = 'e6beb91ac0d5c71a68a6ce79c13784c9f1514816b98e313cf6a759a30d3bef1d'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = "/S /CONFIG=$toolsDir\silent.config "
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
