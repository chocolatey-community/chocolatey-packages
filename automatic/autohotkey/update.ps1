import-module au

#Virtual package uses dependency updater to get the version
. $PSScriptRoot\..\autohotkey.install\update.ps1

function global:au_SearchReplace {
  @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
 }

# Left empty intentionally to override BeforeUpdate in autohotkey.install
 function global:au_BeforeUpdate { }

update -ChecksumFor none
