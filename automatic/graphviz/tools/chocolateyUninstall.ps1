$ErrorActionPreference = 'Stop'

# All arguments for the Uninstallation of this package
$packageArgs = @{
  PackageName    = ''
  FileType       = ''
  SilentArgs     = "/S"
  validExitCodes = @(0)
}

$name = ( $packageArgs.packageName -split "-" )[0]
$registry = Get-UninstallRegistryKey -SoftwareName "$name*"
$file = $registry.UninstallString
$packageArgs.Add( "File", $file )
# Now to Uninstall the Package
Uninstall-ChocolateyPackage @packageArgs

@('dot') |ForEach-Object {Install-BinFile $_ "$installLocation\bin\$_.exe"}
