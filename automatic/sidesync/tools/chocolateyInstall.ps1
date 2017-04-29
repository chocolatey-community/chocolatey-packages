$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'sidesync'
  fileType               = 'exe'
  url                    = 'https://www.samsung.com//us/sidesync/SideSync_4.7.0.84.exe'
  checksum               = '21f5a52ff2b94aa57ab34042c6de1c79cebfef20901942bce327b0ae8fbce621'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Samsung SideSync'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"