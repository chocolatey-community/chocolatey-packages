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
  url            = 'https://az764295.vo.msecnd.net/insider/333754f29b719f605904f072b13c054c2231b9bd/VSCodeSetup-ia32-1.72.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/333754f29b719f605904f072b13c054c2231b9bd/VSCodeSetup-x64-1.72.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '823dee60b1f7a830a0d658da24ef5509558773c73481e57ef2b0bd90cf2d526f24f6ba37857f979c08f6e1f42bc5fd066810ff50005c481a9eab7ff00b38817a'
  checksumType   = 'sha512'
  checksum64     = 'ebdd4b13290161a1d3b4cb86da3401d8d885fcafddd342c9bbcf546767f77a3b75b49da0a3b9da547ff76dfede813ee58f627577f556a32db85b6939f93dc63d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
