$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = $Env:ChocolateyPackageVersion
if ($version -eq (Get-ChromeVersion)) {
    Write-Host "Google Chrome $version is already installed."
    return
}

$packageArgs = @{
  packageName            = 'googlechrome'
  fileType               = 'MSI'
  url                    = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64bit               = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  checksum               = 'c39c71f3696bae0fb461584a3d3ff00a48e408879f3aa0c78b4e8c1fc2ee7a8b'
  checksum64             = 'f2a041a99f0261a3574ae67978c61c16293e02c4ba25f0dafed3397fa49aa777'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | % { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
