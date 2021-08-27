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
  url            = 'https://az764295.vo.msecnd.net/insider/6a2daec767703dad42461333fbf8666aa481a32b/VSCodeSetup-ia32-1.60.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6a2daec767703dad42461333fbf8666aa481a32b/VSCodeSetup-x64-1.60.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'a581ff8e2bfba23ec192a8c133f7b4cb924f6b76cce467c46a73f1ca97e35c0caa559b3c59e991367fd50208f2b3675e9ac5fc79ed73181958a2d23720c1c805'
  checksumType   = 'sha512'
  checksum64     = 'de92b3c3245c603122f39d7a0ac1930d41e829b67a7079e8b476f39f875f35c6c9e7df4dbc76398f6b3fd9023dbad93c87d26b690ce01e1b472c9cd22c4fb592'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
