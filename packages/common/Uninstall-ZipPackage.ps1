function Uninstall-ZipPackage {
param(
  [string] $packageName
)
	if(!$packageName) {
		Write-ChocolateyFailure "Uninstall-ZipPackage" "Missing PackageName input parameter."
		return
	}
	
	ChildItem "$env:ChocolateyInstall\lib\${packageName}" -Recurse -Filter "${packageName}Install.zip.txt" | 
	ForEach-Object{ $installLocation = (Get-Content $_.FullName | Select-Object -First 1);
		if (("$installLocation" -match "${packageName}|apache-tomcat") -and (Test-Path -Path "$installLocation")) {
			Write-Host "Uninstalling by removing directory $installLocation";
			Remove-Item -Recurse -Force "$installLocation"
		} else {
			Write-ChocolateyFailure "Uninstall-ZipPackage" "Unable to delete directory: $installLocation"
		}
	}
}