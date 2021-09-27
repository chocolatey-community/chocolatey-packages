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
  url            = 'https://az764295.vo.msecnd.net/insider/5991e3c4b97eca5568069bf3e0910ab693ad3549/VSCodeSetup-ia32-1.61.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/5991e3c4b97eca5568069bf3e0910ab693ad3549/VSCodeSetup-x64-1.61.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e35acd38d0cd0511ef3ec08220d2581a9eaa560276970405469abbf263208077f08b7e121090da085874190039e9fad86f1601702cd7a2a329ffb6034b18efae'
  checksumType   = 'sha512'
  checksum64     = '9eeaf334745241c3c075f86db7535b0eea27ab0c0ed4a2f901e7b7c00f2de599931bcee0f3ed68ba699118c936b3a80393a5a69a47ff1d4eb8dfebc48b88bd5a'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
