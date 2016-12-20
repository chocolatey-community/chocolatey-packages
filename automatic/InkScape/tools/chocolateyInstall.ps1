$ErrorActionPreference = 'Stop'


$packageArgs = @{
  packageName            = 'InkScape'
  fileType               = 'msi'
  url                    = 'https://inkscape.org/en/gallery/item/3950/inkscape-0.91.msi'
  url64bit               = 'https://inkscape.org/en/gallery/item/3956/inkscape-0.91-x64.msi'
  checksum               = 'f197b84d59f04f484c6cf07f6bb2a831573d4d9ec5e650aa396e6281b66c99d5'
  checksum64             = '0f365282d8a4aec935099ee4038acdabda7fffa6fbdf5fe66969b4de6b25186c'
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
