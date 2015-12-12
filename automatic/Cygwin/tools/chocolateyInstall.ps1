$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$validExitCodes = @(0)

# Set the default install path to the package folder
$PSScriptRoot = Split-Path -parent $MyInvocation.MyCommand.Definition
$cygRoot = Join-Path $PSScriptRoot 'cygwin'
$cygWinSetupFile = Join-Path $cygRoot 'cygwinsetup.exe'
$cygPackages = Join-Path $cygRoot packages

if (!(Test-Path($cygRoot))) {
  [System.IO.Directory]::CreateDirectory($cygRoot) | Out-Null
}

Get-ChocolateyWebFile $packageName $cygWinSetupFile $url $url64

# https://cygwin.com/faq/faq.html#faq.setup.cli
$silentArgs = $(
  "--quiet-mode " +
  "-s http://mirrors.kernel.org/sourceware/cygwin/ " +
  "--packages default"
)

# These install arguments are only appended to the silent args
# if Cygwin is installed for the first time, otherwise these
# values are already set.
$firstInstallArgs = $(
  "--root $cygRoot " +
  "--local-package-dir $cygPackages"
)

# Check if Cygwin is already installed
$alreadyInstalled = Test-Path 'HKLM:\SOFTWARE\Cygwin\setup'

if (!$alreadyInstalled) {
  $silentArgs = $silentArgs + ' ' + $firstInstallArgs

  Install-ChocolateyPath $cygRoot 'Machine'
  $env:Path = "$($env:Path);$cygRoot"
}

Install-ChocolateyInstallPackage $packageName $installerType $silentArgs `
  $cygWinSetupFile -validExitCodes $validExitCodes

# Create .ignore files for exe files
Get-ChildItem -Path $cygRoot -Recurse | Where {
  $_.Extension -eq '.exe'} | % {
  New-Item $($_.FullName + '.ignore') -Force -ItemType file
# Suppress output of New-Item
} | Out-Null
