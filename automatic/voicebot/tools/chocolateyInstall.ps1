$downloadDir        = Get-PackageCacheLocation
$installer          = 'VoiceBotSetup-3.0.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'VoiceBot'
    file            = Join-Path $downloadDir $installer
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/123/VoiceBotSetup-3.0.exe'
    checksum        = '8BC560E85A844F6FD0412E6BD43028F30CB6ACD14AFE4092F02C70072E69BEA9'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
