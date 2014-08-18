$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$registryUninstallRoot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
$registryUninstallRootWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'

function findMsid {
  param([String]$registryUninstallRoot, [string]$keyContentMatch, [string]$version)

  if (Test-Path $registryUninstallRoot) {
    Get-ChildItem -Force -Path $registryUninstallRoot | foreach {
      $currentKey = (Get-ItemProperty -Path $_.PsPath)
      if ($currentKey -match $keyContentMatch -and $currentKey -match $version) {
        return $currentKey.PsChildName
      }
    }
  }

  return $null
}

try {

  $alreadyInstalled = findMsid $registryUninstallRoot 'Adobe Flash Player [\d\.]+ Plugin' $version
  $alreadyInstalledWow6432 = findMsid $registryUninstallRootWow6432 'Adobe Flash Player [\d\.]+ Plugin' $version

  if ($alreadyInstalled -or $alreadyInstalledWow6432) {
    Write-Output "Adobe Flash Player Plugin (for non-IE browsers) $version is already installed."
  } else {
    Install-ChocolateyPackage $packageName 'msi' '/quiet /norestart REMOVE_PREVIOUS=YES' '{{DownloadUrl}}'
  }


} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
