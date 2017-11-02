$ErrorActionPreference = 'Stop'


$packageArgs = @{
  packageName            = 'InkScape'
  fileType               = 'msi'
  url                    = 'https://inkscape.org/en/gallery/item/11266/inkscape-0.92.2-x86.msi'
  url64bit               = 'https://inkscape.org/en/gallery/item/11263/inkscape-0.92.2-x64.msi'
  checksum               = '665507b85422f25350736b8b47a50931521bc7e2bed059f51714177338617d70'
  checksum64             = '23599c558fae220d12ca34b003d209ec486d4b8e1daf78856808a82275805b80'
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
