$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = '125.0.6422.60'
if ($version -eq (Get-ChromeVersion)) {
  Write-Host "Google Chrome $version is already installed."
  return
}

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  checksum               = '6b8e00f55d731aaa2bfef22cf82a8415412f67c99d1c32cd7a9de92678accb41'
  checksum64             = '6ae8f91b54d9ee04e451256c74e70293105292e5e9e60d9804f77c1c13d4a631'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/quiet /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | ForEach-Object { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
