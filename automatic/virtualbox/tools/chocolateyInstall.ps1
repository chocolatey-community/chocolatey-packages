$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\oracle.cer'"

$packageArgs = @{
  packageName            = 'virtualbox'
  fileType               = 'EXE'
  url                    = 'http://download.virtualbox.org/virtualbox/5.1.8/VirtualBox-5.1.8-111374-Win.exe'
  url64bit               = 'http://download.virtualbox.org/virtualbox/5.1.8/VirtualBox-5.1.8-111374-Win.exe'
  checksum               = '12860b5bd923878d2ac21c6d2f2c431e65ceb204bdab51bf2872155ccb040af1'
  checksum64             = '12860b5bd923878d2ac21c6d2f2c431e65ceb204bdab51bf2872155ccb040af1'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '-s -l -msiparams REBOOT=ReallySuppress'
  validExitCodes         = @(0)
  softwareName           = 'Oracle VM VirtualBox *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
Install-ChocolateyPath $installLocation
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $packageName install location" }
