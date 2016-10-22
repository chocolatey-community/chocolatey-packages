### functions

function Check-SoftwareInstalled ($displayName, $displayVersion) {
  $registryPaths = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
  )

  return Get-ItemProperty $registryPaths -ErrorAction SilentlyContinue | Where-Object {
    $_.DisplayName -eq $displayName -and $_.DisplayVersion -eq $displayVersion
  }
}

### end functions

$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$installArgs = '/quiet /norestart REMOVE_PREVIOUS=YES'
$url = '{{DownloadUrl}}'

$majorVersion = ([version] $version).Major

$alreadyInstalled = Check-SoftwareInstalled "Adobe Flash Player $majorVersion NPAPI" $version

if ($alreadyInstalled) {
  Write-Output $(
    "Adobe Flash Player NPAPI (for non-IE browsers) v$version " +
    "is already installed. No need to download and install it again."
  )
} else {
  Install-ChocolateyPackage $packageName 'msi' $installArgs $url
}

