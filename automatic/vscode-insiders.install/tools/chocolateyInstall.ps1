$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

Close-VSCodeInsiders

$pp = Get-PackageParameters
function Get-MergeTasks {
  $t = "!runCode"
  $t += ', ' + '!' * $pp.NoDesktopIcon + 'desktopicon'
  $t += ', ' + '!' * $pp.NoQuicklaunchIcon + 'quicklaunchicon'
  $t += ', ' + '!' * $pp.NoContextMenuFiles + 'addcontextmenufiles'
  $t += ', ' + '!' * $pp.NoContextMenuFolders + 'addcontextmenufolders'
  $t += ', ' + '!' * $pp.DontAssociateWithFiles + 'associatewithfiles'
  $t += ', ' + '!' * $pp.DontAddToPath + 'addtopath'

  Write-Host "Merge Tasks: $t"
  $t
}

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  fileType       = 'exe'
  url            = 'https://vscode.blob.core.windows.net/insider/853b32bad26ed5ffe2d29b95be45adc7f753e35a/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/853b32bad26ed5ffe2d29b95be45adc7f753e35a/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '8b170212aa6e76f655f2bc50e59f9d0f710c68cde6b058de9a309d0b50272d7d49bad8639b667e5c2bc2c6205b151b91741013cf92d32caf560ac0f48c81b4bb'
  checksumType   = 'sha512'
  checksum64     = '563f9aa241834209203f7de1f8c1d516fb4fcfc12eb203f159c53ba225c8676d3989c237098a941823065cfa7ec2cd8ec3557df851a3877077dfb9aa1d1781b5'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
