$packageName = 'virtualbox'

$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { $installLocation = Split-Path (gcm VBoxManage.exe -ea 0).Path }
if (!($installLocation -and (Test-Path $installLocation))) { return }

Set-Alias vboxmanage $installLocation\VBoxManage.exe
if (!(Test-Path $installLocation\VBoxManage.exe)) {
    Write-Warning "Existing installation of $packageName found but unable to find VBoxManage.exe"
    return
}

$runningvms = vboxmanage list runningvms
if ($LastExitCode -ne 0) { Write-Warning "Error running vboxmanage - can't get running vms" }
foreach ($vm in $runningvms) {
     $vmid = $vm -split ' ' | select -Last 1
     $vmname = $vm.Replace($vmdid, '').Trim()
     vboxmanage controlvm $vmid acpipowerbutton
     if ($LastExitCode -ne 0) { Write-Warning "Error running vboxmanage - can't power down running vm: $vmname" }
     Write-Host "Machine $vmname shut down prior to installation"
}

ps virtualbox -ea 0 | kill
