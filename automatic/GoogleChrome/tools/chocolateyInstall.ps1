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
  checksum               = '7637dc519e0596d25172ab3fc831639ea11e1a759ed49bf2a2ca344fb30f133c'
  checksum64             = '99a682ada522543bb6d4d17454157a856f1802f5f45fa7ca5b3d2874b0952407'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | % { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
