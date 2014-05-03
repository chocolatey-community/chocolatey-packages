function isAlreadyInstalled {
    param([string]$keyName, [string]$version)

    $registryDirsArray = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall')

    foreach ($registryDir in $registryDirsArray) {

        if (Test-Path $registryDir) {
            Get-ChildItem -Force -Path $registryDir | foreach {
                $currentKey = (Get-ItemProperty -Path $_.PsPath)
                if ($currentKey.DisplayName -match $keyName -and $currentKey -match $version) {
                        return $currentKey
                }
            }
        }
    }

    return $null
}
