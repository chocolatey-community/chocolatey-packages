function Clear-DependenciesList([string]$Path) {
  $nu = Import-Nuspec $Path
  $dependencies = Get-DependenciesElement $nu
  if ($dependencies -and $dependencies.HasChildNodes) {
    $dependencies.RemoveAll() | Out-Null

    Export-Nuspec $Path $nu
  }
}

function Import-Nuspec([string]$Path) {
  $Path = Resolve-Path $Path
  $nu = New-Object xml
  $nu.PSBase.PreserveWhitespace = $true
  $nu.Load($Path)
  return $nu
}

function Get-DependenciesElement([xml]$nu) {
  return $nu.package.metadata.GetElementsByTagName('dependencies') | Select-Object -First 1
}

function Export-Nuspec([string]$Path, [xml]$nu) {
  $Path = Resolve-Path $Path
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  $xml = $nu.InnerXml
  [System.IO.File]::WriteAllText($Path, $xml, $utf8NoBom)
}
