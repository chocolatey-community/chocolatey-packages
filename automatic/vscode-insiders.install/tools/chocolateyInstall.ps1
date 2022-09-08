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
  url            = 'https://az764295.vo.msecnd.net/insider/2d27f8db6a19f93529787731b0efa8f001478f6d/VSCodeSetup-ia32-1.72.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2d27f8db6a19f93529787731b0efa8f001478f6d/VSCodeSetup-x64-1.72.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '1a7358e76f5b6e140022aa793717bf86875892e7cd8ac19291322cc4fe1a790383b4e9cea4bcc0f60ea0e3bdd0729887e877e94894f4ecad42fed72ea7d0977f'
  checksumType   = 'sha512'
  checksum64     = 'd80abae62eb6190459781d028bb4cb7fb6b4682545df419998516044dcf6ba11f4187c2c06174137ac56b66ef59b21030302d4f23c417da4371b820e7f07abdd'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
