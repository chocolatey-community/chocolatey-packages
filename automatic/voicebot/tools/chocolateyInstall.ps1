$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'VoiceBot'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.0.exe'
    checksum        = '8bc560e85a844f6fd0412e6bd43028f30cb6acd14afe4092f02c70072e69bea9'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
