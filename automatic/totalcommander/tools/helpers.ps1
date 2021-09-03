function Get-TCInstallArgs() {
    $s = '/AHUG'
    $s += if ($pp.DesktopIcon) { 'D' } else { '' }
    $s += " "
    $s += if ($pp.InstallPath) { $pp.InstallPath } else { '%ProgramFiles%\totalcmd' }
    $s
}

function Set-TCShellExtension() {
    Write-Host "Setting shell extension"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null
    #sp HKCR:\Directory\shell -name "(Default)" -Value "Total_Commander"
    mkdir HKCR:\Directory\shell\Total_Commander\command -force | Out-Null
    Set-ItemProperty HKCR:\Directory\shell\Total_Commander -name "(Default)" -Value "Total Commander"
    Set-ItemProperty HKCR:\Directory\shell\Total_Commander\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""
}

function Set-ExplorerAsDefaultFM() {
    Write-Host "Setting Explorer as default file manager"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null
    'HKCR:\Directory', 'HKCR:\Drive' | ForEach-Object {
        $key = Get-Item $_
        $key = $key.OpenSubKey('shell', 'ReadWriteSubTree')
        $key.DeleteValue('')
    }
}

function Set-TCAsDefaultFM() {
    Write-Host "Setting Total Commander as default file manager"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null

    Set-ItemProperty HKCR:\Drive\shell -name "(Default)" -Value "open"
    mkdir HKCR:\Drive\shell\open\command -force | Out-Null
    Set-ItemProperty HKCR:\Drive\shell\open\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""

    Set-ItemProperty HKCR:\Directory\shell -name "(Default)" -Value "open"
    mkdir HKCR:\Directory\shell\open\command -force | Out-Null
    Set-ItemProperty HKCR:\Directory\shell\open\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""
}

function Get-TCInstallLocation() {
    if ($Env:COMMANDER_PATH) { return $Env:COMMANDER_PATH }

    $key = Get-ItemProperty 'HKLM:\SOFTWARE\Ghisler\Total Commander' -ea 0
    if ($key) { return $key.InstallDir }

    $installLocation = Get-AppInstallLocation totalcmd
    if ($installLocation) { return $installLocation }

    if (Test-Path c:\totalcmd) { return "c:\totalcmd" }
}

function Set-TCIniFilesLocation() {
    Set-ItemProperty 'HKCU:\SOFTWARE\Ghisler\Total Commander' IniFileName '%COMMANDER_PATH%\wincmd.ini'
    Set-ItemProperty 'HKCU:\SOFTWARE\Ghisler\Total Commander' FtpIniName  '%COMMANDER_PATH%\wcx_ftp.ini'
}
