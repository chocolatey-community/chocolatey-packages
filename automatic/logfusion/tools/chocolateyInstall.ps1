$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'LogFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.6.exe'
    checksum        = 'c268c690a29e03581247b60babab5e4da1d1a16129630e41276d2cda6f70d69f'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
