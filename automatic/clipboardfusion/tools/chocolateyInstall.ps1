$ErrorActionPreference  = 'Stop'
$downloadDir            = Get-PackageCacheLocation
$installer              = 'ClipboardFusionSetup-5.2.exe'
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'ClipboardFusion'
    file                = Join-Path $downloadDir $installer
    url                 = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.2.exe'
    checksum            = '283685C66090224C180033587CE284AEA2936C0D5D800ED9B1FCDE0D73B61DFC'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
