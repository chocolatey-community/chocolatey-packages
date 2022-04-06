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
  url            = 'https://az764295.vo.msecnd.net/insider/f050b17dacedba13962244b13c70084a473d08f7/VSCodeSetup-ia32-1.67.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f050b17dacedba13962244b13c70084a473d08f7/VSCodeSetup-x64-1.67.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '64e4c19ba2d55dfe6dfb144811b3f418b9df33144ce9ac4a4dcc43523ce78b1de5f3b54800d348ed682581e576d456ad82c64a1331b51992139c98f2b514a98f'
  checksumType   = 'sha512'
  checksum64     = '15524023bbe7f5287ecf7e66a8ccfae09c2322e4f26019de98817b1f99237cdd67179ffc9c57adfb553303bb95261a8bd42c3c701ef692f8e2c698ce979ebd37'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
