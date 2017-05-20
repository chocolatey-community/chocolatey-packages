$ErrorActionPreference = 'Stop'

$packageName         = 'vcredist2008'
$softwareNamePattern = 'Microsoft Visual C++ 2008 Redistributable*'

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
$cnt = if (Get-ProcessorBits 64)  {2} else {1}
if ($key.Count -in 1,2) {
    $key | % {
        $packageArgs = @{
            packageName            = $packageName
            silentArgs             = "/quiet /qn /norestart"
            fileType               = 'msi'
            validExitCodes         = @(0,3010) # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
            file                   = "$($_.UninstallString.Replace(' /x86=0', ''))"   #"C:\Program Files\OpenSSH\uninstall.exe" /x86=0
        }
        Uninstall-ChocolateyPackage @packageArgs
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt $cnt) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | % {Write-Warning "- $($_.DisplayName)"}
}