function Get-GitExecutable()
{
  $gitRegistryPath = $(
    'HKLM:\SOFTWARE\GitForWindows'
  )

  if (Test-Path $gitRegistryPath) {
    # Use Git executable based on registry entry for Git For Windows.
    $gitInstallPath = (
      Get-ItemProperty -Path $gitRegistryPath 
    ).InstallPath
    $gitExecutable = Join-Path(Join-Path $gitInstallPath "bin") "git.exe"
  }
  else {
    # If no entry for Git was found in the registry, try to find git executable on the path.
    Update-SessionEnvironment

    $gitExecutable = "git"
  }

  Write-Host "Using Git from '$gitExecutable'"
  return $gitExecutable
}
