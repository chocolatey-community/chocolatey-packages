$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'iTunesFusion'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-3.0.1.exe'
    checksum        = '1b60ddc5ad0246433bb05085f67f19f103b66ef4b8a1706ded48e862614422ef'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
