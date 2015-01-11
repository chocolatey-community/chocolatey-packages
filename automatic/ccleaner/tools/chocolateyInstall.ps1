$packageName = '{{PackageName}}'
$installerType = 'EXE'
$LCID = (Get-Culture).LCID
$url = '{{DownloadUrl}}'
$silentArgs = '/S /L=$LCID'

# Please test every new version of CCleaner for possible adware/spyware/crapware which installs silently together with Piriform software products.
# Only push the new package to the gallery if you are 100% sure that this package prevents the install of the bundled adware.
$regAdd = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\regAdd.ps1"

$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

	# This adds a registry key which prevents Google Chrome from getting installed together with Piriform software products.
	Start-ChocolateyProcessAsAdmin "& `'$regAdd`'"

	Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
			
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}







