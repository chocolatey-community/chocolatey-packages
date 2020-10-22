$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.6.2-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.6.2-Win64.msi"
  checksum       = '8864F3E19DEBCBE22997EAFB3B32F7B07CA355DFC8BF735667A46BBF0AD68B6D'
  checksumType   = 'sha256'
  checksum64     = '3B95A44ECAC25DF638323C7B75789EB14497DB50D25B67C90B170C2BA4B5FC85'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
