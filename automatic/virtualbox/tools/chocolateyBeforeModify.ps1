$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\Start-ProcessNonElevated.ps1

$packageName = 'virtualbox'

#For acpipowerbutton to work on Windows server see: http://ethertubes.com/unattended-acpi-shutdown-of-windows-server/
#sp HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system shutdownwithoutlogon 1
$shutdown_type = 'poweroff'  # 'acpipowerbutton', 'poweroff', 'savestate'

$pvbox = ps virtualbox -ea 0
if (!$pvbox) {
    Write-Host "$packageName is not running"
    return
}

Write-Host "$packageName is running"

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { $installLocation = gcm VBoxManage.exe -ea 0 | select -expand Path | Split-Path }


if (!($installLocation -and (Test-Path $installLocation))) {
    Write-Warning "Can not find existing installation location of $packageName"
    return
}

if (!(Test-Path $installLocation\VBoxManage.exe)) {
    Write-Warning "Existing installation of $packageName found but unable to find VBoxManage.exe"
    return
}

$commands = "Set-Alias vboxmanage '$installLocation\VBoxManage.exe'`n"
$commands += @'
[string[]] $runningvms = vboxmanage list runningvms
if ($LastExitCode -ne 0) { Write-Error "Error running vboxmanage - can't get running vms" }
if ($runningvms -and ($runningvms.Length -eq 0)) { Write-Host "No running machines" }

Write-Host 'Number of machines running:' $runningvms.Length
foreach ($vm in $runningvms) {
    $vmid = $vm -split ' ' | select -Last 1
    $vmname = $vm.Replace($vmid, '').Trim()

    Write-Host "Shutting down the machine $vmname"
    vboxmanage controlvm $vmid SHUTDOWN_TYPE
    if ($LastExitCode -ne 0) { Write-Error "Error running vboxmanage - can't power down running vm: $vmname" }
    else { Write-Host "Machine $vmname powered down prior to installation using 'SHUTDOWN_TYPE' method" }
}
'@ -replace 'SHUTDOWN_TYPE', $shutdown_type

$res = Start-ProcessNonElevated -Cmd $commands -UsePowershell
$res.out
if ($res.err) { Write-Warning $res.err }

## Doesn't seem to be required
#Write-Host "Killing $packageName process"
#$pvbox | kill
