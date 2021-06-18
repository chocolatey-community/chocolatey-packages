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
  url            = 'https://az764295.vo.msecnd.net/insider/7dea6d7402b55671410a129661cad24b55aed9f4/VSCodeSetup-ia32-1.58.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/7dea6d7402b55671410a129661cad24b55aed9f4/VSCodeSetup-x64-1.58.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3a78460be543a42b14c740b9964b81716b2239a891eb2b2372247c38be97e538f42acb457e0a55411f24c96b9a036ed05c83d9637e9d53c0e9690ed9dcc4e46a'
  checksumType   = 'sha512'
  checksum64     = 'd034f87577c27a59c1282dc083134d39866aa6c4a014100e16619ca0398536cf3289fc465be0a7788aa2ecdc7943f527e69a23c508ef2f479497d46fafbe329e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
