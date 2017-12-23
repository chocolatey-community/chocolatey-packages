import-module au

function global:au_BeforeUpdate {
  Copy-Item "$PSScriptRoot\..\win10mct\Readme.md" "$PSScriptRoot" -Force -Recurse
}

function global:au_SearchReplace {
   @{
        ".\windows10-media-creation-tool.nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName)`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
}

function global:au_GetLatest {
    @{
	  PackageName = "win10mct"
      Version = Get-Content "$PSScriptRoot\..\win10mct\info" -Encoding UTF8 | select -First 1 | % { $_ -split '\|' } | select -Last 1
    }

}

    update -ChecksumFor none
