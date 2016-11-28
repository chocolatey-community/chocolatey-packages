$packageName = 'php'

$installLocation = Join-Path $(Get-ToolsLocation) $packageName
Write-Host "Deleting $installLocation"
rm -Force -Recurse $installLocation

#Uninstall-ChocolateyPath $installLocation
