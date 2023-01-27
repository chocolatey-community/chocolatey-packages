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
  url            = 'https://vscode.blob.core.windows.net/insider/acbbdaa41a459aab86072e8d97255cd2ea1d9529/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/acbbdaa41a459aab86072e8d97255cd2ea1d9529/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd6a32bc1f53279343770206126d76f84f7e3dd9703f7f5640f2132e6776d31de97c6f5982eaf288fbe962dd2fe1685c85bba5fd0e2e50dc73388439718151b1d'
  checksumType   = 'sha512'
  checksum64     = '46df673c58bf8f76fb1e479e2a79ea9e03295b8c9810c405a19001654d5fd5b37da810248d588fa899a1c58d266cb0ebc5fc155e523a9370772630bb81b91abb'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
