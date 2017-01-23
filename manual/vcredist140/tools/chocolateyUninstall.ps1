. (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -ChildPath 'data.ps1')
$packageName = 'vcredist140'
$installerType = 'exe'
$silentArgs = '/uninstall /quiet'
$validExitCodes = @(0, 3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

$uninstallKeys = Get-UninstallRegistryKey @uninstallData | Where-Object { $_.PSObject.Properties['SystemComponent'] -eq $null -or $_.SystemComponent -eq 0 }
foreach ($uninstallKey in $uninstallKeys)
{
    if ($uninstallKey.PSObject.Properties['UninstallString'] -ne $null)
    {
        $uninstallString = $uninstallKey.UninstallString
        Write-Verbose "Found uninstall key, UninstallString = $uninstallString"
        if ($uninstallString -match '^"?(.*?)(".*)?$')
        {
            $uninstallerPath = $matches[1]
            Uninstall-ChocolateyPackage -PackageName $packageName `
                                        -FileType $installerType `
                                        -SilentArgs $silentArgs `
                                        -File $uninstallerPath `
                                        -ValidExitCodes $validExitCodes
        }
        else
        {
            Write-Warning "The uninstall information in the registry is in an unknown format. Please report this to package maintainers. Data from the registry: [$uninstallString]"
        }
    }
    else
    {
        Write-Warning "The uninstall information in the registry does not contain the path to the uninstaller application. Please report this to package maintainers. Registry key path: [$($uninstallKey.PSPath)]"
    }
}
