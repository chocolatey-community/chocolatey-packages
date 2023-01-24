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
  url            = 'https://vscode.blob.core.windows.net/insider/0a6c277e4faa44a6b6eb82ddca8bfeccf7fecef6/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/0a6c277e4faa44a6b6eb82ddca8bfeccf7fecef6/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'bb0688235151a42a680999871ec0b62d92e133ae187d82f38e064c6ffc8a161a101aee75874b7975847dbfd02999818be6d9fa5d8c989ea6a108a990c7295462'
  checksumType   = 'sha512'
  checksum64     = 'f08480ccb3cec5f27372fa54e5098dc3d4d8aacff4d89654b858ff643b1957855b537c0fe625b08f72f727fc03d4596ca6d7c6395b6b8ccd83475223aaf685ed'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
