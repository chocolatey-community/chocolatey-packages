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
  url            = 'https://az764295.vo.msecnd.net/insider/87d692b7bf1eb5a663b3e62620a6e7e436e1838c/VSCodeSetup-ia32-1.59.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/87d692b7bf1eb5a663b3e62620a6e7e436e1838c/VSCodeSetup-x64-1.59.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6b7e7c2d2c631fc71abc1c1cf96ee8f9aa9f976c859d6b64e4ccb67076094094cb8bb4f49e2f3e0db4d3e72aeb46463369b1ab5cb177560f268b9a8295305ccb'
  checksumType   = 'sha512'
  checksum64     = '9e57bef38a81969507ab352f8c30fbb66810d0f90570c416dde14dc8b1b394b368b13c15e3509b94c6bf8038887b9318c429aac05dde8dd4842095103b058724'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
