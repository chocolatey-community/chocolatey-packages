$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'LogFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/117/LogFusionSetup-6.5.exe'
    checksum        = 'bc98824ada055e6cf3ecea087d92ee00b6c276a48ab4120b41204de47abad8b5'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
