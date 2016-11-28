$packageName = 'virtualbox'
$pvbox = ps virtualbox -ea 0
if (!$pvbox) {
    Write-Host "$packageName is not running"
    return
}

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { $installLocation = Split-Path (gcm VBoxManage.exe -ea 0).Path }

if (!($installLocation -and (Test-Path $installLocation))) {
    Write-Warning "Can not find existing installation of $packageName"
} else {

    Set-Alias vboxmanage $installLocation\VBoxManage.exe
    if (!(Test-Path $installLocation\VBoxManage.exe)) {
        Write-Warning "Existing installation of $packageName found but unable to find VBoxManage.exe"
    } else {

        $runningvms = vboxmanage list runningvms
        if ($LastExitCode -ne 0) { Write-Warning "Error running vboxmanage - can't get running vms" }
        else {
            foreach ($vm in $runningvms) {
                $vmid = $vm -split ' ' | select -Last 1
                $vmname = $vm.Replace($vmdid, '').Trim()
                vboxmanage controlvm $vmid acpipowerbutton
                if ($LastExitCode -ne 0) { Write-Warning "Error running vboxmanage - can't power down running vm: $vmname" }
                else { Write-Host "Machine $vmname powered down prior to installation" }
            }
        }
    }
}

Write-Host 'Virtualbox is running, killing it prior to update'
$pvbox | kill
