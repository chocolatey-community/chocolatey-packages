$packageName = 'flashplayeractivex'
$version = '12.0.0.70' # This is the real version of Flash Player ActiveX (is not always the same as the package version)
$registryUninstallRoot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
$registryUninstallRootWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'

function findMsid {
    param([String]$registryUninstallRoot, [string]$keyContentMatch, [string]$version)

    if (Test-Path $registryUninstallRoot) {
        Get-ChildItem -Force -Path $registryUninstallRoot | foreach {
            $currentKey = (Get-ItemProperty -Path $_.PsPath)
            if ($currentKey -match $keyContentMatch -and $currentKey -match $version) {
                return $currentKey.PsChildName
            }
        }
    }

    return $null
}

try {

    $allRight = $true

    $alreadyInstalled = findMsid $registryUninstallRoot 'Adobe Flash Player [\d\.]+ ActiveX' $version
    $alreadyInstalledWow6432 = findMsid $registryUninstallRootWow6432 'Adobe Flash Player [\d\.]+ ActiveX' $version

    if ([System.Environment]::OSVersion.Version -ge '6.2') {
        $allRight = $false
        Write-ChocolateyFailure $packageName 'Your Windows version is not suitable for this package. This package is only for Windows XP to Windows 7'
    }

    if (Get-Process iexplore -ErrorAction SilentlyContinue) {
        $allRight = $false
        Write-ChocolateyFailure $packageName 'Internet Explorer is running. The installation will fail an 1603 error. Close Internet Explorer and reinstall this package.'
    }

    if ($alreadyInstalled -or $alreadyInstalledWow6432) {
        $allRight = $false
        Write-Output "Adobe Flash Player Plugin (ActiveX for IE) $version is already installed."
    } else {
        
    }

    if ($allRight) {
        Install-ChocolateyPackage $packageName 'msi' '/quiet /norestart REMOVE_PREVIOUS=YES' 'http://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_12_active_x.msi'
    }


} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
