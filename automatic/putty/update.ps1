. $PSScriptRoot\..\putty.portable\update.ps1

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).portable`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

update -ChecksumFor none
