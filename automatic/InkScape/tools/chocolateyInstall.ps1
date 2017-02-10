$ErrorActionPreference = 'Stop'


$packageArgs = @{
  packageName            = 'InkScape'
  fileType               = 'msi'
  url                    = 'https://inkscape.org/gallery/item/10558/Inkscape-0.92.0.msi'
  url64bit               = 'https://inkscape.org/en/gallery/item/10559/Inkscape-0.92.0-x64.msi'
  checksum               = '198d4cdb84655ea686c0c0ce59312b476ec75742d6e735adca94dd6454d556e7'
  checksum64             = 'cf728ccb31b9f1ba34fe2f76d5a1049b0561a039ee74ed6ba3e00f03f7233d8a'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0)
  softwareName           = 'InkScape*'
}
$current_version = Get-UninstallRegistrykey $packageArgs.softwareName  | select -Expand DisplayVersion
if ($current_version -eq $Env:ChocolateyPackageVersion) {
    Write-Host "Sowtware already installed"
} else { Install-ChocolateyPackage @packageArgs }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
