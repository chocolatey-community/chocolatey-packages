. $PSScriptRoot\..\python3-streams\update.ps1

if ($MyInvocation.InvocationName -ne '.') {
  function global:au_SearchReplace {
    @{
      ".\README.md" = @{
        "(?i)(install the package )\[python\d+]\((.*)python\d+" = "`$1[$($Latest.Dependency)](`$2$($Latest.Dependency)"
        "(?i)(the package )``python\d+``( must also)"           = "`$1``$($Latest.Dependency)```$2"
      }
    }
  }
}

function global:au_BeforeUpdate {
  SetCopyright
}

function global:au_AfterUpdate($Package) {
  Set-DescriptionFromReadme $Package -SkipFirst 2
  Update-Metadata -data @{
    dependency = "$($Latest.Dependency)|[$($Latest.Version)]"
    copyright  = $Latest.Copyright
    licenseUrl = $Latest.LicenseUrl
  }
}

function global:au_GetLatest {
  $streams = GetReleaseFilesStreams
  $streams.Keys | ForEach-Object {
    $item = $streams[$_]
    $pkgName = $item.PackageName
    $item.Remove('PackageName') | Out-Null
    $item.Remove('Title') | Out-Null
    $item['Dependency'] = $pkgName
  }


  @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none -NoReadme
}
