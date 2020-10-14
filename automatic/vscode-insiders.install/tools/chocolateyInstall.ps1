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
  url            = 'https://az764295.vo.msecnd.net/insider/bc20f53838c75c0ec473b2a1afa7423cc5bcf7ab/VSCodeSetup-ia32-1.51.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/bc20f53838c75c0ec473b2a1afa7423cc5bcf7ab/VSCodeSetup-x64-1.51.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3ac1df2cb7e6ddd357265b0fa6d3ddfbc0345a849c6ab9a215be1cf37f40c7e575646315d33815969d61d2e96641a38d8752b16d04fd6dcbb9755e82cffa8a04'
  checksumType   = 'sha512'
  checksum64     = 'd5a1dd7b7325b66543ab909db6955141425b8114429bf437b44ab8a93c5420985b6d9a2ea700a174e780f5d570da75dd4111fcd71d533f93c45d45ae7c00f527'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
