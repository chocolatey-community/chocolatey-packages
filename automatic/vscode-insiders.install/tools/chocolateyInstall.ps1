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
  url            = 'https://vscode.blob.core.windows.net/insider/af4a70d991053dcbf64d9a86c76a02dced81d9c4/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/af4a70d991053dcbf64d9a86c76a02dced81d9c4/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b7f3b878846127818cb2ab5c1a9cd33748941ecd432c7269fd3cb2b8ff374ace26cb3c1c33f78ad4f9b7e640af8954eb52eb0e738aea4029cd61dba83b86a5bb'
  checksumType   = 'sha512'
  checksum64     = '3938e095dd173720e33f28341497f651b76783b44eebbf4f03e4c24aacb885b730188ff9c1c5f00e7464ce0e7cca4dc4cc68b466dd017e8a3b064a302915245b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
