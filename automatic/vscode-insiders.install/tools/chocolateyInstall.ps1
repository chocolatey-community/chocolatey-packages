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
  url            = 'https://az764295.vo.msecnd.net/insider/45060913204279d4ecfe0575ca69d68211fb3798/VSCodeSetup-ia32-1.64.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/45060913204279d4ecfe0575ca69d68211fb3798/VSCodeSetup-x64-1.64.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '85ef6c76214c476425d282043f7cd19e3cfe57902cf5f002ce798734e21c56479f6a2746c5edcfbac91014b9cef9ff463dc62dbe78f8325cd8da3119f245c13e'
  checksumType   = 'sha512'
  checksum64     = 'f3e621ca22f59ec0ff777451795100fec657f2b7802a77e44686add36061e840d531de83d42c759a3bdc8fbe37ffa91ee9a6c04a86068fd92ee277788bcd2755'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
