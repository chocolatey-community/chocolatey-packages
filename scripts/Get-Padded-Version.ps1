function Get-Padded-Version() {
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Version,
    [Parameter(Position = 1)]
    [version]$OnlyBelowVersion = $null
  )

  if ($Version -match "^([\d]+\.){1,2}[\d]+$") {
    Write-Debug "There is no need to pad the version information"
    return $Version
  } elseif ($Version -notmatch "^[\d\.]+$") {
    Write-Warning "Padding of pre release versions is not supported";
    return $Version
  }

  $Matches = $null

  if ($OnlyBelowVersion -ne $null -and ([version]$Version) -ge $OnlyBelowVersion) {
    return $Version;
  }

  $versionInfo = [version]$Version
  $revision = $versionInfo.Revision
  $paddedRev = [int]($revision.ToString().PadRight(6, '0'));

  if ($global:au_force -eq $true) {
    Write-Debug "Loading nuspec file to see if we need to pad the version"
    $content = gc -Encoding UTF8 (Resolve-Path "*.nuspec");
    $content | ? { $_ -match "\<version\>([\d\.]+)\<\/version\>" } | Out-Null
    if ($Matches) {
      $newVersion = [version]$Matches[1]
      $paddedNewRev = [int]$newVersion.Revision.ToString().PadRight(6, '0')
      while ($paddedRev -le $paddedNewRev) {
        $paddedRev++ | Out-Null
      }
    }
  }

  return $versionInfo.ToString() -replace '^([\d]+\.[\d]+\.[\d]+\.)\d+$',"`${1}$paddedRev"
}
