$downloadDir        = Get-PackageCacheLocation
$installer          = 'ClipboardFusionSetup-4.2.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'ClipboardFusion'
    file            = Join-Path $downloadDir $installer
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-4.2.exe'
    checksum        = 'DF149A178FB74EF0EBCCD2E528C989A6D797425E1DD7DE7F13A19917B560EE1F'
    fileType        = 'exe'
    checksumType    = ''
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
