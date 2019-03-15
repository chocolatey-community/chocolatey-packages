function getDropboxRegProps() {
	<# 
		This makess use of the Chocolatey Helper Get-UninstallRegistryKey
		Using this helper will make available to this Package all necessary
		Registry Keys needed for update/upgrade/un/install
	#>
    $props = ( Get-UninstallRegistryKey -SoftwareName "Dropbox" )

    return $props
 }
