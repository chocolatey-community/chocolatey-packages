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
  url            = 'https://az764295.vo.msecnd.net/insider/f3e95ede9e4b9818c29a5bca3564d6fd162fb210/VSCodeSetup-ia32-1.53.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f3e95ede9e4b9818c29a5bca3564d6fd162fb210/VSCodeSetup-x64-1.53.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd7388cebfaea4e391398502fd9b8752b992d3952e4265b0d2ddab9522d4bedccb32c644aa7cbf9ea5f8afc82022c0a06b4584b4e8c1d2c75da46122dc1cdb592'
  checksumType   = 'sha512'
  checksum64     = '06a54836534e0fd8a87be1b7b6a22d9a14bef27623da83320e148230876b160e488fd936bd3cb0df3f6a7ef5624ddbae120c4147504fb1396f7c79c921b241b2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
