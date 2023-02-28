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
  url            = 'https://az764295.vo.msecnd.net/insider/3c8099c659099d3af89a66f9635b4700a887f177/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3c8099c659099d3af89a66f9635b4700a887f177/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ef38d1c937d9012f4a9be7195828c6afa5997b6f84a305cd360885087f534ba97dcd4f81863702a2148bd94c6eafb52060562c68b5355bba46305502c4d514dc'
  checksumType   = 'sha512'
  checksum64     = '0ecf0afc6328f822612f8ef5acbbbadc035d91f3580830738d395612e075340d4fd55131553a2f587fd309bf721795e66f62a3027991cfe1910136c53b607c9a'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
