$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$moduleName = "Selenium"
$moduleVersion = $env:ChocolateyPackageVersion

$sourcePath = Join-Path $toolsDir "$($moduleName).zip"
$savedPaths = Join-Path $ToolsDir 'installedpaths'

$destinationPath = switch ((Get-PackageParameters).Keys) {
  "Core" {
    Join-Path $env:ProgramFiles "PowerShell\Modules"
  }
  "Desktop" {
    Join-Path $env:ProgramFiles "WindowsPowerShell\Modules"
  }
}

# By default, install for Windows PowerShell
if (-not $destinationPath) {
  $destinationPath = Join-Path $env:ProgramFiles "WindowsPowerShell\Modules"
}

$unzipArgs = @{
  FileFullPath = $sourcePath
  PackageName  = $env:ChocolateyPackageName
}

$installedPaths = $destinationPath | ForEach-Object {
  Write-Verbose "Installing '$moduleName' to '$_'"

  # PS > 5 needs to extract to a versioned folder
  $path = if ($PSVersionTable.PSVersion.Major -ge 5 -or $_ -notmatch 'Windows') {
    Join-Path $_ "$($moduleName)\$($moduleVersion)"
  } else {
    Join-Path $_ "$($moduleName)"
  }

  if (-not (Test-Path $path)) {
    $null = New-Item $path -ItemType Directory -Force
  }

  Get-ChocolateyUnzip @unzipArgs -Destination $path
}

# Cleanup the module from the Chocolatey $toolsDir folder
Remove-Item $sourcePath -Force -Recurse

# Store the installed locations, so we can remove them during uninstall
Set-Content $savedPaths -Value $installedPaths
