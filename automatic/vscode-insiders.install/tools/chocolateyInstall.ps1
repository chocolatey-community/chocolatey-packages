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
  url            = 'https://az764295.vo.msecnd.net/insider/bd6107301dc9a6200bd8d4f64a9b198438b3f1d6/VSCodeSetup-ia32-1.71.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/235a92a3693176fbf9af16ec5b829c458a1d682f/VSCodeSetup-x64-1.71.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ba9f3ebced93ff1804dfd7be6776ad92b20aa53b331b9f8c7237db2f7d7a6dc7b0a696e9656eff746b98b605fb66fc9550a5463642361e49010c7cdba1489d4a'
  checksumType   = 'sha512'
  checksum64     = '3aba629e017249138f92bc3ef98175a4a5893e8fcbe4ce0b9c6d4b793201cfca69f10e5d854a8f67ee72f41566afe01bdc683e9d94cf4ba1d81cbc1cd68a9624'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
