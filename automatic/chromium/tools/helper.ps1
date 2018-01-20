
function Get-CompareVersion {
  param(
    [string]$version,
    [string]$notation,
    [string]$package
  )
	$vorgehen = $true;
    $packver = @{$true = $version; $false = ($version -replace($notation,""))}[ ( $version -notmatch $notation ) ]
    [array]$key = Get-UninstallRegistryKey -SoftwareName "$package*"
    if ($packver -eq ( $key.Version )) {
	  $vorgehen = $false
    }
    return $vorgehen
  }
