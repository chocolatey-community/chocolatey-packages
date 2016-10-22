$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$validExitCodes = @(0, 3010)

function Check-SameVersionInstalled() {
  $registryPaths = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
  )

  return Get-ItemProperty $registryPaths -ErrorAction SilentlyContinue | Where-Object {
    $_.DisplayName -match '^LibreOffice [\d\.]+$' -and
    $_.DisplayVersion -like "${version}*"
  }
}

if (Check-SameVersionInstalled) {

  Write-Output $(
    "LibreOffice $version is already installed on the computer. " +
    "Skipping download."
  )
} else {
  Install-ChocolateyPackage $packageName 'msi' '/qn /norestart' `
    $url -validExitCodes $validExitCodes
}
