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
  url            = 'https://vscode.blob.core.windows.net/insider/c9e3ef865539061b5602c6b9ac6030332aa1ce70/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/c9e3ef865539061b5602c6b9ac6030332aa1ce70/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '0a28e473993305c71eb4fdc3aca21092006db49b5c0a3d197066db367ab127e1ed5f1c723e269e50df63d6e439f3f011147fa40fd4f346b65adccae8ddbd45a5'
  checksumType   = 'sha512'
  checksum64     = 'a58128e55580cc29af97ba845908d08e82f1ea32bcfedbaa6cd6c7b56f7029c177ca5271d75610acb4070fa5e1ccf614e6b4d57b184d17cff97c32ff09dbcd45'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
