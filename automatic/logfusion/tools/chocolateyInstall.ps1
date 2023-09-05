$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'LogFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.9.exe'
    checksum        = '98bbd44712efa2f8546d272c6371feb14f4e19c16af14d267fd7844652b337ff'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
