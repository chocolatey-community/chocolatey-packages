function GetInstallLocation {
  param(
    [string]$libDirectory
  )

  Write-Debug "Checking for uninstall text document in $libDirectory"

  if (Test-Path "$libDirectory\*.txt") {
    $txtContent = Get-Content -Encoding UTF8 "$libDirectory\*.txt" | Select-Object -first 1
    $index = $txtContent.LastIndexOf('\')
    if ($index -gt 0) {
      return $txtContent.Substring(0, $index)
    }
  }

  # If we got here, the text file doesn't exist or is empty
  # we don't return anything as it may be already uninstalled
}

function GetNewInstallLocation {
  param(
    [string]$PackageName,
    [string]$Version,
    $pp
  )

  if ($pp -and $pp.InstallDir) {
    return $pp.InstallDir
  }

  $toolsLocation = Get-ToolsLocation
  return "$toolsLocation\{0}{1}" -f $PackageName, ($Version -replace '\.').Substring(0,2)
}

function UninstallPackage {
  param(
    [string]$libDirectory,
    [string]$packageName
  )
  if (Test-Path "$libDirectory\*.txt") {
    $txtFile = Resolve-Path "$libDirectory\*.txt" | Select-Object -first 1
    $fileName = ($txtFile -split '\\' | Select-Object -last 1).TrimEnd('.txt')
    Uninstall-ChocolateyZipPackage -PackageName $packageName -ZipFileName $fileName
    if (Test-Path $txtFile) {
      Remove-Item -Force -ea 0 $txtFile
    }
  }
}

if (!(Test-Path function:\Uninstall-ChocolateyPath)) {
  function Uninstall-ChocolateyPath {
    param(
      [string]$pathToRemove,
      [System.EnvironmentVariableTarget] $pathType = [System.EnvironmentVariableTarget]::User
    )

    Write-Debug "Running 'Uninstall-ChocolateyPath' with pathToRemove: `'$pathToRemove`'"

    # get the PATH variable
    Update-SessionEnvironment
    $envPath = $env:PATH
    if ($envPath.ToLower().Contains($pathToRemove.ToLower())) {
      Write-Host "The PATH environment variable already contains the directory '$pathToRemove'. Removing..."
      $actualPath = Get-EnvironmentVariable -Name 'Path' -Scope $pathType -PreserveVariables

      $newPath = $actualPath -replace [regex]::Escape($pathToRemove + ';'),'' -replace ';;',';'

      if (($pathType -eq [System.EnvironmentVariableTarget]::Machine) -and !(Test-ProcessAdminRights)) {
        Write-Warning "Removing path from machine environment variable is not supported when not running as an elevated user!"
      } else {
        Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
      }

      $env:PATH = $newPath
    }
  }
}
