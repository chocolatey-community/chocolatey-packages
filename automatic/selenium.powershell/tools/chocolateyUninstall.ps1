$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$moduleName = "Selenium"
$moduleVersion = $env:ChocolateyPackageVersion
$savedPaths = Join-Path $toolsDir 'installedpaths'

$pathsToRemove = if (Test-Path $savedPaths) {
  Get-Content $savedPaths
} elseif ($PSVersionTable.PSVersion.Major -ge 5) {
  Join-Path $env:ProgramFiles "WindowsPowerShell\Modules\$($moduleName)\$($moduleVersion)"
} else {
  Join-Path $env:ProgramFiles "WindowsPowerShell\Modules\$($moduleName)"
}

$pathsToRemove | ForEach-Object {
  Write-Verbose "Removing '$moduleName' from '$_'."
  try {
    # First attempt to remove the DLLs. If they're loaded, then we shouldn't remove the rest of the module.
    Get-ChildItem -Path $_ -Recurse -Include *.dll | Remove-Item -Force
    Remove-Item -Path $_ -Recurse -Force
  }
  catch {
    Write-Warning "We were unable to remove some of the files at $_. This generally means Selenium is currently loaded in a PowerShell session. Please close the PowerShell session it's loaded in and try again."
    throw
  }
}
