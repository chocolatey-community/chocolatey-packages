Function getDropboxRegProps() {
 
  [array]$props = Get-UninstallRegistryKey -SoftwareName "Dropbox" # This will use Chocolatey Helper Get-UninstallRegistryKey to get all registry keys for Dropbox

  return $props
}
