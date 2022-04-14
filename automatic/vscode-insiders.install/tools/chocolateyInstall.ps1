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
  url            = 'https://az764295.vo.msecnd.net/insider/a7a7f209ade96c516ce3cd9b330aa8c3db816223/VSCodeSetup-ia32-1.67.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a7a7f209ade96c516ce3cd9b330aa8c3db816223/VSCodeSetup-x64-1.67.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '872aa009309c0e5bab46557ac19e3d2c9a89597e2f0bc6462cfda6731623fa6c507cefabe581abc1d5bc11fc0c33cb00a775fc7d281d89fcaaf7d41174ea9513'
  checksumType   = 'sha512'
  checksum64     = 'c6c5ebe28600c1007e9937e80465d24569b388b9982efc8fa1566008dc44304ca414db0272612d4bac4b9c62091ab06ead0975cd6eaae9081858180f3af53549'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
