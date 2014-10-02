$packageName = 'Cygwin'
$installerType = 'exe'
$url = 'http://cygwin.com/setup-x86.exe'
$url64 = 'http://cygwin.com/setup-x86_64.exe'

$binRoot = Get-BinRoot
$cygRoot = join-path $binRoot "cygwin"
$cygPackages = join-path $cygRoot packages

# https://cygwin.com/faq/faq.html#faq.setup.cli
$silentArgs = "-q -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin"
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
