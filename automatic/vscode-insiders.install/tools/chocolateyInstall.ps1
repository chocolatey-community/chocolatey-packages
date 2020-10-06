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
  url            = 'https://az764295.vo.msecnd.net/insider/2ccf79510abf8f5129c18a37432d295278525157/VSCodeSetup-ia32-1.50.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2ccf79510abf8f5129c18a37432d295278525157/VSCodeSetup-x64-1.50.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '763fe346770a4f30368a5cd4900a8af21d93da0a8e9455e796fc704f871d41c418c0e3e8b1d92125b77a94c63baf1903a2f7bc752c3327fcebcb48f9d4f08d51'
  checksumType   = 'sha512'
  checksum64     = '533797f4bdadb98aa60bb27ad2dea1b4afddb35e6143ec6c619e5e009ad7097f76b92118f91235d9766b4f835622ea26b0f100f8d578b45eadd81d97a44013c1'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
