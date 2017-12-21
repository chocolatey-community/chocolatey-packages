$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq '8880a2309be334678e3d912671f22049c5a49a78' }
if (!$cert) {
    Write-Host 'Adding program certificate: sysprogs.cer'
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$toolsPath\sysprogs.cer'"
}

$packageArgs = @{
  packageName    = 'wincdemu'
  fileType       = 'exe'
  file           = gi $toolsPath\*.exe
  silentArgs     = '/UNATTENDED'
  validExitCodes = @(0)
  softwareName   = 'wincdemu.*'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}
