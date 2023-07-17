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
  url            = 'https://az764295.vo.msecnd.net/insider/02d3b49d8035a9b30db3b0ae706796af9b1a4260/VSCodeSetup-ia32-1.81.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/02d3b49d8035a9b30db3b0ae706796af9b1a4260/VSCodeSetup-x64-1.81.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'cba008c12f5e66b97542bcb43d95c52b3a8057e142a06d7afff727302c774f26f637677e595e7ba5b8dd0f41f779eb5d69228a1b712c003ae7512e2df3498e65'
  checksumType   = 'sha512'
  checksum64     = '173026bd10cb004ee2cbd14e3a5808bb5aeff14da7513b95480a8c2b75e47f9de517a34f624c4d5a3e4f070d99501a7598ab7f0ecae9a277f815686d52df7096'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
