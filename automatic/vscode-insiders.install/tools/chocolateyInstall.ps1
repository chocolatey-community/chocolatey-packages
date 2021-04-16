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
  url            = 'https://az764295.vo.msecnd.net/insider/ce791d27dc9889a392f4d29abefe9c53eb0b5129/VSCodeSetup-ia32-1.56.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/ce791d27dc9889a392f4d29abefe9c53eb0b5129/VSCodeSetup-x64-1.56.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '15bac18f0552d39f6e2d94aabae106f32c6b9c1bf04660b482f85205d054d2ba8e97050ef16aa27c37355edb5cc4c1aa25c3254988883732f8e96c126835cbf4'
  checksumType   = 'sha512'
  checksum64     = '5bca932bd1a8a603c9323fb001af5a2f4a159b38cdea63691ab510d4b66e265a8cc82917246eb7aefe772c535cdb4528311b7d055067a12590bd62b28992e0e4'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
