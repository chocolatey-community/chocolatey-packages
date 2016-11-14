$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'nomacs'
  fileType               = 'exe'
  url                    = 'https://sourceforge.net/projects/nomacs/files/nomacs-2.4.6/nomacs-setup-2.4.6-x86.exe'
  url64bit               = 'https://sourceforge.net/projects/nomacs/files/nomacs-2.4.6/nomacs-setup-2.4.6-x64.exe'
  checksum               = 'a54c99d23b24f235a77f9abe387bd049bd52720d22693a27cae7fd4f84ae5f17'
  checksum64             = '4ffb9f4571d321e1476dabdaa61260d83403c9e10be995a051b0bce33d1a1f9f'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "--script `"$toolsPath\install-script.js`""
  validExitCodes         = @(0)
  softwareName           = 'nomacs*'
}
Install-ChocolateyPackage @packageArgs

#$packageName = $packageArgs.packageName
#$installLocation = Get-AppInstallLocation $packageName
#if ($installLocation)  {
    #Write-Host "$packageName installed to '$installLocation'"
    #Register-Application "$installLocation\$packageName.exe"
    #Write-Host "$packageName registered as $packageName"
#}
#else { Write-Warning "Can't find $PackageName install location" }
