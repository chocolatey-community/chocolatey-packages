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
  url            = 'https://az764295.vo.msecnd.net/insider/45b31e9a872da8cc3cc8fff41c1eeb2063be04b7/VSCodeSetup-ia32-1.80.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/45b31e9a872da8cc3cc8fff41c1eeb2063be04b7/VSCodeSetup-x64-1.80.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '228ed0c5fa45e9d6071b2d88ce7ea44cac12f9d9ac71ea372452003c9f89011e3df1bd37f154acac42387a0a10e5073802a76be09d6df2158540d3fc374a4095'
  checksumType   = 'sha512'
  checksum64     = '1d9ab3013913963c4870a0eaca870e710580127565cc029ff4756a1f661e4bcb06ad7e1386826914d6c62911ba095b3987a5004fe3f9b4feee0e7e236890540d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
