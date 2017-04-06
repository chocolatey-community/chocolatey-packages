function OverwriteParameters {
	$arguments = @{};
	$packageParameters = $env:chocolateyPackageParameters;

	if($packageParameters) {
		Write-Host "PackageParameters: $packageParameters"
		$MATCH_PATTERN = "/([a-zA-Z]+)=(.*)"
		$PARAMATER_NAME_INDEX = 1
		$VALUE_INDEX = 2
		
		if($packageParameters -match $MATCH_PATTERN){
			$results = $packageParameters | Select-String $MATCH_PATTERN -AllMatches 
			
			$results.matches | % { 
			$arguments.Add(
				$_.Groups[$PARAMATER_NAME_INDEX].Value.Trim(),
				$_.Groups[$VALUE_INDEX].Value.Trim())
			}
		} else {
			Write-Host "Default packageParameters will be used"
		}
		
		if($arguments.ContainsKey("InstallLocation")) {
			$global:installLocation = $arguments["InstallLocation"];
			
			Write-Host "Value variable installLocation changed to $global:installLocation"
		} else {
			Write-Host "Default InstallLocation will be used"
		}
	} else {
		Write-Host "Package parameters will not be overwritten"
	}
}