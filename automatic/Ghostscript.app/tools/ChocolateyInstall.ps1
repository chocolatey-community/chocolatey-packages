. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) chocolateyInclude.ps1)

if (Test-Path $uninstallRegKey) {
  $installedVersion = [Version] (Get-ItemProperty $uninstallRegKey DisplayVersion).DisplayVersion
}
if ($installedVersion -eq $version) {
  Write-ChocolateySuccess $package '$(package) is already installed. Updating the chococolatey database.'
}
elseif ($installedVersion -gt $version) {
  Write-ChocolateyFailure $package "A newer version of $package [$($installedVersion)] is already installed. Updating the chococolatey database."
}
else {
  Install-ChocolateyPackage $package 'exe' '/S /NCRC' $url $url64
}
