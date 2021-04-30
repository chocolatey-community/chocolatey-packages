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
  url            = 'https://az764295.vo.msecnd.net/insider/6449b6b7253b5808e2278903c82da8d59a230383/VSCodeSetup-ia32-1.56.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6449b6b7253b5808e2278903c82da8d59a230383/VSCodeSetup-x64-1.56.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '94d16a709ac4bd835a3f1673e942397069c1ef308b42b788ce7a952c5f896cabd49ffea84ce2d5c8245cd36c051d1a3e36c0bd2c68de94ee2f3dc4cd4fb1c46b'
  checksumType   = 'sha512'
  checksum64     = 'bcc28e8f8b3680dac81222e844218c0e2f7f180016531571f27c7d1d7eb22f107942d1f54185713dcb410b52de7a88a8b8561c2a554be7e32fc2b4249f615ffe'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
