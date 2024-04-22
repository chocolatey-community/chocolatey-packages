$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$ModuleName = "Selenium"
$ModuleVersion = $env:ChocolateyPackageVersion
$SavedPaths = Join-Path $ToolsDir 'installedpaths'

$PathsToRemove = if (Test-Path $SavedPaths) {
  Get-Content $SavedPaths
} elseif ($PSVersionTable.PSVersion.Major -ge 5) {
  Join-Path $env:ProgramFiles "WindowsPowerShell\Modules\$($ModuleName)\$($ModuleVersion)"
} else {
  Join-Path $env:ProgramFiles "WindowsPowerShell\Modules\$($ModuleName)"
}

foreach ($Path in $PathsToRemove) {
  Write-Verbose "Removing '$ModuleName' from '$Path'."
  try {
    # First attempt to remove the DLLs. If they're loaded, then we shouldn't remove the rest of the module.
    Get-ChildItem -Path $Path -Recurse -Include *.dll | Remove-Item -Force
    Remove-Item -Path $Path -Recurse -Force
  }
  catch {
    Write-Warning "We were unable to remove some of the files at $Path. This generally means Selenium is currently loaded in a PowerShell session. Please close the PowerShell session it's loaded in and try again."
    throw
  }
}
