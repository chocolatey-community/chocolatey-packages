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
  url            = 'https://az764295.vo.msecnd.net/insider/d6290ef6582acecbf3bca1558111f2ee64375801/VSCodeSetup-ia32-1.78.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d6290ef6582acecbf3bca1558111f2ee64375801/VSCodeSetup-x64-1.78.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e7dddf78e48ed035d920348a4796852cecd44d2c2782c114209956bfbb047b62167e8b563c3cf9857c45cb6f9da66b8dca31b19f54a714ac3de3a6b8dbd952c1'
  checksumType   = 'sha512'
  checksum64     = '7de6bf7efacdc6e0363a22cce32c11b24de5e0267146c23cc8757acafa87a3e3eece23ab72e1efcdcdb7852258802c75d6d6db7ffe9f4d9ed30655035df067dc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
