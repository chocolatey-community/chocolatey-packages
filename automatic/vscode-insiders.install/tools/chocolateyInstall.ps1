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
  url            = 'https://az764295.vo.msecnd.net/insider/23a2409675bc1bde94f3532bc7c5826a6e99e4b6/VSCodeSetup-ia32-1.56.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/23a2409675bc1bde94f3532bc7c5826a6e99e4b6/VSCodeSetup-x64-1.56.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'f80c4dfdd239e0792fb6ff6616385cf0f3b2dd9557bc950c298dbe29ee71d36de8567d5b817e247811ab22fc16797d6abcb4baf09ce12ab8ab87c3848b705b46'
  checksumType   = 'sha512'
  checksum64     = '1db7e085d4ef2004bda35daca44bde09e7bcd66252c20ec94c0fa3378a45957a4731c9b8541d29f27950f91e27964b041f71dc434e66308abdf72be61bffa7d6'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
