param(
	[string]$package
)

$binRoot = "$env:systemdrive\"
if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
$cygRoot = join-path $binRoot "Cygwin"
$cygPackages = join-path $cygRoot packages

if($package -eq "default") {
	& cygwininstaller -q -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin
} elseif ($package -eq "" -or $package -eq $null) {
	write-output "specify a package name or 'default' to install all of the base packages"
} else {
	& cygwininstaller -q -R $cygRoot -l $cygPackages -s ftp://mirrors.kernel.org/sourceware/cygwin -P $package
}
