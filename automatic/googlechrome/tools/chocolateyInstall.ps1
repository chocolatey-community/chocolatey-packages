$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = '62.0.3202.75'
if ($version -eq (Get-ChromeVersion)) {
  Write-Host "Google Chrome $version is already installed."
  return
}

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  checksum               = 'c6d0c07331a7dfd5b39c53d1f76d70b7ac259ea4f96b3a98be5c52bdf06b3c7e'
  checksum64             = 'eba259f1f5892c16f4121fc9cc556bbea32ada79d74aa30d41e27ec1bde878b8'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | % { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
