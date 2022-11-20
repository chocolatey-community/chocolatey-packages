$registry = Get-UninstallRegistryKey -SoftwareName "brave*"
$file = $registry.UninstallString
$Arg_chk = ($file -match "--system-level")
$braveArgs = @{$true = "--uninstall --system-level"; $false = "--uninstall"}[ $Arg_chk ]
$silentArgs = @{$true = '--uninstall --system-level --force-uninstall'; $false = '--uninstall --force-uninstall'}[ $Arg_chk ]
$myfile = $file -replace ( $braveArgs )
# All arguments for the Uninstallation of this package
$packageArgs = @{
  PackageName    = 'Brave'
  FileType       = 'exe'
  SilentArgs     = $silentArgs
  validExitCodes = @(0, 19, 21)
  File           = $myfile
}
# Now to Uninstall the Package
Uninstall-ChocolateyPackage @packageArgs
