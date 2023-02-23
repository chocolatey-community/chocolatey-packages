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
  url            = 'https://az764295.vo.msecnd.net/insider/d0acdbff1f30eac7cc68930013485276d1bae0ec/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d0acdbff1f30eac7cc68930013485276d1bae0ec/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd275308e16c00adf7a872f44b189ff2e7470c4f005a9468dbe1e4d75e3479ee71febea2041b19b9c4f6e5a201b1cfe8530f2a1243afc500cd65bc8cd9bc69494'
  checksumType   = 'sha512'
  checksum64     = 'a6eba0e7830b2eed787b64d405450601fd6d4b40ba39be58ed26fb162233cc1f65a608bbede2b9520f653d19a79170b89e7b6d0a8adba6646655c3e602c13a27'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
