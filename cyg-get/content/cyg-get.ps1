param(
    [string]$package
    )

$module = join-path $env:ChocolateyInstall 'chocolateyinstall\helpers\chocolateyInstaller.psm1'
import-module "$module"

# $toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
# $contentDir = $($toolsDir | Split-Path | Join-Path -ChildPath "content")
$contentDir = split-path -parent $MyInvocation.MyCommand.Definition
$installer = join-path $contentDir 'CygwinInstaller.exe'

Get-ChocolateyWebFile 'cyg-get' $installer 'http://www.cygwin.com/setup_x86.exe'

$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$cygRoot = join-path $binRoot "Cygwin"
$cygPackages = join-path $cygRoot packages

if($package -eq "default") {
  & $installer -q -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin
} elseif ($package -eq "" -or $package -eq $null) {
  write-output "specify a package name or 'default' to install all of the base packages"
} else {
  & $installer -q -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin -P $package
}
