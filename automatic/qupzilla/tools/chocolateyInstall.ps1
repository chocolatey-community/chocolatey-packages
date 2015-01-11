$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$uninstallRegistryPath_x86 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\QupZilla"
$uninstallRegistryPath_x64 = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\QupZilla"
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$mantainer = 'tonigellida'

try {

	$processor = Get-WmiObject Win32_Processor
	$is64bit = $processor.AddressWidth -eq 64
	
	if ($is64bit) {
	
 		if (Test-Path $uninstallRegistryPath_x64) {
			$installedVersion = (Get-ItemProperty $uninstallRegistryPath_x64).DisplayVersion
		}

	} else {
  
		if (Test-Path $uninstallRegistryPath_x86) {
			$installedVersion = (Get-ItemProperty $uninstallRegistryPath_x86).DisplayVersion
		}	
		
	}
	
	if ($installedVersion -gt $version) {
		Write-Host "Your $packageName $installedVersion is higher than the $version proporcionated by chocolatey repo."
		Write-Host "Please wait or contact the mantainer $mantainer to update this package."
		Write-Host "When the package is updated try another time. Thanks."
		
	}elseif ($installedVersion -eq $version) {
		Write-Host "$packageName $version is already installed."
		
	} else {

        # Download and install the program

		Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
		
		}
	
	Write-ChocolateySuccess $packageName
	
} catch {

		Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
		throw 
}