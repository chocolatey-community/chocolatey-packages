$ErrorActionPreference = 'Stop'

$packageName         = $Env:ChocolateyPackageName
$softwareNamePattern = 'Graphviz*'

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {
    $key | ForEach-Object {
        $packageArgs = @{
            packageName            = $packageName
            silentArgs             = "/x86=0 /S"
            fileType               = 'EXE'
            validExitCodes         = @(0)
            file                   = "$($_.UninstallString.Replace(' /x86=0', ''))"   #"C:\Program Files\OpenSSH\uninstall.exe" /x86=0
            softwareName           = 'Graphviz*'
        }

        $installLocation = Get-AppInstallLocation $packageArgs.softwareName
        Write-Debug "$packageName installed in: $installLocation"
        
        if (!$installLocation) { 
            Write-Warning "Can't find $packageName install location"; return 1
        }

        # Get all file names installed with the package
        Get-ChildItem "$installLocation\bin" -Filter "*.exe" | ForEach { 
            Write-Debug "Shimmed file: $($_.Name)..."
            Uninstall-BinFile $_.Name 
        }

        Uninstall-ChocolateyPackage @packageArgs
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
