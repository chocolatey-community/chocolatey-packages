
# remove the service if it exists
if ((Get-Service | Where-Object { $_.Name -eq "etcd" }).length) {
    Get-Service etcd | Stop-Service
    &nssm remove etcd confirm
}
