. $PSScriptRoot\..\python3\update.ps1

function global:au_SearchReplace {
   @{
        ".\README.md" = @{
            "(?i)(install the package )\[python\d+]\((.*)python\d+" = "`$1[$($Latest.Dependency)](`$2$($Latest.Dependency)"
        }
    }
}

function global:au_AfterUpdate($Package) {
  Set-DescriptionFromReadme $Package -SkipFirst 2
  Update-Metadata -data @{
    dependency = "python3|[$($Latest.Version)]"
    copyright  = $Latest.Copyright
    licenseUrl = $Latest.LicenseUrl
  }
}

update -ChecksumFor none -NoReadme
