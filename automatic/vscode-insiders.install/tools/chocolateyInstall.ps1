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
  url            = 'https://az764295.vo.msecnd.net/insider/7f329fe6c66b0f86ae1574c2911b681ad5a45d63/VSCodeSetup-ia32-1.77.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/7f329fe6c66b0f86ae1574c2911b681ad5a45d63/VSCodeSetup-x64-1.77.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b96c207ae7d9697524459567f5aef082fb8100753870eb5973582b857123319033f8db3214069e1c41ac11488036b2f06fd4f6b3dbbddd82d23cee9405ad36c7'
  checksumType   = 'sha512'
  checksum64     = '33dc313bbdf52f0449aad2184cf52b79deb3480e9a7541ef8d6918ca411c92e8545052b7307916c9c74bcba0a144663010815340316c2a56521b52898f3f32f2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
