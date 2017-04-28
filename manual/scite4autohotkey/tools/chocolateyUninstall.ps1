$ErrorActionPreference = 'Stop';

$packageName = 'scite4autohotkey'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName "$packageName*"

if ($key.Count -eq 1) {
  $key | % {
    $index = $_.UninstallString.IndexOf('/')
    $packageArgs = @{
      packageName   = $packageName
      fileType      = 'EXE'
      silentArgs    = $_.UninstallString.Substring($index).Trim('"')
      validExitCodes= @(0)
      file          = "$($_.UninstallString.Substring(0, $index).Trim().Trim('"'))"
    }

    # We only want to try uninstalling if the user haven't specified '--notsilent', otherwise
    # we let the auto uninstaller ask the user to run the uninstaller
    if ($env:chocolateyInstallOverride -ne $true) {
      $toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
      Start-Process "autohotkey" -Verb "runas" -ArgumentList "`"$toolsPath\uninstall.ahk`""
      Uninstall-ChocolateyPackage @packageArgs
    }
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}
