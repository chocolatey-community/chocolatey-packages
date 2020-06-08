$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.6.0-beta1-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.6.0-beta1-Win64.msi"
  checksum       = '021167A1FF4978E8427B112DF88C236FCD7E5F00844794A646D3D2D07544A230'
  checksumType   = 'sha256'
  checksum64     = '9F6FD3C1B3E9186EC88686AA7DDF196A421496205699759A1682A6B15B2A50B3'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
