$packageName = 'cygwin' 
$installerType = 'exe'
$url = 'http://www.cygwin.com/setup-x86.exe' 
$url64 = 'http://cygwin.com/setup-x86_64.exe'

$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = $env:chocolatey_bin_root; if ($binRoot -notlike '*:\*') {$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}}
$cygRoot = join-path $binRoot "Cygwin"
$cygPackages = join-path $cygRoot packages

$silentArgs = "-q -N -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin"
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes
$installerFile = join-path $env:Temp 'chocolatey\cygwin\cygwinInstall.exe'

try {
  Install-ChocolateyPath $cygRoot
  Copy-Item "$installerFile" "$cygRoot\cygwinsetup.exe" -Force

  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}