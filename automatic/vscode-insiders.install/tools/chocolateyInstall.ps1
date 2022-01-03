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
  url            = 'https://az764295.vo.msecnd.net/insider/99305570d885bce929ba8f24d90f2c3ee54c5c2f/VSCodeSetup-ia32-1.64.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/99305570d885bce929ba8f24d90f2c3ee54c5c2f/VSCodeSetup-x64-1.64.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3973928966518bb1a9807f7a72cd02b354f2694a6952b42099f88d7dc66a048efbc5d169fea32d1b9e7456f4d4e392ea2d5d69e40762642d82847d128b82cad2'
  checksumType   = 'sha512'
  checksum64     = 'be45d04eb4c1579dca449053f54eb7cee1420dadd91bea1a4e95b23b5a77fe4aa9bfc94e5e1f697878d837b111ca03df9d9774d73b6c38f2b36b3adfa6e22bea'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
