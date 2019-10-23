$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-v4.3.1-x86.msi"
  file64                 = "$toolsDir\mattermost-desktop-v4.3.1-x64.msi"
  checksum               = '6BBEAA6DF08E74A2ECE43B30963ACB48A7421B12A80B684704DEF0A6D3F1A953'
  checksum64             = '0142D51D0812C7CE994539CF69DE8D4723DEA743EC3A1D22316D429B9420D113'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
