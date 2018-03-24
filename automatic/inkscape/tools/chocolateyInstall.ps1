$ErrorActionPreference = 'Stop'


$packageArgs = @{
  packageName            = 'InkScape'
  fileType               = 'msi'
  url                    = 'https://inkscape.org/en/gallery/item/12193/inkscape-0.92.3-x86.msi'
  url64bit               = 'https://inkscape.org/en/gallery/item/12190/inkscape-0.92.3-x64.msi'
  checksum               = 'c64f3de51ff87e50b24ba82ee3b7275b80a71ba167e000ef9accaeb08543dd17'
  checksum64             = '1d2f4d9edf221fe9dd1ad75c4a48c8809dd3adf5af0fb672f1383088b163516e'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/passive /norestart'
  validExitCodes         = @(0)
  softwareName           = 'InkScape*'
}
$current_version = Get-UninstallRegistrykey $packageArgs.softwareName  | Select-Object -Expand DisplayVersion
if ($current_version -eq $Env:ChocolateyPackageVersion) {
    Write-Host "Sowtware already installed"
} else { Install-ChocolateyPackage @packageArgs }

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
