import-module au

$releases = 'https://www.gyan.dev/ffmpeg/builds'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest   {
  $version = Invoke-WebRequest -Uri "$releases/release-version"

  @{
    URL64 = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.7z";
    Version = $version
  }
}

update -ChecksumFor none
