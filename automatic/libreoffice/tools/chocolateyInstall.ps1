# Important: The contents of this file – the `libreoffice` and
# `libreoffice-oldstable` install scripts – **must** be identical.

$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$url32 = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$validExitCodes = @(0,3010)

# Check if LibreOffice in the same version is already installed
$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
  ($_.Name -match '^LibreOffice [\d\.]+$') -and ($_.Version -match "^$version")
}

if ($alreadyInstalled) {

  Write-Output $(
    "LibreOffice $version is already installed on the computer. " +
    "Skipping download."
  )

  if ((Get-ProcessorBits 64) -and $url64) {

    Write-Output $(
      "Do you already have LibreOffice $version 32-bit installed " +
      "and want to switch to 64-bit? " +
      "In that case you have to manually uninstall the 32-bit version " +
      "and reinstall this package."
    )
  }

} else {

  if ($url64) {
    Install-ChocolateyPackage $packageName 'msi' '/passive /norestart' `
      $url32 $url64 -validExitCodes $validExitCodes
  } else {
    Install-ChocolateyPackage $packageName 'msi' '/passive /norestart' `
      $url32 -validExitCodes $validExitCodes
  }
}
