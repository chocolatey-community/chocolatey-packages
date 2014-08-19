$packageName = '{{PackageName}}'
$packageVersion = '{{PackageVersion}}'
$regPath = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inkscape'
$regPath64 = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Inkscape'
# \{\{DownloadUrlx64\}\} gets 'misused' here as general download URL on SourceForge
$url = '{{DownloadUrlx64}}'
$installerType = 'exe'
$installArgs = '/S'

try {
  if (Test-Path $regPath64) {
    $installedVersion = (Get-ItemProperty -Path $regPath64 -Name 'DisplayVersion').DisplayVersion
  }

  if (Test-Path $regPath) {
    $installedVersion = (Get-ItemProperty -Path $regPath -Name 'DisplayVersion').DisplayVersion
  }

  if ($installedVersion -and ($packageVersion -match $('^' + [Regex]::Escape($installedVersion)))) {
    Write-Host "Inkscape $installedVersion is already installed. Skipping download and installation."
  } else {
    Install-ChocolateyPackage $packageName $installerType $installArgs $url
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
