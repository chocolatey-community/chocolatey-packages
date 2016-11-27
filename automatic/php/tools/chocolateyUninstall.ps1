$packageName = 'php'

$installLocation = Join-Path $(Get-ToolsPath) $packageName
Write-Host "Deleting $installLocation"
rm -Force -Recurse $installLocation

#Uninstall-ChocolateyPath $installLocation
