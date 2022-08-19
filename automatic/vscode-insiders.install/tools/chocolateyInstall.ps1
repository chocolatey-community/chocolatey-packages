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
  url            = 'https://az764295.vo.msecnd.net/insider/28f604dec81b609dd7e69362585f7a99d4c48f88/VSCodeSetup-ia32-1.71.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/28f604dec81b609dd7e69362585f7a99d4c48f88/VSCodeSetup-x64-1.71.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b421fef894bb0951919ddd980c17da8d88733f162f6e4834114a13857dc4bc7a5e62d9a5448955d65754d800e675dcb77bdedb3309ffaf626420c435b7d05b08'
  checksumType   = 'sha512'
  checksum64     = '7283d3ecb62d17cbfa9e373443772072c8c9072ccf95301c94877052c97d24dbbe7b07daa1b3ca5a6e4934d46f9deae1d5e50c85fa3d54c7daab945389641965'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
