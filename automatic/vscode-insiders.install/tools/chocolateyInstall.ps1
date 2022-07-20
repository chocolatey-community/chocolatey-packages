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
  url            = 'https://az764295.vo.msecnd.net/insider/3da2d669a4dcf93938a262ba92f50b128ca7262a/VSCodeSetup-ia32-1.70.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3da2d669a4dcf93938a262ba92f50b128ca7262a/VSCodeSetup-x64-1.70.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2ba78e3ee92ca89cfd271579d229c456b44c43a492ce9f01cb31c38369aafb68f71e62433e9053b3c36b5ac8dc394047c0190507e2c968a486018cffa1b36233'
  checksumType   = 'sha512'
  checksum64     = 'f8f328d6164934fc4a430d2886c69c7b29bf1f2943f1552597522c0de2fc1db143be1592fd4220ea4116808d124817ef8befc2fef23c1e6e899c6a441d750742'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
