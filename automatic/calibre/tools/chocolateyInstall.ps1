$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/4.11.2/calibre-4.11.2.msi'
  checksum       = 'AFE5CF7BCDED460981A2A60B4AA65D0777B766A6E17DC2652B038DA7091720CF'
  checksumType   = 'sha256'
  file64         = "$toolsPath\calibre-64bit-4.11.2.msi"
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

if ((Get-OSArchitectureWidth -compare 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item -Force -ea 0 "$toolsPath\*.msi","$toolsPath\*.ignore"
