$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64bit = $url
$installerType = 'exe'
$installArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$gimpRegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\gimp*'

try {

  if (Test-Path $gimpRegistryPath) {
    $installedVersion = (Get-ItemProperty -Path $gimpRegistryPath -Name 'DisplayVersion').DisplayVersion
  }

  if ($installedVersion -eq $version) {
    Write-Output "GIMP $installedVersion is already installed. Skipping download and installation."
  } else {
    Install-ChocolateyPackage $packageName $installerType $installArgs $url $url64bit -validExitCodes @(0)
  }
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
