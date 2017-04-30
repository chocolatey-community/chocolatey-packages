function Set-TCParameters() {
    $localUser   = 'UserName='  + $(if ($pp.LocalUser)   { '' }  else { '*' })
    $desktopIcon = 'mkdesktop=' + $(if ($pp.DesktopIcon) { '1' } else { '0' })
    $installPath = 'Dir='       + $(if ($pp.InstallPath) { $pp.InstallPath } else { '%ProgramFiles%\totalcmd' })

    $installInf = Join-Path $tcmdWork "INSTALL.INF"
    (Get-Content $installInf)   -Replace 'UserName=',        $localUser `
                                -Replace 'auto=0',           'auto=1' `
                                -Replace 'hidden=0',         'hidden=1' `
                                -Replace 'mkdesktop=1',      $desktopIcon `
                                -Replace 'Dir=c:\\totalcmd', $installPath | Set-Content $installInf
}

function Extract-TCFiles() {
    Write-Verbose "Extract EXE to change install options"
    $setupFile = gi $toolsPath\*.exe
    7za x -y "-o$($tcmdWork)" $setupFile
    if ($LastExitCode) { throw "Error executing 7za to unzip totalcmd exe - exit code $LastExitCode." }

    Write-Verbose "Extract installer"
    $instFile  = gi $toolsPath\*.zip
    7za x -y "-o$($tcmdWork)" $instFile
    if ($LastExitCode) { throw "Error executing 7za to unzip totalcmd installer - exit code $LastExitCode." }

    if ($is64) {
        mv $tcmdWork\INSTALL64.exe  $tcmdWork\INSTALL.exe -Force
        mv $tcmdWork\INSTALL64.inf  $tcmdWork\INSTALL.inf -Force
    }
}

function Set-TCShellExtension() {
    Write-Host "Setting shell extension"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null
    #sp HKCR:\Directory\shell -name "(Default)" -Value "Total_Commander"
    mkdir HKCR:\Directory\shell\Total_Commander\command -force | Out-Null
    sp HKCR:\Directory\shell\Total_Commander -name "(Default)" -Value "Total Commander"
    sp HKCR:\Directory\shell\Total_Commander\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""
}

function Set-ExplorerAsDefaultFM() {
    Write-Host "Setting Explorer as default file manager"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null
    'HKCR:\Directory', 'HKCR:\Drive' | % {
        $key = gi $_
        $key = $key.OpenSubKey('shell', 'ReadWriteSubTree')
        $key.DeleteValue('')
    }
}

function Set-TCAsDefaultFM() {
    Write-Host "Setting Total Commander as default file manager"

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT -ea 0 | Out-Null

    sp HKCR:\Drive\shell -name "(Default)" -Value "open"
    mkdir HKCR:\Drive\shell\open\command -force | Out-Null
    sp HKCR:\Drive\shell\open\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""

    sp HKCR:\Directory\shell -name "(Default)" -Value "open"
    mkdir HKCR:\Directory\shell\open\command -force | Out-Null
    sp HKCR:\Directory\shell\open\command  -name "(Default)" -Value "$installLocation\$tcExeName /O ""%1"""
}

function Get-TCInstallLocation() {
    if ($Env:COMMANDER_PATH) { return $Env:COMMANDER_PATH }

    $key = gp 'HKLM:\SOFTWARE\Ghisler\Total Commander' -ea 0
    if ($key) { return $key.InstallDir }

    $installLocation = Get-AppInstallLocation totalcmd
    if ($installLocation) { return $installLocation }

    if (Test-Path c:\totalcmd) { return "c:\totalcmd" }
}

function Set-TCIniFilesLocation() {
    sp 'HKCU:\SOFTWARE\Ghisler\Total Commander' IniFileName '%COMMANDER_PATH%\wincmd.ini'
    sp 'HKCU:\SOFTWARE\Ghisler\Total Commander' FtpIniName  '%COMMANDER_PATH%\wcx_ftp.ini'
}
