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
  url            = 'https://az764295.vo.msecnd.net/insider/d817eda05fc021eefb82d24e4d95554c043b6ec7/VSCodeSetup-ia32-1.62.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d817eda05fc021eefb82d24e4d95554c043b6ec7/VSCodeSetup-x64-1.62.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7cda36fc44cefb22ae984b2598eb76a6c13f918e953731d20e12fcb6b3bd210e1bf2ba5ec1c5b1d77ad90953ce87affb2199414502afd9a8028826acf74e1113'
  checksumType   = 'sha512'
  checksum64     = 'e341d917c3453a89d3ba7fb7d0f878a77ae21302272a2cd7bd4e540990c49a55603876d21b5d7b4d65542e80a60bc263af922fdd1922b874f19cacfcd15f5455'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
