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
  url            = 'https://az764295.vo.msecnd.net/insider/d54f7e1f6c1290fe27e2397eca509d0e0728272e/VSCodeSetup-ia32-1.58.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d54f7e1f6c1290fe27e2397eca509d0e0728272e/VSCodeSetup-x64-1.58.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2a977c8ec02778907b8e632eddfd6c673c8bec505d299d1b053daf942e282b1fd165cd47f5817c6bf59148f50e515a07dc5ceaa5d446f55541602d27629f5bc8'
  checksumType   = 'sha512'
  checksum64     = 'd3e1e70c1e92b2dd48330dc9300af4a17eb3c43a2354f2e6be2ff405d68c0f6d8f17ecd0320b4f8d5ed9152f473dd2055165b947d66792fe5bb76f132f2ed5db'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
