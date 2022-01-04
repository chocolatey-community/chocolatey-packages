$ErrorActionPreference  = 'Stop'

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'VoiceBot'
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.8.1.exe'
    checksum        = '9f25e219189e09964dc387ec1c0a76c8443eaa21c52fd8d2142ee647ad2bbadc'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
