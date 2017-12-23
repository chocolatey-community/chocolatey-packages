
function Get-CompareVersion {
  param(
    [string]$version,
    [string]$notation,
    [string]$package
  )
    $packver = @{$true = $version; $false = ($version -replace($notation,""))}[ ( $version -notmatch $notation ) ]
    [array]$key = Get-UninstallRegistryKey -SoftwareName "$package*"
    if ($packver -eq ( $key.Version )) {
      Write-Host "$package $version is already installed."
      return
    }
  }
