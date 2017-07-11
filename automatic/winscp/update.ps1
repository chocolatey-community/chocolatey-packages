. $PSScriptRoot\..\winscp.install\update.ps1

function global:au_BeforeUpdate { 
    cp  $PSScriptRoot\..\winscp.install\README.md $PSScriptRoot\README.md
}
function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

update -ChecksumFor none -NoCheckUrl