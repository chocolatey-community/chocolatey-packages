$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'LogFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.2.1.exe'
    checksum        = '55ce7ba56d448b4c32e153997c6c8d12938cc87fcc9fbd1fffcb3c70bc350170'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
