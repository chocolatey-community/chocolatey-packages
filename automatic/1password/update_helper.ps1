function LoadXml([string]$Path) {
  $Path = Resolve-Path $Path
  $nu = New-Object xml
  $nu.PSBase.PreserveWhitespace = $true
  $nu.Load($Path)
  return $nu
}

function SaveXml([string]$Path, [xml]$nu) {
  $Path = Resolve-Path $Path
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  $xml = $nu.InnerXml
  [System.IO.File]::WriteAllText($Path, $xml, $utf8NoBom)
}

function GetDependenciesElement([xml]$nu) {
  return $nu.package.metadata.GetElementsByTagName('dependencies') | Select-Object -first 1
}

function HasDependency([System.Xml.XmlElement] $dependenciesElement, $id) {
  $childElements = $dependenciesElement.GetElementsByTagName('dependency') | Where-Object { $_.id -eq $id }
  return $childElements -ne $null
}

function addDependency([string]$Path, [string]$id, [string]$version) {
  $nu = LoadXml $Path
  $dependencies = GetDependenciesElement $nu
  if (!$dependencies) {
    $dependencies = $nu.CreateElement('dependencies', 'http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd')
    $nu.package.metadata.AppendChild($dependencies) | Out-Null
  }

  if (!(HasDependency -dependenciesElement $dependencies -id $id)) {
    $dependency = $nu.CreateElement('dependency', 'http://schemas.microsoft.com/packaging/2015/06/nuspec.xsd')
    $dependency.SetAttribute('id', $id) | Out-Null
    if ($version) {
      $dependency.SetAttribute('version', $version) | Out-Null
    }
    $dependencies.AppendChild($dependency) | Out-Null

    SaveXml $Path $nu
  }
}

function removeDependencies([string]$Path) {
  $nu = LoadXml $Path
  $dependencies = GetDependenciesElement $nu
  if ($dependencies -and $dependencies.HasChildNodes) {
    $dependencies.RemoveAll() | Out-Null

    SaveXml $Path $nu
  }
}
