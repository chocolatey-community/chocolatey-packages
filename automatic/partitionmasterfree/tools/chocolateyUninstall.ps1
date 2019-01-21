$ErrorActionPreference = 'Stop'

$commonPackageArgs = @{
  fileType       = 'exe'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /RESTARTEXITCODE=3010 /SP-'
  validExitCodes = @(0, 3010)
}

$softwares = New-Object 'System.Collections.Generic.List[hashtable]'
$softwares.Add(@{
  packageName  = 'partitionmasterfree'
  softwareName = 'EaseUS Partition Master*'
})

$pp = Get-PackageParameters
if ($pp.UninstallAdditions) {
  $softwares.Add(@{
      packageName  = 'EaseUS additional programs'
      softwareName = 'EaseUS Todo Backup Free*'
    })
}

$uninstalled = $false

$softwares | % {
  $packageArgs = $_

  [array]$key = Get-UninstallRegistryKey @packageArgs

  if ($key.Count -eq 1) {
    $key | ForEach-Object {
      $packageArgs['file'] = "$($_.UninstallString)"

      Uninstall-ChocolateyPackage @packageArgs @commonPackageArgs
    }
  }
  elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert the package maintainer that the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
  }
}
