$ErrorActionPreference  = 'Stop'
$downloadDir            = Get-PackageCacheLocation
$installer              = 'ClipboardFusionSetup-5.0.exe'
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = 'ClipboardFusion'
    file                = Join-Path $downloadDir $installer
    url                 = 'https://binaryfortressdownloads.com/Download/BFSFiles/104/ClipboardFusionSetup-5.0.exe'
    checksum            = 'ED41DFFEA6CC07B1DDF590569FB8DD830BA50F16323631138AC6CE032306054C'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/VERYSILENT /LAUNCHAFTER=0'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
