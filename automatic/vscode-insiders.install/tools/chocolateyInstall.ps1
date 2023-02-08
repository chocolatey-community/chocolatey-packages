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
  url            = 'https://vscode.blob.core.windows.net/insider/a7d49b0f35f50e460835a55d20a00a735d1665a3/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/a7d49b0f35f50e460835a55d20a00a735d1665a3/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd955d77d4fce6c0f866f5fe41b19399d369687c17fc9e169269b81653aa26137d16c14cdf8e42d744dadbaa7e4603d34e22d888a80a0a394edee7c2063f2222f'
  checksumType   = 'sha512'
  checksum64     = 'f1f2780f31e250c9240066d4af80ba5b2516ece9d28ae68546e9ed4df427dc0a93adf758f0fc86e9040a3d129144a50e04a514a6adfb98ebb92b3d4860ee1c42'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
