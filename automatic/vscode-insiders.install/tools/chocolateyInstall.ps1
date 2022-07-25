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
  url            = 'https://az764295.vo.msecnd.net/insider/3cbf3063281410d21951877eb628551809d70c6b/VSCodeSetup-ia32-1.70.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3cbf3063281410d21951877eb628551809d70c6b/VSCodeSetup-x64-1.70.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'f7f28109bb7692c64ac80c85c860beb0b155dd2eb53db37595eb34c663ae4420d3401814a0127fe7f848bada38abfaa8433a47b4bae5e2612ad2de170db4973f'
  checksumType   = 'sha512'
  checksum64     = 'd0b8cf8f882bac821fc4eaddfe98dd4799a50d78346de72f3afa6bdba1d93b7b0769496815c85e018a85026ed633b7d21b643e75a618c8257c8e4ba171867a2e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
