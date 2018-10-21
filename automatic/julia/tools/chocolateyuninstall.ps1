$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Julia*'
  fileType      = 'exe'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $packageArgs['file'] = "$($_.UninstallString)"

    $fileStringSplit = $packageArgs['file'] -split '\s+(?=(?:[^"]|"[^"]*")*$)'

    if($fileStringSplit.Count -gt 1) {
      $packageArgs['file'] = $fileStringSplit[0]
      $packageArgs['silentArgs'] += " $($fileStringSplit[1..($fileStringSplit.Count-1)])"
    }

    Uninstall-ChocolateyPackage @packageArgs
    Uninstall-BinFile -Name "julia.exe" -Path "$(Get-AppInstallLocation $packageArgs.softwareName)\bin\julia.exe" 
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
