$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$uninstallRegistryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Songr"
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$mantainer = 'tonigellida'

try {
 	if (Test-Path $uninstallRegistryPath) {
		$installedVersion = (Get-ItemProperty $uninstallRegistryPath).DisplayVersion
	}
	
	if ($installedVersion -gt $version) {
		Write-Host "Your $packageName $installedVersion is higher than the $version proporcionated by chocolatey repo."
		Write-Host "Please wait or contact the mantainer $mantainer to update this package."
		Write-Host "When the package is updated try another time. Thanks."
		
	}elseif ($installedVersion -eq $version) {
		Write-Host "$packageName $version is already installed."
		
	} else {

        # Download and install the program

		$chocTempDir = Join-Path $env:TEMP 'chocolatey'
	    $tempDir = Join-Path $chocTempDir "$packageName"

	    # Download and extract installer
	    Install-ChocolateyZipPackage "$packageName" "$url" $tempDir
	  
	    # Run the installer
	    $installer = Join-Path $tempDir '*.exe'
	    Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$installer" -validExitCodes $validExitCodes
		
		}
	
	Write-ChocolateySuccess $packageName
	
} catch {

		Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
		throw 
}