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
  url            = 'https://az764295.vo.msecnd.net/insider/71ca6e8e74591ae5c577d52a2aa1bd0c3df5ac32/VSCodeSetup-ia32-1.61.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/71ca6e8e74591ae5c577d52a2aa1bd0c3df5ac32/VSCodeSetup-x64-1.61.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '74998e7cc0cd7378ac54866f6de828c71eea04d5cf6c8e0ab33a81c7565d1caefb522e06536dfdeadd07d592c856925e3f383904ace5f2638bbc45963c3fc2e7'
  checksumType   = 'sha512'
  checksum64     = '5f2636a9925b7bfbc61c9a725dcff845d4192d1864cf11d4fc4d2758ec85bde96e5eef6d5c7e2d0049715f4a76c884595f15f0f3be4ab4dbec4f41ea01c486cc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
