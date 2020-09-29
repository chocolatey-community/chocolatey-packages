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
  url            = 'https://az764295.vo.msecnd.net/insider/0580328b728a69768558cc8242067cae7b6a1c21/VSCodeSetup-ia32-1.50.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0580328b728a69768558cc8242067cae7b6a1c21/VSCodeSetup-x64-1.50.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '1e6d7a890cd97528d4f4be649fbcb13fc1bf74014908d34375d4f74d13beb403d901b6d12b1cacd2177ca33573612d480134fd0c3bf78e909bf6dd7122feea69'
  checksumType   = 'sha512'
  checksum64     = '322cf04bd64fa6e8be27fc6221dd48942c9ec1b36c44a91423285f1660bea1692807aa96a929219c4043dcdee59fdad0cfc26278e708b5185063432bf6df2b98'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
