function Set-TCParameters() {
    $pp = Get-PackageParameters
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
    if ($LastExitCode) { throw "Error executing 7za to unzip totalcmd exe - exit code $exitCode." }

    Write-Verbose "Extract installer"
    $instFile  = gi $toolsPath\*.zip
    7za x -y "-o$($tcmdWork)" $instFile
    if ($LastExitCode) { throw "Error executing 7za to unzip totalcmd installer - exit code $exitCode." }

    if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
        Write-Host "Installing 64 bit version"
        mv $tcmdWork\INSTALL64.exe  $tcmdWork\INSTALL.exe -Force
    } else {
        Write-Host "Installing 32 bit version"
    }
}
