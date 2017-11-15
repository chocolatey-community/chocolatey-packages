$ErrorActionPreference  = 'Stop'
$downloadDir            = Get-PackageCacheLocation
$installer              = 'ClipboardFusionSetup-5.2.1.exe'
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'ClipboardFusion'
    file                = Join-Path $downloadDir $installer
    url                 = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.2.1.exe'
    checksum            = '2B160D017D446786AE98B3511A1FC596F543AE25E65BFF0AAC89B5EB94CF43C1'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
