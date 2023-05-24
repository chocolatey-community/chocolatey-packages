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
  Remove-Item -Path $Path -Recurse -Force
}