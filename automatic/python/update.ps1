. $PSScriptRoot\..\python3\update.ps1

function global:au_SearchReplace {
   @{
        ".\README.md" = @{
            "(?i)(install the package )\[python\d+]\((.*)python\d+" = "`$1[$($Latest.Dependency)](`$2$($Latest.Dependency)"
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+? version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

update -ChecksumFor none
