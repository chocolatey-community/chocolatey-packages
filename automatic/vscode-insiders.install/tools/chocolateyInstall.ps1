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
  url            = 'https://az764295.vo.msecnd.net/insider/11cd76005bc7516dcc726d7389d0bce1744e5c85/VSCodeSetup-ia32-1.54.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/11cd76005bc7516dcc726d7389d0bce1744e5c85/VSCodeSetup-x64-1.54.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b040994aaf37d5bb1b8cf56113cb853bb61a6fb55d4d70bc91d19405ea8831c052e83d073e2d090bfc8f75e9dc913ee729ed4d7ffc0b3e2e8a587bd86659ce08'
  checksumType   = 'sha512'
  checksum64     = '5304cc5addac94e72848680d3784d9f518ecc5f00536b59669398e010ae33a98d03a6e3371223396d4b76b9e6251002242e04cae18fe7a2451003e6b0b884e95'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
