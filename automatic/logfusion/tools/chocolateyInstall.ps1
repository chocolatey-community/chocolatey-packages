$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'LogFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.8.exe'
    checksum        = '0007b7b0e3aba6c6b81cb08bddeb4d771b47f60c99a6d2f63b9d0876da5a5b86'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
