$ErrorActionPreference = 'Stop';

$packageName = '1password'

#check if installed
$installed=get-package "$packageName*" -ErrorAction SilentlyContinue

#uninstall only if there
if($installed.Length -eq 0)
{
  Write-Warning "$packageName has already been uninstalled by other means."
}elseif ($installed.Length -gt 1)
{
  Write-Warning "$($installed.Length) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $installed | % {Write-Warning "- $($_.Name)"}
}else {
  Write-Host "Uninstalling $($installed.Name)"
  $installed | Uninstall-Package
}

