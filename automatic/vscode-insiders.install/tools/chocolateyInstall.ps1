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
  url            = 'https://az764295.vo.msecnd.net/insider/ee46c1f89ebb213e0827886f1688c0fbb55be49f/VSCodeSetup-ia32-1.52.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/ee46c1f89ebb213e0827886f1688c0fbb55be49f/VSCodeSetup-x64-1.52.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5506bd924065c5b34a8eb2cfb6ce89cb47d29005bdc25d600a4e1a5a1ce375ee44ffd020aad6c2266108f901eb9263cd95780d210a698bd22660301e77ee72f6'
  checksumType   = 'sha512'
  checksum64     = '69037c217f7a81d4981eae11310034123ffaccea7cda7bca2ea603607cbeb704d9f724d186c81287dd080bfb8bf092611a306cce1dfb8bac6615fce8c1ac6234'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
