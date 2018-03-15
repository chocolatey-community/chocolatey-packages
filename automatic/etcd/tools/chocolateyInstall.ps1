$ErrorActionPreference = 'Stop'

$packageName = 'etcd'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$installLocation = "C:\ProgramData\etcd"


$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\etcd-*.zip
  Destination    = $installLocation
}
Get-ChocolateyUnzip @packageArgs

Copy-Item "$installLocation\etcd-*-windows-amd64\*" $installLocation -Recurse -Force
Remove-Item "$installLocation\etcd-*-windows-amd64" -Recurse -Force
# Install-ChocolateyPath "$installLocation"

# older versions of etcd didn't put .exe on the binary
if (Test-Path "$installLocation\etcd") {
    Copy-Item "$installLocation\etcd" "$installLocation\etcd.exe" -Force
    Remove-Item "$installLocation\etcd"
}
if (Test-Path "$installLocation\etcdctl") {
    Copy-Item "$installLocation\etcdctl" "$installLocation\etcdctl.exe" -Force
    Remove-Item "$installLocation\etcdctl"
}

Copy-Item "$installLocation\etcdctl.exe" $toolsPath -Force

&nssm install etcd "$installLocation\etcd.exe" "$($env:chocolateyPackageParameters)"
&nssm set etcd Start SERVICE_AUTO_START
