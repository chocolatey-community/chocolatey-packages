$ErrorActionPreference = 'Stop';

$packageName = 'codeblocks'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName 'CodeBlocks'

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs = @{
      packageName = $packageName
      fileType    = 'EXE'
      silentArgs  = '/S'
      validExitCodes= @(0)
      file          = "$($_.UninstallString)"
    }

    Uninstall-ChocolateyPackage @packageArgs
    Wait-Process -Name "Au_" # This is added to prevent race condition with auto uninstaller

    $appPathKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\"
    if (Test-Path "$appPathKey\codeblocks.exe") { Remove-Item "$appPathKey\codeblocks.exe" -Force }
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $_.DisplayName"}
}
