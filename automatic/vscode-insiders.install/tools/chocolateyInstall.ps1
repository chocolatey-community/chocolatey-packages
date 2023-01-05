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
  url            = 'https://az764295.vo.msecnd.net/insider/79c4f9b75db3b4f50468fc022cacf8ba6d640aff/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/79c4f9b75db3b4f50468fc022cacf8ba6d640aff/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '792b3657714f1731ff74918deacdea2c4ba89e4894e60012be57ecebf26d80b9a8c29ac78eadcc096af155da8833abcf09cfa86e581c8d60c65746bf05146391'
  checksumType   = 'sha512'
  checksum64     = '388a6dcd5ef7530b1acd6711113880e35794b204ff2a8a28b176e0ab7533ad9be840ba839bfc5185a4f3d68f0c1d4934f02e8d1ce70ab7b7e9c97030264f5bf2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
