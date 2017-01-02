. $PSScriptRoot\..\git-lfs.install\update.ps1

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(<releaseNotes>https:\/\/github.com\/git-lfs\/git-lfs\/releases\/tag\/v)(.*)(<\/releaseNotes>)" = "`${1}$($Latest.Version.ToString())`$3"
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

update -ChecksumFor none