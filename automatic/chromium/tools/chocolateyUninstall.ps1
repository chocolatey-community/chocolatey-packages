	$registry = Get-UninstallRegistryKey -SoftwareName $packageName
	$file = $registry.UninstallString
  $chromiumArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ ($file -contains "system-level") ]
	$myfile = $file -replace( $chromiumArgs )
	# All arguments for the Uninstallation of this package
	$packageArgs = @{
	PackageName = 'Chromium'
	FileType = 'exe'
	SilentArgs = '--uninstall --system-level --force-uninstall'
	validExitCodes =  @(0,19,21)
	File = $myfile
	}
  # Now to Uninstall the Package
  Uninstall-ChocolateyPackage @packageArgs
  # This at the moment does not remove the libs\Chromium folder
