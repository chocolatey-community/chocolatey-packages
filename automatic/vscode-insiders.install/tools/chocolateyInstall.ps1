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
  url            = 'https://az764295.vo.msecnd.net/insider/f11635ef1199ba5c43d9b83bb8b33036ea26d5b1/VSCodeSetup-ia32-1.52.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f11635ef1199ba5c43d9b83bb8b33036ea26d5b1/VSCodeSetup-x64-1.52.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e793d2cbe00bec221daac8d1de84c4bd6a32c2b2ed4d46682ef133797b856b93e2a902f954b5e631bf9fd17095500ad295a4243d136f867667adaad07c616dc1'
  checksumType   = 'sha512'
  checksum64     = '57e1c89bafcf16a8d169253fd2588c4ce7d00049ff19642153c4fb61d241222bcc49fb54e20e89a9be1c7b78c2cac637ab428cd2b33cb1ffd57f806dc1244b1c'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
