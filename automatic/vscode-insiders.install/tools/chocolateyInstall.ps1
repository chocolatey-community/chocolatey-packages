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
  url            = 'https://az764295.vo.msecnd.net/insider/87630a9122f88f5062fe9964839a92116c274a86/VSCodeSetup-ia32-1.68.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/87630a9122f88f5062fe9964839a92116c274a86/VSCodeSetup-x64-1.68.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '91226c364640fc9e6ff0e852a9662b8e48821f38946809f03d94c86c132f5c529c3ec2ccf6a99d1a4e202aefade29c3564e7f9708262928029df93b4da06525c'
  checksumType   = 'sha512'
  checksum64     = 'ed0a3c067d76d75a5e49b9f21b1a385a1051b48c2cb512b1b3b1db4673e000b4a20c7aacb87ca5b7c4e6e25ea93032e47bafd697b3ae3674edeb116aac54ec37'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
