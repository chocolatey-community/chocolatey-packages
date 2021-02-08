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
  url            = 'https://az764295.vo.msecnd.net/insider/afd102cbd2e17305a510701d7fd963ec2528e4ea/VSCodeSetup-ia32-1.54.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/afd102cbd2e17305a510701d7fd963ec2528e4ea/VSCodeSetup-x64-1.54.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b95181929931bd5212e4a07752b8dc1965db16b47427f2b1a1a4f69ee70a6e3d939711c443a6f4c7a8d473f9a8adf517fffc5cff5dbe6d187a3e493c76daa89e'
  checksumType   = 'sha512'
  checksum64     = '704f7d49164ff02bc6310aa82a0e3b8e5977b51e0f3c3f63d7dd674c3b2713fc24283807708ec967cc97687a230f16a386761cd077cbbb03d0ed916d53f93b55'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
