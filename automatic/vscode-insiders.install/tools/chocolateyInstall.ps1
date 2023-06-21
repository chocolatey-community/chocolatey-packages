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
  url            = 'https://az764295.vo.msecnd.net/insider/636dbcff557af8aa088ae118b1a094dce6632ce7/VSCodeSetup-ia32-1.80.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/636dbcff557af8aa088ae118b1a094dce6632ce7/VSCodeSetup-x64-1.80.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '8be494ba77229395fd0a680d8a4bc405b0146aae6e0baa742cfb39fbe8bafb46e04006fb375bd6f2ec5573cbca1675082b81e219892f81303921de42a9f384ec'
  checksumType   = 'sha512'
  checksum64     = 'e64204b8d8e6e929390962ebb2074189d8121f51c85ff96f8f90a639bb2a87555deabc406d87ff79c69cd6c3ed90f504e7d6abc75d09e826c48fe986ced4638f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
