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
  checksum               = 'd694afafd94857bbcbdc8afe613f3f76946d3164b63adaf1224b984b4b64d1f1'
  checksum64             = '6c1b0f159a355f4a63cfbfa449eafe929c89fc2346149eb34e171368920077be'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
}

if (Get-Chrome32bitInstalled) { 'url64bit', 'checksum64', 'checksumType64' | % { $packageArgs.Remove($_) } }
Install-ChocolateyPackage @packageArgs
