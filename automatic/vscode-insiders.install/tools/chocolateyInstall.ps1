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
  url            = 'https://vscode.blob.core.windows.net/insider/5454665328aa30aeb989abfc195e7a7aacd94edf/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/5454665328aa30aeb989abfc195e7a7aacd94edf/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3097cf7f8bcaf2f84be905eabe8ee93140a20d2825f9a97886daf37c797a5c8eb4f2572a329d940fa8127e71767efbecd68798c00c62f639201047a10330bfd3'
  checksumType   = 'sha512'
  checksum64     = '24681ae017352379701c0c0b2b2a78fcd78529e86b81f7d925e6834d672e27655cb400949e950a7aa4658d038e68e381b0b66ce0754c4821314eae0813cdbf6e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
