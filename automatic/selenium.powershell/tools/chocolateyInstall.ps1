$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$ModuleName = "Selenium"
$ModuleVersion = $env:ChocolateyPackageVersion

$SourcePath = Join-Path $toolsDir "$($ModuleName).zip"
$SavedPaths = Join-Path $ToolsDir 'installedpaths'

$DestinationPath = switch ((Get-PackageParameters).Keys) {
  "Core" {
    Join-Path $env:ProgramFiles "PowerShell\Modules"
  }
  "Desktop" {
    Join-Path $env:ProgramFiles "WindowsPowerShell\Modules"
  }
}

# By default, install for Windows PowerShell
if (-not $DestinationPath) {
  $DestinationPath = Join-Path $env:ProgramFiles "WindowsPowerShell\Modules"
}

$UnzipArgs = @{
  FileFullPath = $SourcePath
  PackageName  = $env:ChocolateyPackageName
}

$InstalledPaths = foreach ($Path in $DestinationPath) {
  Write-Verbose "Installing '$ModuleName' to '$Path'"

  # PS > 5 needs to extract to a versioned folder
  $Path = if ($PSVersionTable.PSVersion.Major -ge 5) {
    Join-Path $Path "$($ModuleName)\$($ModuleVersion)"
  } else {
    Join-Path $Path "$($ModuleName)"
  }

  if (-not (Test-Path $Path)) {
    $null = New-Item $Path -ItemType Directory -Force
  }

  Get-ChocolateyUnzip @UnzipArgs -Destination $Path
}

# Cleanup the module from the Chocolatey $toolsDir folder
Remove-Item $SourcePath -Force -Recurse

# Store the installed locations, so we can remove them during uninstall
Set-Content $SavedPaths -Value $InstalledPaths