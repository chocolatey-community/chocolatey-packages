$installPkgUpdateScript = Join-Path -Path (
  Split-Path -Path $PSScriptRoot -Parent
) -ChildPath (Join-Path -Path 'ruby.install' -ChildPath 'update.ps1')
. ${installPkgUpdateScript}

function global:au_BeforeUpdate {}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+? version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

update -ChecksumFor none
