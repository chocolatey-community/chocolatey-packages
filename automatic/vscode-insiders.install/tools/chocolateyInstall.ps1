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
  url            = 'https://az764295.vo.msecnd.net/insider/8c85702bca51b08005ada7fc4eaf52a61623b2b6/VSCodeSetup-ia32-1.80.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/8c85702bca51b08005ada7fc4eaf52a61623b2b6/VSCodeSetup-x64-1.80.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '356c4afe06aa9749273eb5af832a4edec8ff916c5fef6a3f1aeaf427fd5c23fe3167562c34eadd98c5a1a873d56d06d77fb66b83836d50f3478c383b01bcd95e'
  checksumType   = 'sha512'
  checksum64     = 'fe4f3efd38ed0958c11a6c171d7d5767122429ba5a13c85aadedf9d48dd655af3170091ba6da41969ee2dd55401084705185a176b856599120312dd37e4d76dc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
