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
  url            = 'https://az764295.vo.msecnd.net/insider/e1c818a171168eedf78b62fdc7f4e3458d5dea7c/VSCodeSetup-ia32-1.53.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e1c818a171168eedf78b62fdc7f4e3458d5dea7c/VSCodeSetup-x64-1.53.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2c710b3f99544928b85837f713b0439a1985310a59c291af021fc3594c4c41800ffe447b9a428fff9ba76edfe1410d2de5cd4e7c4cd1f1f0a0ceee469bb6748a'
  checksumType   = 'sha512'
  checksum64     = '310a60e1372837f2dd183bc221ddfcf5dd21667f867f175b867afb7d015902cf502b0650a5ca683f1e28e3c251851f48d7e481512ae352e5f6c626c96cc976a1'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
