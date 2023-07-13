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
  url            = 'https://az764295.vo.msecnd.net/insider/2f1013a310bbd74410e74fad99497841edad0eda/VSCodeSetup-ia32-1.81.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2f1013a310bbd74410e74fad99497841edad0eda/VSCodeSetup-x64-1.81.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6e16fdefcb582c93d2a15d583208d0bef6015d8a03fe10308b5ab83d889a6543c24016f9fa7c7e928098829f30746b4c0e7d76bfa332d6abe6e10967f1c55de0'
  checksumType   = 'sha512'
  checksum64     = '322137fadd35e606b6417854127490d81b8be3a2a9b847ef6388a38e1418e3756d8c46a3563113dbd1b68379289ccee1e735198912974ffd9a2800effe4ac51d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
