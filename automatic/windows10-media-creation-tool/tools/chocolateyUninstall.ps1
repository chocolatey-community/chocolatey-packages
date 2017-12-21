$packageName = 'windows10-media-creation-tool'
$exeName = "MediaCreationTool.exe"
$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"

#Uninstall-ChocolateyZipPackage $packageName windows10-media-creation-tool.zip

If (Test-Path $AppPathKey) {Remove-Item "$AppPathKey" -Force -Recurse -EA SilentlyContinue | Out-Null}
