Clear-Host
Write-Host '--> Installing Chocolatey'
Write-Host
Invoke-WebRequest -useb 'https://chocolatey.org/install.ps1' | Invoke-Expression
Write-Host
Write-Host '--> Enabling automatic confirmation for Chocolatey'
Write-Host
choco feature enable -n=allowGlobalConfirmation
Write-Host
if (-Not [string]::IsNullOrWhiteSpace($args)) {
  Write-Host '--> Running the following command:'
  Write-Host "    $ $args"
  Write-Host
  Invoke-Expression "& $args"
  Write-Host
}
