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
  url            = 'https://az764295.vo.msecnd.net/insider/dc142e4cd111b8f370d0549d8c207df7de55facd/VSCodeSetup-ia32-1.81.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/dc142e4cd111b8f370d0549d8c207df7de55facd/VSCodeSetup-x64-1.81.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2fb825a009b10b74ac7fd95ce6477d98e7b16e599a1cac5e509914f5bab2e7450aee22ec7c981319b318fbd41c1a28026d68344b97326c15e0984eab409b6f63'
  checksumType   = 'sha512'
  checksum64     = '069fa504d5358489cb5ef762aa72f7edfe3b2fbbe8eb2b1086c6643ab05cb76db04b190f191d09239ec4031d28e4b64550bfeeb2901da024f1483ccdefb9bdc4'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
