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
  url            = 'https://vscode.blob.core.windows.net/insider/5ae522f8563fe48b89470923f77a9732f96c0472/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/5ae522f8563fe48b89470923f77a9732f96c0472/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'cf172a76c6da7777d76d2e988c962df25fac5a90cf857ded45a0b9f51f668b583093907006a982c473ca02fce48ca5414598f77be8050756b8256da268ca0326'
  checksumType   = 'sha512'
  checksum64     = 'b79555a4ca9804ca1e85cbc2c3ca5d71c06e40bb3f9d567900212b1f01c2fc31a2ed849c65401cd19f921e3acfb6d8fd4f78b12e4bddb42da73dd914286eb392'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
