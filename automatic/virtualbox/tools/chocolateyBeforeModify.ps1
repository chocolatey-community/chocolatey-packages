$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'virtualbox'

#For acpipowerbutton to work on Windows server see: http://ethertubes.com/unattended-acpi-shutdown-of-windows-server/
#sp HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system shutdownwithoutlogon 1
$shutdown_type = 'savestate'  # 'acpipowerbutton', 'poweroff', 'savestate'

$pvbox = ps virtualbox -ea 0
if (!$pvbox) {
    Write-Host "$packageName is not running"
    return
}

Write-Host "$packageName is running, trying to gracefully shutdown any running machines"

$installLocation = Get-VirtualBoxIntallLocation
if (!$installLocation) { Write-Warning "Can not find existing installation location of $packageName"; return }
if (!(Test-Path $installLocation\VBoxManage.exe)) { Write-Warning "Existing installation of $packageName found but unable to find VBoxManage.exe"; return }

$commands = "Set-Alias vboxmanage '$installLocation\VBoxManage.exe'`n"
$commands += @'
[string[]] $runningvms = vboxmanage list runningvms 2>&1
if ($LastExitCode -ne 0) { Write-Error "Error running vboxmanage - can't get running vms" }
if ($runningvms -and ($runningvms.Length -eq 0)) { "No running machines"; return }

'Number of machines running: ' + $runningvms.Length
foreach ($vm in $runningvms) {
    $vmid = $vm -split ' ' | select -Last 1
    $vmname = $vm.Replace($vmid, '').Trim()

    Write-Host "Shutting down the machine $vmname"
    vboxmanage controlvm $vmid SHUTDOWN_TYPE 2>$null
    if ($LastExitCode -ne 0) { Write-Error "Error running vboxmanage - can't power down running vm: $vmname" }
    else { "Machine $vmname powered down prior to installation using 'SHUTDOWN_TYPE' method" }
}
'@ -replace 'SHUTDOWN_TYPE', $shutdown_type

$res = Start-ProcessNonElevated -Cmd $commands -UsePowershell
$res.out -join "`n" | Write-Host
if ($res.err) { "Errors during graceful shutdown`n" + ($res.err -join "`n") | Write-Warning }

## Doesn't seem to be required
#Write-Host "Killing $packageName process"
#$pvbox | kill
