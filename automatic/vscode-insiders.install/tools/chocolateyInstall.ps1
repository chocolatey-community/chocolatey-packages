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
  url            = 'https://az764295.vo.msecnd.net/insider/13f1afffab09548c10ddb3bc5d5db52587876ad8/VSCodeSetup-ia32-1.56.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/13f1afffab09548c10ddb3bc5d5db52587876ad8/VSCodeSetup-x64-1.56.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b646064b086cd7815e7898f2845e7f83bbc9ba60723bf229b9f4fce411998b13abc33286b614ed6363bc3877d4f24f7bbe5e44a8bf1d3b6e093a911b97aaaaed'
  checksumType   = 'sha512'
  checksum64     = '2e1e6eec5fac7689cd0537bff4725cc8979aa46dbe9a53d94a1ef30c973cbb240a3753d749705e06dac926345170a46ed639a122c379d2db7d2490b71e10973b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
