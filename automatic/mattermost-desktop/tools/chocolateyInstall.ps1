$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-4.4.1-x86.msi"
  file64                 = "$toolsDir\mattermost-desktop-4.4.1-x64.msi"
  checksum               = 'CA29FE2D9AFEADFB5CDDA1C56D8AACE57392BFC6AF56337A5CBFB0E05C1CCB9D'
  checksum64             = 'FE8A76ABE3E98FE5C64004AB26AAB764DD393C48C74503A6DF4510D667FE409A'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
