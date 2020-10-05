$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = '86.0.4240.72-beta'
if ($version -eq (Get-ChromeBetaVersion)) {
  Write-Host "Google Chrome Beta $version is already installed."
  return
}

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/tag/s/dl/chrome/install/beta/googlechromebetastandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/tag/s/dl/chrome/install/beta/googlechromebetastandaloneenterprise64.msi'
  checksum               = '1821b68cb400c001c6a75c72ab14c9c48fc8e9eca42fa02f8d462e4deb892ec3'
  checksum64             = 'e46c64f09aa342524e0a7543bbdf9d296ee8310816e9ecb28cab1c353da0f052'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
