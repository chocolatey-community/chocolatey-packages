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
  url            = 'https://az764295.vo.msecnd.net/insider/3e0b354932b8ddeb099c68ed3b7dfac25350dde2/VSCodeSetup-ia32-1.78.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3e0b354932b8ddeb099c68ed3b7dfac25350dde2/VSCodeSetup-x64-1.78.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '30827f52931f2e7f6943c9d60dd4578fb791ddf3a177ecfaa986558251278c2483e830d097c8a1d5fbfbe3904562b02b91a185d252c98e7b3975c60b9d30fb8b'
  checksumType   = 'sha512'
  checksum64     = '17482cda2851bf57682b2e17baed0d232c5563279c4b1ffe7270ca4d4f5ab0bfffbdf468609cb1fd50727571cdf39846260809edfae258251c900f6783e41f3d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
