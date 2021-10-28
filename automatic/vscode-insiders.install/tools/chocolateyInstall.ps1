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
  url            = 'https://az764295.vo.msecnd.net/insider/f961b92f0faec5c68124ab4d89922d38cf6f513d/VSCodeSetup-ia32-1.62.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f961b92f0faec5c68124ab4d89922d38cf6f513d/VSCodeSetup-x64-1.62.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ec7bfb6627315e892f3fad280c8b91d66866e05869f79b4710b371d141d11587319783fe259eb4ffa1cb9277d8e36128fd22f0fdb5aa3dab7d21594d99398c49'
  checksumType   = 'sha512'
  checksum64     = 'a16e9e1248a3b29b998b5b7ccbadb1b8d624df61507ea5883b72d011919d14c55bc603e331af802fef9f925950374878014713d2efe2cec19e625e607bbded80'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
