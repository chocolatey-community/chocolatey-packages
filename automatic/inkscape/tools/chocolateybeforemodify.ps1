$app = Get-WmiObject -Class Win32_Product -Filter "Name Like 'Inkscape%'"

if ($app) {
  Write-Host "Inkscape already installed. Removing..."
  $app.Uninstall()
  Write-Host "Done. Continuing with update/uninstall..."
}
