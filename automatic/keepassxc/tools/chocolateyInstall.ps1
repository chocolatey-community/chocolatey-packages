$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.5.0-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.5.0-Win64.msi"
  checksum       = 'F462D780955EE63324EAADE16489B960B58A24559F3E38F31EF1EFF2E9D8BD02'
  checksumType   = 'sha256'
  checksum64     = 'DC7190DA9BB2E91AEDD105ABD7D78C61B8F184764DE11BB4EE8BB640A1C77BE7'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
