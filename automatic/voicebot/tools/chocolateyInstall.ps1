$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'VoiceBot'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.9.1.exe'
    checksum        = '7635dfa292ae809087a0f91677a688aa3037cae2f2a172c48bc4e0c3f07f163f'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
