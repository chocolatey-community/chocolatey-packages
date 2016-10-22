$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$validExitCodes = @(0)

# Set the default install path to Bin-Root
$binRoot = Get-BinRoot
$cygRoot = Join-Path $binRoot 'cygwin'

# https://cygwin.com/faq/faq.html#faq.setup.cli
$silentArgs = $(
  "--quiet-mode " +
  "--site http://mirrors.kernel.org/sourceware/cygwin/ " +
  "--no-desktop" +
  "--packages default"
)

# These install arguments are only appended to the silent args
# if Cygwin is installed for the first time, otherwise these
# values are already set.
$firstInstallArgs = $(
  "--root $cygRoot " +
  "--local-package-dir $cygRoot"
)

# Check if Cygwin is already installed
$alreadyInstalled = Test-Path 'HKLM:\SOFTWARE\Cygwin\setup'

if (!$alreadyInstalled) {
  $silentArgs = $silentArgs + ' ' + $firstInstallArgs
}
# Configure --local-package-dir for subsequent or pre-existing installs
# (otherwise they get dropped in $ENV:ChocolateyInstall)
Else {
  $cygRoot = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup').rootdir
  $silentArgs = $silentArgs + ' ' + "--local-package-dir $cygRoot"
}

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
Install-BinFile -Name "Cygwin" -Path "$cygRoot\Cygwin.bat"
