function Get-VirtualBoxIntallLocation() {
    Write-Verbose 'Checking VBOX_MSI_INSTALL_PATH'
    if ( $installLocation = $Env:VBOX_MSI_INSTALL_PATH ) {
        if (Test-Path $installLocation) { return }
    }

    Write-Verbose 'Checking Get-AppInstallLocation'
    if ( $installLocation = Get-AppInstallLocation 'virtualbox') { return }
}

#http://stackoverflow.com/questions/40863475/starting-non-elevated-prompt-from-elevated-session
function Start-ProcessNonElevated( [string] $Cmd, [switch]$UsePowerShell ) {
    $svc = gsv Schedule -ea 0
    if ($svc -and $svc.Status -ne 'Running') { throw 'Start-ProcessNonElevated requires running Task Scheduler service' }

    $res = @{}

    $tmp_base  = [System.IO.Path]::GetTempFileName()
    $tmp_base  = $tmp_base -replace '\.tmp$'
    $tmp_name  = Split-Path $tmp_base -Leaf
    $task_name = "Start-ProcessNonElevated-$tmp_name"
    Write-Verbose "Temporary files: $tmp_base"

    if ($UsePowershell) {
        @(
            '$r = "{0}"' -f $tmp_base
            ". {{`n{0}`n}} >`"`$r.out.log`" 2>`"`$r.err.log`"" -f $Cmd
        ) -join "`n" | Out-String | Out-File "$tmp_base.ps1"
        $cmd = "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -NoLogo -NonInteractive -File '$tmp_base.ps1'"
    }

    Write-Verbose "Creating scheduled task for command:`n$cmd"
    schtasks.exe /Create /RU $Env:USERNAME /TN $task_name /SC ONCE /ST 00:00 /F /TR $cmd *> "$tmp_base.schtasks.log"
    schtasks.exe /run /tn $task_name *>> "$tmp_base.schtasks.log"

    Write-Verbose 'Waiting for scheduled task to finish'
    do {
        $status = schtasks /query /tn $task_name /FO csv | ConvertFrom-Csv | select -expand Status
        sleep 1
    }
    until ($status -eq 'Ready')
    schtasks.exe /delete /F /tn $task_name *>> "$tmp_base.schtasks.log"

    if ($UsePowershell) {
        $res = @{
            out = cat "$tmp_base.out.log" -ea 0
            err = cat "$tmp_base.err.log" -ea 0
        }
    }

    return $res
}

