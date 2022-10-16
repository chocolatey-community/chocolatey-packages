function Add-Dependency([string]$Path, [string]$id, [string]$version) {
  $nu = Import-Nuspec $Path
  $dependencies = Get-DependenciesElement $nu
  if (!$dependencies) {
    $dependencies = $nu.CreateElement('dependencies')
    $nu.package.metadata.AppendChild($dependencies) | Out-Null
  }

  if (!(Test-HasDependency -dependenciesElement $dependencies -id $id)) {
    $dependency = $nu.CreateElement('dependency')
    $dependency.SetAttribute('id', $id) | Out-Null
    if ($version) {
      $dependency.SetAttribute('version', $version) | Out-Null
    }
    $dependencies.AppendChild($dependency) | Out-Null

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

function Test-HasDependency([System.Xml.XmlElement] $dependenciesElement, $id) {
  $childElements = $dependenciesElement.GetElementsByTagName('dependency') | ? { $_.id -eq $id }
  return $null -ne $childElements
}

function Export-Nuspec([string]$Path, [xml]$nu) {
  $Path = Resolve-Path $Path
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  $xml = $nu.InnerXml
  [System.IO.File]::WriteAllText($Path, $xml, $utf8NoBom)
}
