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
  checksum               = '64912bc96c775f6efe6e0268b43485d2a64740ca57d6230efc0bf2915183e234'
  checksum64             = '6b5acee147cff16f23fd6811b9e3f2143a11ce7556ab83ec615eb74242d8ccb3'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | % { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
