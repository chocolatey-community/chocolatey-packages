$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.3.4-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.3.4-Win64.msi"
  checksum       = '2E9EB1AA0592E7CE135188C91FE404E075F138FD3F48A95552EC1B75D72798C5'
  checksumType   = 'sha256'
  checksum64     = 'A3DB8244E4EA142EB79FEDDA7EFCFBD738E7C9E05407B8A25F35948D17D1F63D'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$fileType | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
