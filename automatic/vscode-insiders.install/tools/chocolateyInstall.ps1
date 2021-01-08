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
  url            = 'https://az764295.vo.msecnd.net/insider/0949d5b794f4f42fb4dbc3d0edc1d33b8b70ab21/VSCodeSetup-ia32-1.53.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0949d5b794f4f42fb4dbc3d0edc1d33b8b70ab21/VSCodeSetup-x64-1.53.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '97d3e86f1ab8a56cf01f6c4cfbfc36e37e4f8351490b66b513c4d99196fc168f19169b0618d5fb2117b985ab16895195a9c0c18c77e496ad157d8e25aa3bdf3e'
  checksumType   = 'sha512'
  checksum64     = 'b956242c5f130a8ca8fe31daa74e287a7107a453ff9bf8a560a66eb6a465881996311a3243ec37ad7dddccddfb2f50557cfddd245ff17635b88ca8942a23e2ae'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
