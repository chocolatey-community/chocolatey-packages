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
[array]$key = Get-UninstallRegistrykey $packageArgs.softwareName
if ($key.Count -eq 1) {
  if ($key.DisplayVersion -eq '') {
    Write-Host "Software already installed"
    return
  } else {
    Uninstall-ChocolateyPackage -packageName $packageArgs.packageName `
      -fileType $packageArgs.fileType `
      -silentArgs "$($key.PSChildName) $($packageArgs.silentArgs)" `
      -validExitCodes $packageArgs.validExitCodes `
      -file ''
  }
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "This will most likely cause a 1603/1638 failure when installing InkScape."
  Write-Warning "Please uninstall InkScape before installing this package."
}

Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
