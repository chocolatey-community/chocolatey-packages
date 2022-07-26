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
  url            = 'https://az764295.vo.msecnd.net/insider/cc098faebd320a2eea3da6ae154b7e2e1347a4b9/VSCodeSetup-ia32-1.70.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/cc098faebd320a2eea3da6ae154b7e2e1347a4b9/VSCodeSetup-x64-1.70.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd0227879a8f30cdf83aa43271807aa805fd8a89bd7ea59088dd9e6baaf5092a9a2d7148609815d9edf9252862fb95de8c0d02981c9ce384724cb50ab1c352016'
  checksumType   = 'sha512'
  checksum64     = '2d6758881dbe2e9a2b9fffbf26d700aaddf2fbbfb44923c107015aeea161af10763537d8eb31b6b1ffca7db86e43ce56b6ff517c85476988fee07f77a7981cbe'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
