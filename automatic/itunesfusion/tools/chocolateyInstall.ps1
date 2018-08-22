$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'iTunesFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-3.2.exe'
    checksum        = '1776bcb9621e1c36ace76f2e68d4c704d98a079f4caaf7f8e25bfe59b89106fc'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
