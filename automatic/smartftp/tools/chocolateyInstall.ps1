function Check-SoftwareInstalled ($displayName, $displayVersion) {
  $registryPaths = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
  )

  return Get-ItemProperty $registryPaths -ErrorAction SilentlyContinue | Where-Object {
    $_.DisplayName -eq $displayName -and $_.DisplayVersion -eq $displayVersion
  }
}

$version = '{{PackageVersion}}'

$packageArgs = @{
  packageName = '{{PackageName}}'
  fileType = 'msi'
  url  = '{{DownloadUrl}}'
  url64bit  = '{{DownloadUrlx64}}'
  silentArgs = '/quiet'
  validExitCodes = @(0)
  softwareName  = 'SmartFTP Client'
}

$alreadyInstalled = Check-SoftwareInstalled 'SmartFTP Client' $version

if ($alreadyInstalled) {
  Write-Output $('SmartFTP Client ' + $version + ' is already installed.')
} else {
  Install-ChocolateyPackage @packageArgs
}
