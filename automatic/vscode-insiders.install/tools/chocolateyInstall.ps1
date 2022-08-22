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
  url            = 'https://az764295.vo.msecnd.net/insider/235a92a3693176fbf9af16ec5b829c458a1d682f/VSCodeSetup-ia32-1.71.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/235a92a3693176fbf9af16ec5b829c458a1d682f/VSCodeSetup-x64-1.71.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b9c98a1ddf8f7cbe4f9336f3a3898d5b381085baddf855256d5807561eb3088e58bcda2c816e5d8d3f532b91028a03c6954fc264d22e78916bf3b9dcb6e32451'
  checksumType   = 'sha512'
  checksum64     = '3aba629e017249138f92bc3ef98175a4a5893e8fcbe4ce0b9c6d4b793201cfca69f10e5d854a8f67ee72f41566afe01bdc683e9d94cf4ba1d81cbc1cd68a9624'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
