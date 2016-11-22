$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq 'a88fd9bdaa06bc0f3c491ba51e231be35f8d1ad5' }
if (!$cert) {
    $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$toolsPath\oracle.cer'"
}

$packageArgs = @{
  packageName            = 'virtualbox'
  fileType               = 'EXE'
  url                    = 'http://download.virtualbox.org/virtualbox/5.1.10/VirtualBox-5.1.10-112026-Win.exe'
  url64bit               = 'http://download.virtualbox.org/virtualbox/5.1.10/VirtualBox-5.1.10-112026-Win.exe'
  checksum               = '24193297a1d6ed14450c9569955768421ec433e5f93a02a5aa9a8c9214a080ed'
  checksum64             = '24193297a1d6ed14450c9569955768421ec433e5f93a02a5aa9a8c9214a080ed'
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
