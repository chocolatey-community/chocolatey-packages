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
  url            = 'https://az764295.vo.msecnd.net/insider/a699ffaee62010c4634d301da2bbdb7646b8d1da/VSCodeSetup-ia32-1.54.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a699ffaee62010c4634d301da2bbdb7646b8d1da/VSCodeSetup-x64-1.54.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3128097c841d06f3f282b1f699359220b9975877429857c47c2113066e6fcc029f01446f2fa0d7238edd6641ef1c93416eec76c56036f48264f82d1e0acffacd'
  checksumType   = 'sha512'
  checksum64     = 'f27916aa6a5200879cfe8258309e6e405f29786bcaac03e83850aae5ca17e3794b4d72bb52520c01bf08e8e9ad1230c51ae40b3e2a2a748e49ab97471dde7e04'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
