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
  url            = 'https://az764295.vo.msecnd.net/insider/9fb452c4852ef098206ec67a2b236ad5fd0ba828/VSCodeSetup-ia32-1.72.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/9fb452c4852ef098206ec67a2b236ad5fd0ba828/VSCodeSetup-x64-1.72.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b01da4cba834786445966b396e16b9b00b3bac1ea55b7c728cbec3c47d9e158ce4cf8b0a5d7c5c4397059881fc18f52f5862333f7554ceee0729324a75bb2bec'
  checksumType   = 'sha512'
  checksum64     = 'ec25e0fe35ae0c9476df9870092a91293e2aa7c1dbeec3018b8bc7b730dff1ca193ef70fb2ac8f3a4e4c46217aa4667b585d5142a83d08b3a32030f43d5a68cb'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
