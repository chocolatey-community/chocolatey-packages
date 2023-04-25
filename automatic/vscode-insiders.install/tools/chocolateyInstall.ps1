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
  url            = 'https://az764295.vo.msecnd.net/insider/2902f278ad8e2d830fa6883d3d8fd7b5c2ca59e9/VSCodeSetup-ia32-1.78.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2902f278ad8e2d830fa6883d3d8fd7b5c2ca59e9/VSCodeSetup-x64-1.78.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6fc8a6b31e6aac97682b37c2b54fd0be2c41f300a8806fd1983e34cc93cfa641a5de086e246e2d6412d856470883e26bd8f5cccb3c7b412762e92a814213e5ea'
  checksumType   = 'sha512'
  checksum64     = '5cdb20b2f725387dc4ab90ef2be32320c5984f7f5eaddc4665fe6ea08cfb44829f862126e0fb9acba1af63ddc0f0126629e571d7a9f8a53cb16a5165ed31786b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
