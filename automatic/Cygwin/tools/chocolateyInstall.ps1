# Set the default install path to Bin-Root
$binRoot = Get-BinRoot
$cygRoot = Join-Path $binRoot 'cygwin'
$alreadyInstalled = Test-Path 'HKLM:\SOFTWARE\Cygwin\setup'

# https://cygwin.com/faq/faq.html#faq.setup.cli
$silentArgs = @(
  "--quiet-mode"
  "--site http://mirrors.kernel.org/sourceware/cygwin/"
  "--no-desktop"
  "--packages default"
)

# Arguments only for the first installation, otherwise these values are already set
if (!$alreadyInstalled) {
  $silentArgs += @(
    "--root $cygRoot"
    "--local-package-dir $cygRoot"
    )
}
else {
    # Configure --local-package-dir for subsequent or pre-existing installs
    # (otherwise they get dropped in $ENV:ChocolateyInstall)
    $cygRoot = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup').rootdir
    $silentArgs += "--local-package-dir $cygRoot"
}

$packageArgs = @{
  packageName            = 'Cygwin'
  fileType               = 'exe'
  url                    = 'https://cygwin.com/setup-x86.exe'
  url64bit               = 'https://cygwin.com/setup-x86_64.exe'
  checksum               = '5540542d7fa1d1f13453e7a250c1c6de44a6a794e81ffde0dfea6b5689dbc052'
  checksum64             = '446b658bc1b8b6c7865474188cb4d7e9873003e2b6a9d74dcdfb7a3ff77e8634'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = $silentArgs
  validExitCodes         = @(0)
  softwareName           = 'Cygwin*'
}
Install-ChocolateyPackage @packageArgs
Install-BinFile -Name "Cygwin" -Path "$cygRoot\Cygwin.bat"
