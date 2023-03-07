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
  url            = 'https://az764295.vo.msecnd.net/insider/bbc87d8ec2453f12c0066e1c30b41cd5bd2aa021/VSCodeSetup-ia32-1.77.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/bbc87d8ec2453f12c0066e1c30b41cd5bd2aa021/VSCodeSetup-x64-1.77.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e2b033c8760cc27c3e92acd4d9e47f8732b369f9a9b3a60d65a20e8303eb58cae83796e721bcc42653bdbc22f5bfae735586c7b35f4ba5dc4687844b6e2bb93f'
  checksumType   = 'sha512'
  checksum64     = '239f1239a29c9a0f223be62f175ce08fb5de531554974c825eb33e35ea8708531ec281f29488a1c22bdedb8f3840cdce4a62b061d55db8ded85d0aeb79b97f21'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
