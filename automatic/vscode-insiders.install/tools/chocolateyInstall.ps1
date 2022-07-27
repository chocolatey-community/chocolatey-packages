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
  url            = 'https://az764295.vo.msecnd.net/insider/9cf2fabdd600c7d8e3230803acb246405321e8dd/VSCodeSetup-ia32-1.70.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/9cf2fabdd600c7d8e3230803acb246405321e8dd/VSCodeSetup-x64-1.70.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '02106c8a6c9a78e4de84998ab774d64051c156f34e6939d3b0df39cc37b4081718cd181dd08b398caa0e497619bc9a0916ae071442d4b678a3d22baa33855613'
  checksumType   = 'sha512'
  checksum64     = '9f356825bb8bc5df8c29591d89d74e7197f711961313f6ed5949ab931adcd6215eaa44ce087266da2ff646691655a050ee81653d2996159584d4d09752154842'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
