$ErrorActionPreference  = 'Stop'

$downloadDir        = Get-PackageCacheLocation
$installer          = 'iTunesFusionSetup-2.6.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'iTunesFusion'
    file            = Join-Path $downloadDir $installer
    url             = 'https://binaryfortressdownloads.com/Download/BFSFiles/102/iTunesFusionSetup-2.6.exe'
    checksum        = '2CE11CE6F3C5ED6A6B24D47C9EA346488BA5FA46AE525B31F9ADF7246E06FA1F'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes  = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
