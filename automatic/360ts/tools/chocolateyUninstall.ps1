# Name of the Chocolatey Package
$packageName = '360ts'
# Remove Characters / Add Spaces to $packageName
# for matching Name listed in Progams & Features
$regName = $packageName -replace ('ts','*')
# Using Chocolatey Helper to find related Registry Keys
$registry = Get-UninstallRegistryKey -SoftwareName $regName
# Any Silent Arguments for the Uninstall String
$silentArgs = '/S'

# All arguments for the Uninstallation of this package
$packageArgs = @{
PackageName = $registry.DisplayName
FileType = 'exe'
SilentArgs = $silentArgs
validExitCodes =  @(0)
File = $registry.UninstallString
}

# Now to Uninstall the Package
Uninstall-ChocolateyPackage @packageArgs
