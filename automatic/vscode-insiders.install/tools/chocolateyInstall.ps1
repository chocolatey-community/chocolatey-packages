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
  url            = 'https://az764295.vo.msecnd.net/insider/3bd29c1d6c6ef5b6265614def99b7257b671ae19/VSCodeSetup-ia32-1.63.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3bd29c1d6c6ef5b6265614def99b7257b671ae19/VSCodeSetup-x64-1.63.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'fc53176d08c474a2c758af95b1dc78f2bd3d98c5ba817ca7161c1911c6aa0a407127475e7d3686d525aea160c20c35ba807869943115db8ec69c26d2a6eea8b4'
  checksumType   = 'sha512'
  checksum64     = '08d7713c51daa3f95101f3d3fbeda1d36a0c2e91f8639a6d36160d94929d193832530de84596b7269a07dd8e993774caadcaffd5296dad3d1f5436732c2f59d9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
