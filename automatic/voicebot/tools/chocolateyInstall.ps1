$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'VoiceBot'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-4.0.exe'
    checksum        = 'c420f93466005b42fb19d44ed5083dc3f5b17985fe2f7e5d7e5d963baaf115ee'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
