$ErrorActionPreference  = 'Stop'
$downloadDir            = Get-PackageCacheLocation
$installer              = 'ClipboardFusionSetup-5.1.1.exe'
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'ClipboardFusion'
    file                = Join-Path $downloadDir $installer
    url                 = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.1.1.exe'
    checksum            = '762FECEDCA303C525330DC4D074EDEE0981237A68FF471EB5380A9AB011BDD1D'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
